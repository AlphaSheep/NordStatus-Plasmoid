import QtQuick 2.3
import QtTest 1.0

import '../code/nordstatus.js' as Logic


TestCase {
    name: "NordStatusTests"

    /*
     Constants for use in test
     */
    
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
    
    readonly property var expectedConnectedObj: ({
            connected: true,
            server: "aa123.example.com",
            country: "Nation Land",
            city: "Place Town",
            ip: "123.45.67.89",
            technology: "OpenVPN",
            protocol: "UDP"
        });
    
    readonly property var expectedDisconnectedObj: ({
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
    
    function init_data() {
        return [
            {
                tag: "connected", 
                response: connectedResponse,
                expected: expectedConnectedObj
            },
            {
                tag: "connected and needs update", 
                response: connectedNeedUpdateResponse,
                expected: expectedConnectedObj
            },
            {
                tag: "disconnected", 
                response: disconnectedResponse,
                expected: expectedDisconnectedObj
            },
            {
                tag: "no internet", 
                response: noInternetResponse,
                expected: expectedDisconnectedObj
            },
        ]
    }
    
    function test_parseResponse(data) {        
        let actual = Logic.parseStatusString(data.response);
        let expected = data.expected;
        compare(actual, expected, data.tag)
    }
        
} 
