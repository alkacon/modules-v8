/*
 * File   : $Source$
 * Date   : $Date$
 * Version: $Revision$
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2009 Alkacon Software (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package com.alkacon.bootstrap.solr.client.widgets;

import com.alkacon.bootstrap.solr.client.CmsSolrConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.solr.client.CmsSolrConfig.WIDGET_TYPES;
import com.alkacon.bootstrap.solr.client.CmsSolrController;
import com.alkacon.bootstrap.solr.client.CmsSolrDocumentList;
import com.alkacon.bootstrap.solr.client.CmsSolrStringUtil;

import com.google.gwt.event.dom.client.ClickEvent;
import com.google.gwt.event.dom.client.ClickHandler;
import com.google.gwt.event.dom.client.KeyCodes;
import com.google.gwt.event.dom.client.KeyUpEvent;
import com.google.gwt.event.dom.client.KeyUpHandler;
import com.google.gwt.event.logical.shared.SelectionEvent;
import com.google.gwt.event.logical.shared.SelectionHandler;
import com.google.gwt.user.client.DOM;
import com.google.gwt.user.client.Element;
import com.google.gwt.user.client.Event;
import com.google.gwt.user.client.EventListener;
import com.google.gwt.user.client.ui.Button;
import com.google.gwt.user.client.ui.FlowPanel;
import com.google.gwt.user.client.ui.HTMLPanel;
import com.google.gwt.user.client.ui.RootPanel;
import com.google.gwt.user.client.ui.SuggestBox;
import com.google.gwt.user.client.ui.SuggestOracle;
import com.google.gwt.user.client.ui.SuggestOracle.Suggestion;
import com.google.gwt.user.client.ui.TextBox;
import com.google.gwt.user.client.ui.Widget;

/**
 * Search field input for the header element, creates an input field for the search.<p>
 */
public class CmsAutoCompleteWidget extends A_CmsSearchWidget {

    /**
     * A suggest oracle implementation that is suggesting all its entries.<p>
     */
    public class AllSuggestionOracle extends SuggestOracle {

        /**
         * @see com.google.gwt.user.client.ui.SuggestOracle#requestSuggestions(com.google.gwt.user.client.ui.SuggestOracle.Request, com.google.gwt.user.client.ui.SuggestOracle.Callback)
         */
        @Override
        public void requestSuggestions(Request request, Callback callback) {

            if (m_suggestBox.getText() != null) {
                String query = m_suggestBox.getText().trim();
                if (query.length() > 3) {
                    getController().getSearchData().setSearchQuery(query);
                    getController().doAutoComplete(request, callback);
                }
            }
        }
    }

    /** The current selection. */
    protected String m_currentSelection;

    /** The suggest box. */
    protected SuggestBox m_suggestBox;

    /**
     * Constructor, creates a new CmsSearchUiSearchfieldWidget.<p>
     * 
     * @param panel the panel used for this widget
     * @param controller the search controller
     * @param config the configuration for this widget
     */
    public CmsAutoCompleteWidget(RootPanel panel, final CmsSolrController controller, final CmsWidgetConfig config) {

        super(panel, controller, config);

        controller.initTitles();

        if (config.getType().equals(WIDGET_TYPES.autocompleteHeader)) {

            Element e = RootPanel.get("searchButtonHeader").getElement();
            Event.sinkEvents(e, Event.ONCLICK);
            Event.setEventListener(e, new EventListener() {

                @Override
                public void onBrowserEvent(Event event) {

                    if (Event.ONCLICK == event.getTypeInt()) {
                        final SuggestBox suggestBox = createSugestBox(config.getId());
                        RootPanel sf = RootPanel.get("searchContentHeader");
                        if (sf != null) {
                            sf.insert(suggestBox, 0);
                        }
                        m_suggestBox = suggestBox;
                    }
                }
            });
        } else {
            final SuggestBox suggestBox = createSugestBox(null);
            if (controller.getSearchData().getSearchQuery() != null) {
                suggestBox.setText(controller.getSearchData().getSearchQuery());
            }
            m_suggestBox = suggestBox;

            Button searchbutton = new Button();
            searchbutton.setStyleName("btn btn-danger");
            searchbutton.setText(" ");
            searchbutton.addClickHandler(new ClickHandler() {

                /**
                 * Do a new search if the search button is selected, , all previous search parameters are deleted.<p>
                 * 
                 * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
                 */
                public void onClick(ClickEvent event) {

                    search(suggestBox.getText(), 0);
                }
            });
            searchbutton.getElement().setInnerHTML("Go");

            HTMLPanel buttonGroup = new HTMLPanel("span", "");
            buttonGroup.setStyleName("input-group-btn");
            buttonGroup.add(searchbutton);

            FlowPanel group = new FlowPanel();
            group.add(suggestBox);
            group.setStyleName("input-group");
            group.add(buttonGroup);

            getPanel().add(group);
        }
    }

