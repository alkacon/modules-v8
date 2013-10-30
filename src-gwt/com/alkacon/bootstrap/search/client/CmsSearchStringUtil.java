/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH (http://www.alkacon.com)
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

package com.alkacon.bootstrap.search.client;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.common.base.CharMatcher;

/**
 * A String utility class.<p>
 */
public final class CmsSearchStringUtil {

    /** Assignment char between parameter name and values. */
    public static final String PARAMETER_ASSIGNMENT = "=";

    /** Delimiter char between parameters. */
    public static final String PARAMETER_DELIMITER = "&";

    /** Delimiter char between url and query. */
    public static final String URL_DELIMITER = "?";

    /** The prefix for &amp. */
    private static final String AMP = "amp;";

    /** 
     * Default constructor (empty), private because this class has only 
     * static methods.<p>
     */
    private CmsSearchStringUtil() {

        // empty
    }


    /**
     * Parses the parameters of the given request query part and creates a parameter map out of them.<p>
     * 
     * Please note: This does not parse a full request URI/URL, only the query part that 
     * starts after the "?". For example, in the URI <code>/system/index.html?a=b&amp;c=d</code>,
     * the query part is <code>a=b&amp;c=d</code>.<p>
     * 
     * If the given String is empty, an empty map is returned.<p>
     * 
     * @param query the query to parse
     * @return the parameter map created from the query
     */
    public static Map<String, String[]> createParameterMap(String query) {

        if (isEmpty(query)) {
            // empty query
            return new HashMap<String, String[]>();
        }
        if (query.charAt(0) == URL_DELIMITER.charAt(0)) {
            // remove leading '?' if required
            query = query.substring(1);
        }
        // cut along the different parameters
        String[] params = splitAsArray(query, PARAMETER_DELIMITER);
        Map<String, String[]> parameters = new HashMap<String, String[]>(params.length);
        for (int i = 0; i < params.length; i++) {
            String key = null;
            String value = null;
            // get key and value, separated by a '=' 
            int pos = params[i].indexOf(PARAMETER_ASSIGNMENT);
            if (pos > 0) {
                key = params[i].substring(0, pos);
                value = params[i].substring(pos + 1);
            } else if (pos < 0) {
                key = params[i];
                value = "";
            }
            // adjust the key if it starts with "amp;"
            // this happens when "&amp;" is used instead of a simple "&"
            if ((key != null) && (key.startsWith(AMP))) {
                key = key.substring(AMP.length());
            }
            // now make sure the values are of type String[]
            if (key != null) {
                String[] values = parameters.get(key);
                if (values == null) {
                    // this is the first value, create new array
                    values = new String[] {value};
                } else {
                    // append to the existing value array
                    String[] copy = new String[values.length + 1];
                    System.arraycopy(values, 0, copy, 0, values.length);
                    copy[copy.length - 1] = value;
                    values = copy;
                }
                parameters.put(key, values);
            }
        }
        return parameters;
    }

    /**
     * Returns <code>true</code> if the provided String is either <code>null</code>
     * or the empty String <code>""</code>.<p> 
     * 
     * @param value the value to check
     * 
     * @return true, if the provided value is null or the empty String, false otherwise
     */
    public static boolean isEmpty(String value) {

        return (value == null) || (value.length() == 0);
    }

    /**
     * Returns the last index of any of the given chars in the given source.<p> 
     * 
     * If no char is found, -1 is returned.<p>
     * 
     * @param source the source to check
     * @param chars the chars to find
     * 
     * @return the last index of any of the given chars in the given source, or -1
     */
    public static int lastIndexOf(String source, char[] chars) {

        // now try to find an "sentence ending" char in the text in the "findPointArea"
        int result = -1;
        for (int i = 0; i < chars.length; i++) {
            int pos = source.lastIndexOf(chars[i]);
            if (pos > result) {
                // found new last char
                result = pos;
            }
        }
        return result;
    }

    /**
     * Returns the last index a whitespace char the given source.<p> 
     * 
     * If no whitespace char is found, -1 is returned.<p>
     * 
     * @param source the source to check
     * 
     * @return the last index a whitespace char the given source, or -1
     */
    public static int lastWhitespaceIn(String source) {

        if (isEmpty(source)) {
            return -1;
        }
        int pos = -1;

        for (int i = source.length() - 1; i >= 0; i--) {
            if (CharMatcher.WHITESPACE.matchesAnyOf(String.valueOf(source.charAt(i)))) {
                pos = i;
                break;
            }
        }
        return pos;
    }

    /**
     * Splits a String into substrings along the provided String delimiter and returns
     * the result as an Array of Substrings.<p>
     *
     * @param source the String to split
     * @param delimiter the delimiter to split at
     *
     * @return the Array of splitted Substrings
     */
    public static String[] splitAsArray(String source, String delimiter) {

        List<String> result = splitAsList(source, delimiter);
        return result.toArray(new String[result.size()]);
    }

    /**
     * Splits a String into substrings along the provided char delimiter and returns
     * the result as a List of Substrings.<p>
     *
     * @param source the String to split
     * @param delimiter the delimiter to split at
     * @param trim flag to indicate if leading and trailing white spaces should be omitted
     *
     * @return the List of splitted Substrings
     */
    public static List<String> splitAsList(String source, char delimiter, boolean trim) {

        List<String> result = new ArrayList<String>();
        int i = 0;
        int l = source.length();
        int n = source.indexOf(delimiter);
        while (n != -1) {
            // zero - length items are not seen as tokens at start or end
            if ((i < n) || ((i > 0) && (i < l))) {
                result.add(trim ? source.substring(i, n).trim() : source.substring(i, n));
            }
            i = n + 1;
            n = source.indexOf(delimiter, i);
        }
        // is there a non - empty String to cut from the tail? 
        if (n < 0) {
            n = source.length();
        }
        if (i < n) {
            result.add(trim ? source.substring(i).trim() : source.substring(i));
        }
        return result;
    }

    /**
     * Splits a String into substrings along the provided String delimiter and returns
     * the result as List of Substrings.<p>
     *
     * @param source the String to split
     * @param delimiter the delimiter to split at
     *
     * @return the Array of splitted Substrings
     */
    public static List<String> splitAsList(String source, String delimiter) {

        return splitAsList(source, delimiter, false);
    }

    /**
     * Splits a String into substrings along the provided String delimiter and returns
     * the result as List of Substrings.<p>
     * 
     * @param source the String to split
     * @param delimiter the delimiter to split at
     * @param trim flag to indicate if leading and trailing white spaces should be omitted
     * 
     * @return the Array of splitted Substrings
     */
    public static List<String> splitAsList(String source, String delimiter, boolean trim) {

        int dl = delimiter.length();
        if (dl == 1) {
            // optimize for short strings
            return splitAsList(source, delimiter.charAt(0), trim);
        }

        List<String> result = new ArrayList<String>();
        int i = 0;
        int l = source.length();
        int n = source.indexOf(delimiter);
        while (n != -1) {
            // zero - length items are not seen as tokens at start or end:  ",," is one empty token but not three
            if ((i < n) || ((i > 0) && (i < l))) {
                result.add(trim ? source.substring(i, n).trim() : source.substring(i, n));
            }
            i = n + dl;
            n = source.indexOf(delimiter, i);
        }
        // is there a non - empty String to cut from the tail? 
        if (n < 0) {
            n = source.length();
        }
        if (i < n) {
            result.add(trim ? source.substring(i).trim() : source.substring(i));
        }
        return result;
    }
}
