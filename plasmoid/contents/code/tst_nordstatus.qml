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
    readonly property string disconnectedResponse: "Status: Disconnected"
    
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
    
    
    function test_parseConnectedResponse() {
        
        let actual = Logic.parseStatusString(connectedResponse);
        let expected = expectedConnectedObj;
        compare(actual, expected)
    }
    
    function test_parseDisconnectedResponse() {
        
        let actual = Logic.parseStatusString(disconnectedResponse);
        let expected = expectedDisconnectedObj;
        compare(actual, expected)
    }
        
} 