    /**
     * @see com.alkacon.bootstrap.solr.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.solr.client.CmsSolrDocumentList)
     */
    public void update(CmsSolrDocumentList result) {

        if (CmsSolrStringUtil.isEmpty(getController().getSearchData().getSearchQuery())) {
            if (m_suggestBox != null) {
                m_suggestBox.setValue("");
            }
        }
    }

    /**
     * Executes a search.<p>
     * 
     * @param query the text query to search for 
     * @param delay the delay before execution in ms
     */
    protected void search(String query, int delay) {

        String q = query;
        if (getController().getTitles().contains(q)) {
            q = "\"" + q + "\"";
        }
        getController().getSearchData().setSearchQuery(q.trim());
        getController().doSearch(q, delay);
    }

    /**
     * Submits the header auto suggest form.<p>
     */
    protected native void submitForm()/*-{

        $wnd.document.searchFormHeader.submit();
    }-*/;

    /**
     * Creates a suggest box.<p>
     * 
     * @param id the Id of an existing input field to use as search field,
     * if <code>null</code> a new input box will be created 
     * 
     * @return the suggest box
     */
    protected SuggestBox createSugestBox(final String id) {

        Element e = DOM.getElementById(id);
        TextBox searchField = new TextBox();
        if (e != null) {
            searchField = TextBox.wrap(e);
        }

        final SuggestBox.DefaultSuggestionDisplay suggestDisplay = new SuggestBox.DefaultSuggestionDisplay() {

            /**
             * @see com.google.gwt.user.client.ui.SuggestBox.DefaultSuggestionDisplay#decorateSuggestionList(com.google.gwt.user.client.ui.Widget)
             */
            @Override
            protected Widget decorateSuggestionList(Widget suggestionList) {

                int width = RootPanel.get(getConfig().getId()).getElement().getOffsetWidth();
                String styleValue = suggestionList.getElement().getAttribute("style");
                styleValue = styleValue + " width: " + width + "px";
                suggestionList.getElement().setAttribute("style", styleValue);
                return suggestionList;
            }

            /**
             * @see com.google.gwt.user.client.ui.SuggestBox.DefaultSuggestionDisplay#moveSelectionDown()
             */
            @Override
            protected void moveSelectionDown() {

                super.moveSelectionDown();
                m_currentSelection = getCurrentSelection().getReplacementString();
                search("\"" + m_currentSelection + "\"", 0);
            }

            /**
             * @see com.google.gwt.user.client.ui.SuggestBox.DefaultSuggestionDisplay#moveSelectionUp()
             */
            @Override
            protected void moveSelectionUp() {

                super.moveSelectionUp();
                m_currentSelection = getCurrentSelection().getReplacementString();
                search("\"" + m_currentSelection + "\"", 0);
            }
        };

        final SuggestBox suggestBox = new SuggestBox(new AllSuggestionOracle(), searchField, suggestDisplay);
        suggestBox.setAutoSelectEnabled(false);
        suggestBox.getElement().setAttribute("name", getConfig().getId());
        suggestBox.getElement().setAttribute("autocomplete", "off");
        suggestBox.setStyleName("form-control");

        suggestBox.addSelectionHandler(new SelectionHandler<SuggestOracle.Suggestion>() {

            public void onSelection(SelectionEvent<Suggestion> event) {

                String q = "\"" + event.getSelectedItem().getReplacementString() + "\"";
                getController().getSearchData().setSearchQuery(q);
                if (id != null) {
                    submitForm();
                } else {
                    if (!((m_currentSelection != null) && m_currentSelection.equals(getController().getSearchData().getSearchQuery()))) {
                        search(q, 0);
                    }
                }
            }
        });

        suggestBox.getValueBox().addKeyUpHandler(new KeyUpHandler() {

            /**
             * @see com.google.gwt.event.dom.client.KeyUpHandler#onKeyUp(com.google.gwt.event.dom.client.KeyUpEvent)
             */
            public void onKeyUp(KeyUpEvent event) {

                if (event.getNativeEvent().getKeyCode() == KeyCodes.KEY_ENTER) {
                    if (((m_currentSelection != null) && !m_currentSelection.equals(getController().getSearchData().getSearchQuery()))
                        || CmsSolrStringUtil.isEmpty(suggestBox.getText())) {
                        search(suggestBox.getText(), 50);
                    }
                }
            }
        });
        return suggestBox;
    }

}
