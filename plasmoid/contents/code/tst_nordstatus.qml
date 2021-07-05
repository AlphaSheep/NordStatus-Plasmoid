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
    
    readonly property string connectedResponse: '{"coordinates":{"latitude":1.1,"longitude":2.2},"ip":"1.1.1.1","isp":"Co Ltd","host":{"ip_address":"1.1.1.1"},"status":true,"country":"England","region":"Region","city":"City","location":"Country, Region, City","area_code":"1234","country_code":"EN"}'

    readonly property string notConnectedResponse: '{"coordinates":{"latitude":2.2,"longitude":1.1},"ip":"1.2.3.4","isp":"ISP Ltd","host":{"domain":"example.com","ip_address":"1.2.3.4"},"status":false,"country":"Netherlands","region":"Region","city":"City","location":"Country, Region, City","area_code":"4321","country_code":"NL"}'

    readonly property string malformedResponse: '{"coordinates":{"latitude":2.2,"longitude":1.1},"i'

    readonly property var connectedObj: ({
            connected: true,
            country: "England",
            countrycode: "en",
            city: "City",
            isp: "Co Ltd",
            server: undefined,
            ip: "1.1.1.1",
            coordinates: {"latitude":1.1,"longitude":2.2},
            error: null
        });

    readonly property var notConnectedObj: ({
            connected: false,
            country: "Netherlands",
            countrycode: "nl",
            city: "City",
            isp: "ISP Ltd",
            server: "example.com",
            ip: "1.2.3.4",
            coordinates: {"latitude":2.2,"longitude":1.1},
            error: null
        });

    readonly property var malformedObj: ({
            connected: false,
            country: undefined,
            countrycode: "",
            city: undefined,
            isp: undefined,
            server: undefined,
            ip: undefined,
            coordinates: undefined,
            error: "Failed to parse response from nordvpn.com"
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
                tag: "not connected",
                input: notConnectedResponse,
                expected: notConnectedObj
            },
            {
                tag: "malformed",
                input: malformedResponse,
                expected: malformedObj
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
Country: England
City: City
ISP: Co Ltd
IP: 1.1.1.1
Coordinates: 1.1, 2.2"
            },
            {
                tag: "not connected",
                input: notConnectedObj,
                expected: "Not connected
Country: Netherlands
City: City
ISP: ISP Ltd
Server: example.com
IP: 1.2.3.4
Coordinates: 2.2, 1.1"
            },
            {
                tag: "malformed",
                input: malformedObj,
                expected: "Not connected
Error: Failed to parse response from nordvpn.com"
            }
        ]
    }
    
    function test_getConnectionShortSummary(data) {
        let actual = Logic.getConnectionShortSummary(data.input);
        let expected = data.expected;
        compare(actual, expected, data.tag)
    }
    
} 
