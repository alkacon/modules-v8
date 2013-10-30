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
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import com.google.common.base.CharMatcher;

/**
 * A String utility class.<p>
 */
public final class CmsSearchStringUtil {

    /** Assignment char between parameter name and values. */
    public static final String PARAMETER_ASSIGNMENT = "=";

    /** Delimiter char between parameters. */
    public static final String PARAMETER_DELIMITER = "&";

    /** Contains all chars that end a sentence in the {@link #trimToSize(String, int, int, String)} method. */
    public static final char[] SENTENCE_ENDING_CHARS = {'.', '!', '?'};

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
     * Creates a valid request parameter map from the given map,
     * most notably changing the values form <code>String</code>
     * to <code>String[]</code> if required.<p>
     * 
     * If the given parameter map is <code>null</code>, then <code>null</code> is returned.<p>
     * 
     * @param params the map of parameters to create a parameter map from
     * @return the created parameter map, all values will be instances of <code>String[]</code>
     */
    public static Map<String, String[]> createParameterMap(Map<String, ?> params) {

        if (params == null) {
            return null;
        }
        Map<String, String[]> result = new HashMap<String, String[]>();
        Iterator<?> i = params.entrySet().iterator();
        while (i.hasNext()) {
            @SuppressWarnings("unchecked")
            Map.Entry<String, ?> entry = (Entry<String, ?>)i.next();
            String key = entry.getKey();
            Object values = entry.getValue();
            if (values instanceof String[]) {
                result.put(key, (String[])values);
            } else {
                if (values != null) {
                    result.put(key, new String[] {values.toString()});
                }
            }
        }
        return result;
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
     *
     * @return the List of splitted Substrings
     */
    public static List<String> splitAsList(String source, char delimiter) {

        return splitAsList(source, delimiter, false);
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

    /**
     * Returns a substring of the source, which is at most length characters long, cut 
     * in the last <code>area</code> chars in the source at a sentence ending char or whitespace.<p>
     * 
     * If a char is cut, the given <code>suffix</code> is appended to the result.<p>
     * 
     * @param source the string to trim
     * @param length the maximum length of the string to be returned
     * @param area the area at the end of the string in which to find a sentence ender or whitespace
     * @param suffix the suffix to append in case the String was trimmed
     * 
     * @return a substring of the source, which is at most length characters long
     */
    public static String trimToSize(String source, int length, int area, String suffix) {

        if ((source == null) || (source.length() <= length)) {
            // no operation is required
            return source;
        }
        if (isEmpty(suffix)) {
            // we need an empty suffix
            suffix = "";
        }
        // must remove the length from the after sequence chars since these are always added in the end
        int modLength = length - suffix.length();
        if (modLength <= 0) {
            // we are to short, return beginning of the suffix
            return suffix.substring(0, length);
        }
        int modArea = area + suffix.length();
        if ((modArea > modLength) || (modArea < 0)) {
            // area must not be longer then max length
            modArea = modLength;
        }

        // first reduce the String to the maximum allowed length
        String findPointSource = source.substring(modLength - modArea, modLength);

        String result;
        // try to find an "sentence ending" char in the text
        int pos = lastIndexOf(findPointSource, SENTENCE_ENDING_CHARS);
        if (pos >= 0) {
            // found a sentence ender in the lookup area, keep the sentence ender
            result = source.substring(0, (modLength - modArea) + pos + 1) + suffix;
        } else {
            // no sentence ender was found, try to find a whitespace
            pos = lastWhitespaceIn(findPointSource);
            if (pos >= 0) {
                // found a whitespace, don't keep the whitespace
                result = source.substring(0, (modLength - modArea) + pos) + suffix;
            } else {
                // not even a whitespace was found, just cut away what's to long
                result = source.substring(0, modLength) + suffix;
            }
        }

        return result;
    }

    /**
     * Returns a substring of the source, which is at most length characters long.<p>
     * 
     * If a char is cut, the given <code>suffix</code> is appended to the result.<p>
     * 
     * This is almost the same as calling {@link #trimToSize(String, int, int, String)} with the 
     * parameters <code>(source, length, length*, suffix)</code>. If <code>length</code>
     * if larger then 100, then <code>length* = length / 2</code>,
     * otherwise <code>length* = length</code>.<p>
     * 
     * @param source the string to trim
     * @param length the maximum length of the string to be returned
     * @param suffix the suffix to append in case the String was trimmed
     * 
     * @return a substring of the source, which is at most length characters long
     */
    public static String trimToSize(String source, int length, String suffix) {

        int area = (length > 100) ? length / 2 : length;
        return trimToSize(source, length, area, suffix);
    }
}
