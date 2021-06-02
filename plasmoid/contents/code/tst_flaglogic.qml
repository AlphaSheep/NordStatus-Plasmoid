import QtQuick 2.3
import QtTest 1.0

import '../code/flags.js' as Logic


TestCase {
    name: "NordStatusTests"
    
    function test_get2LetterCode_data() {
        return [
            {
                country: "South Africa",
                code: 'za'
            },
            {
                country: "United States",
                code: 'us'
            },
            {
                country: "Canada",
                code: 'ca'
            },
            {
                country: "Nowhere Land",
                code: ''
            }
        ]
    }
    
    function test_get2LetterCode(data) {        
        let actual = Logic.get2LetterCode(data.country);
        let expected = data.code;
        compare(actual, expected)
    }
}
