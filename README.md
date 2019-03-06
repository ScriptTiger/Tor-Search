# Tor-Search
Quickly and easily search Tor exit nodes based on geodata securely and anonymously offline and instantly build node lists.

**This script requires the Geo Tor Table to be present in the same directory to function properly. Visit the following URL for more information and to download the latest:  
https://scripttiger.github.io/tor/**

Where allowed, REGEX is supported in search criteria fields.

Regular expression quick reference:

Symbol   | Function
---------|------------------------------------------------------------------------------------------------------------------------
.        | Wildcard: any character
+        | Repeat: zero or more occurrences of previous character or class
[class]  | Character class: any one character in set
[-class] | Inverse class: any one character not in set
[x-y]    | Range: any characters within the specified range

    Unlike standard REGEX:
    The plus sign ("+") is used instead of the asterisk ("*").
    Beginning of line, end of line, beginning of word, and end of word characters are not used.
    Inverse class uses the minus sign ("-") instead of the caret ("^").
    

Where allowed, you may input multiple items of a single type to search for by simply separating each with a space. For example, if inputting an IP address to search for, entering `8.8.8.8 8.8.4.4` would search for both 8.8.8.8 and 8.8.4.4. Another example would be if searching for exit nodes in both the US state of California and New York, you could enter `CA NY`. However, please note, when searching smaller subdivision ISO codes, like states, provinces, metros, etc., it is recommended you also enter criteria for the larger regions of which they are a member, such as their continent, country, etc., as some subdivisions in some countries, for example, may have conflicting ISO codes with subdivisions in other countries. GeoNames IDs, on the other hand, are always unique to a specific geographical area, be it a continent, country, state, province, city, town, etc.

Some search criteria for this script are ISO codes, which are standardized codes managed by the International Organization for Standardization and are universal, independent of language. Some other search criteria are GeoNames IDs, managed by the GeoNames database and are also universal and independent of language. Please refer to the respective authorities, or simply use your favorite Web search engine, to quickly look up code/ID references.