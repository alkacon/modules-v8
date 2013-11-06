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

package com.alkacon.bootstrap.search.client.widgets;

import com.alkacon.bootstrap.search.client.CmsSearchConfig.CmsWidgetConfig;
import com.alkacon.bootstrap.search.client.CmsSearchConfig.WIDGET_TYPES;
import com.alkacon.bootstrap.search.client.CmsSearchController;
import com.alkacon.bootstrap.search.client.CmsSearchDocumentList;
import com.alkacon.bootstrap.search.client.CmsSearchStringUtil;

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

            if (m_suggestBox.getValue() != null) {
                String query = m_suggestBox.getValue();
                if (query.length() > 3) {
                    getController().getSearchData().setSearchQuery(query);
                    getController().doSuggesting(request, callback, null);
                }
            }
        }
    }

    /**
     * Handles the up and down selection of the suggest oracle.<p>
     */
    private class SuggDis extends SuggestBox.DefaultSuggestionDisplay {

        /**
         * Public constructor.<p>
         */
        public SuggDis() {

            super();
        }

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
            search(m_currentSelection, 0);
        }

        /**
         * @see com.google.gwt.user.client.ui.SuggestBox.DefaultSuggestionDisplay#moveSelectionUp()
         */
        @Override
        protected void moveSelectionUp() {

            super.moveSelectionUp();
            m_currentSelection = getCurrentSelection().getReplacementString();
            search(m_currentSelection, 0);
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
    public CmsAutoCompleteWidget(RootPanel panel, final CmsSearchController controller, final CmsWidgetConfig config) {

        super(panel, controller, config);

        if (config.getType().equals(WIDGET_TYPES.autocompleteHeader)) {

            Element e = RootPanel.get("searchButtonHeader").getElement();
            Event.sinkEvents(e, Event.ONCLICK);
            Event.setEventListener(e, new EventListener() {

                /**
                 * @see com.google.gwt.user.client.EventListener#onBrowserEvent(com.google.gwt.user.client.Event)
                 */
                public void onBrowserEvent(Event event) {

                    if (Event.ONCLICK == event.getTypeInt()) {

                        controller.initSuggestions();

                        final SuggestBox suggestBox = createSugestBox(config.getId());
                        RootPanel sf = RootPanel.get("searchContentHeader");
                        if (sf != null) {
                            sf.insert(suggestBox, 0);
                        }
                        if (controller.getSearchData().getSearchQuery() != null) {
                            suggestBox.setValue(controller.getSearchData().getSearchQuery());
                        }
                        m_suggestBox = suggestBox;
                    }
                }
            });
        } else {

            controller.initSuggestions();

            final SuggestBox suggestBox = createSugestBox(null);
            if (controller.getSearchData().getSearchQuery() != null) {
                suggestBox.setValue(controller.getSearchData().getSearchQuery());
            }
            m_suggestBox = suggestBox;

            Button searchbutton = new Button();
            searchbutton.setStyleName("btn-u btn-red");
            searchbutton.setText(" ");
            searchbutton.addClickHandler(new ClickHandler() {

                /**
                 * Do a new search if the search button is selected, , all previous search parameters are deleted.<p>
                 * 
                 * @see com.google.gwt.event.dom.client.ClickHandler#onClick(com.google.gwt.event.dom.client.ClickEvent)
                 */
                public void onClick(ClickEvent event) {

                    search(suggestBox.getValue(), 0);
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
     * @see com.alkacon.bootstrap.search.client.widgets.I_CmsSearchWidget#update(com.alkacon.bootstrap.search.client.CmsSearchDocumentList)
     */
    public void update(CmsSearchDocumentList result) {

        if ((m_suggestBox != null) && CmsSearchStringUtil.isEmpty(getController().getSearchData().getSearchQuery())) {
            // clear the value of the suggest box if empty
            m_suggestBox.setValue("");
        }
    }

    /**
     * Creates a suggest box.<p>
     * 
     * @param id the Id of an existing input field to use as search field,
     * if <code>null</code> a new input box will be created 
     * 
     * @return the suggest box
     */
    protected SuggestBox createSugestBox(final String id) {

        // create or wrap the query input field
        Element e = DOM.getElementById(id);
        TextBox searchField = new TextBox();
        if (e != null) {
            searchField = TextBox.wrap(e);
        }

        // create the suggest box
        final SuggDis display = new SuggDis();
        final SuggestBox suggestBox = new SuggestBox(new AllSuggestionOracle(), searchField, display);
        suggestBox.setAutoSelectEnabled(false);
        if (getConfig().getType().equals(WIDGET_TYPES.autocompleteHeader)) {
            suggestBox.getElement().setAttribute("name", getConfig().getId());
        }
        suggestBox.getElement().setAttribute("autocomplete", "off");
        suggestBox.setStyleName("form-control");

        // add the selection handler
        suggestBox.addSelectionHandler(new SelectionHandler<SuggestOracle.Suggestion>() {

            /**
             * Handles the selection action on a suggestion.<p>
             * 
             * @param event the selection event
             */
            public void onSelection(SelectionEvent<Suggestion> event) {

                if (!((m_currentSelection != null) && m_currentSelection.equals(getController().getSearchData().getSearchQuery()))) {
                    // only if the query has changed execute a new search
                    String newQuery = event.getSelectedItem().getReplacementString();
                    if (id != null) {
                        // when search is executed from an 'external' form, quote the query and submit the form
                        submitForm();
                    } else {
                        search(newQuery, 0);
                    }
                }
            }
        });

        if (!getConfig().getType().equals(WIDGET_TYPES.autocompleteHeader)) {

            // add a key handler to hide suggestion on enter
            suggestBox.addKeyUpHandler(new KeyUpHandler() {

                /**
                 * @see com.google.gwt.event.dom.client.KeyUpHandler#onKeyUp(com.google.gwt.event.dom.client.KeyUpEvent)
                 */
                public void onKeyUp(KeyUpEvent event) {

                    if (event.getNativeEvent().getKeyCode() == KeyCodes.KEY_ENTER) {
                        if (((m_currentSelection != null) && !m_currentSelection.equals(getController().getSearchData().getSearchQuery()))
                            || CmsSearchStringUtil.isEmpty(suggestBox.getValue())) {
                            search(suggestBox.getValue(), 50);
                        }
                        display.hideSuggestions();
                    }
                }
            });
        }
        return suggestBox;
    }

    /**
     * Executes a search.<p>
     * 
     * @param query the text query to search for 
     * @param delay the delay before execution in ms
     */
    protected void search(String query, int delay) {

        getController().getSearchData().setSearchQuery(query);
        getController().doSearch(query, delay);
    }

    /**
     * Submits the header auto suggest form.<p>
     */
    protected native void submitForm()/*-{

        $wnd.document.searchFormHeader.submit();
    }-*/;

}
