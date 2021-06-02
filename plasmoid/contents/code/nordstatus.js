
var nordStatusCommand = 'nordvpn status';

function parseStatusString(statusString) {
    
    function parseIsConnected(statusString) {
        let status = statusString.match(/Status: (\w+)/);
        return (status !== null) && (status[1] === "Connected")
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
        let yourIP = parseStringProperty(statusString, 'Your new IP');
        let serverIP = parseStringProperty(statusString, 'Server IP');
        return serverIP ? serverIP : yourIP;
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


function getConnectionShortSummary(conn) {
    if (conn.connected) {
        let result = [
            i18n("Connected"), "\n", 
            i18n("Country: "), conn.country, "\n",
            i18n("Server: "), conn.server, "\n",
            i18n("Your IP: "), conn.ip];
 
        return result.join('');
        
    }
    else {
        return i18n("Not connected");
    }
}
