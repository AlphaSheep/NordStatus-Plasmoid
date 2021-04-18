
nordStatusCommand = 'date';

function parseStatusString(statusString) {
    
    function parseIsConnected(statusString) {
        let status = statusString.match(/Status: (\w+)/)[1];
        return (status === "Connected")
    }

    function parseServer(statusString) {
        return parseStringProperty(statusString, 'Current server');
    }

    function parseCountry(statusString) {
        return parseStringProperty(statusString, 'Country');
    }

    function parseCity(statusString) {
        return parseStringProperty(statusString, 'City');
    }

    function parseIPAddress(statusString) {
        return parseStringProperty(statusString, 'Your new IP');
    }

    function parseTechnology(statusString) {
        return parseStringProperty(statusString, 'Current technology');
    }

    function parseProtocol(statusString) {
        return parseStringProperty(statusString, 'Current protocol');
    }

    function parseStringProperty(statusString, propertyName) {
        let pattern = new RegExp(propertyName + ': ([\\w\\d\\.\\ ]+)')    
        let value = statusString.match(pattern);
        // value will be null if not in statusString (e.g. when disconnected), so have to check for this and return empty string instead
        return value ? value[1] : ""; 
    }

    return {
        connected: parseIsConnected(statusString),
        server: parseServer(statusString),
        country: parseCountry(statusString),
        city: parseCity(statusString),
        ip: parseIPAddress(statusString),
        technology: parseTechnology(statusString),
        protocol: parseProtocol(statusString)
    };
    
}

