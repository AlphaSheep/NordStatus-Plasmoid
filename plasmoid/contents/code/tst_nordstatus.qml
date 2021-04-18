import QtQuick 2.3
import QtTest 1.0

import '../code/nordstatus.js' as Logic


TestCase {
    name: "NordStatusTests"

    /*
     Constants for use in test
     */
    
    function i18n(input) {
        /* Override the built in translation to leave all results untranslated for the purposes of unit testing */
        return input
    }
    
    readonly property string connectedResponse: "Status: Connected
Current server: aa123.example.com
Country: Nation Land
City: Place Town
Your new IP: 123.45.67.89
Current technology: OpenVPN
Current protocol: UDP
Transfer: 1.23 MiB received, 456.78 KiB sent
Uptime: 43 minutes 21 seconds
"
    readonly property string connectedNeedUpdateResponse: "A new version of NordVPN is available! Please update the application.
Status: Connected
Current server: aa123.example.com
Country: Nation Land
City: Place Town
Your new IP: 123.45.67.89
Current technology: OpenVPN
Current protocol: UDP
Transfer: 1.23 MiB received, 456.78 KiB sent
Uptime: 43 minutes 21 seconds
"

    readonly property string disconnectedResponse: "Status: Disconnected"
    
    readonly property string noInternetResponse: "Please check your internet connection and try again."
    
    readonly property var connectedObj: ({
            connected: true,
            server: "aa123.example.com",
            country: "Nation Land",
            city: "Place Town",
            ip: "123.45.67.89",
            technology: "OpenVPN",
            protocol: "UDP"
        });
    
    readonly property var disconnectedObj: ({
            connected: false,
            server: "",
            country: "",
            city: "",
            ip: "",
            technology: "",
            protocol: ""
        });
    
    /*
     Test Cases
     */
    
    function test_parseResponse_data() {
        return [
            {
                tag: "connected", 
                input: connectedResponse,
                expected: connectedObj
            },
            {
                tag: "connected and needs update", 
                input: connectedNeedUpdateResponse,
                expected: connectedObj
            },
            {
                tag: "disconnected", 
                input: disconnectedResponse,
                expected: disconnectedObj
            },
            {
                tag: "no internet", 
                input: noInternetResponse,
                expected: disconnectedObj
            }
        ]
    }
    
    function test_parseResponse(data) {        
        let actual = Logic.parseStatusString(data.input);
        let expected = data.expected;
        compare(actual, expected, data.tag)
    }
    
    
    function test_getConnectionShortSummary_data() {
        return [
            {
                tag: "connected",
                input: connectedObj,
                expected: "Connected
Country: Nation Land
Server: aa123.example.com
Your IP: 123.45.67.89"
            },
            {
                tag: "not connected",
                input: disconnectedObj,
                expected: "Not connected"
            }
        ]
    }
    
    function test_getConnectionShortSummary(data) {
        let actual = Logic.getConnectionShortSummary(data.input);
        let expected = data.expected;
        compare(actual, expected, data.tag)
    }
    
} 
