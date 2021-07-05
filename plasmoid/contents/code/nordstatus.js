var nordStatusCommand = 'curl https://nordvpn.com//wp-admin/admin-ajax.php?action=get_user_info_data';

function parseStatusString(statusString) {

    let parsedStatus = {};

    let error = null;
    try{
        parsedStatus = JSON.parse(statusString);
    } catch(SyntaxError){
        error = "Failed to parse response from nordvpn.com";
    }

    let status_ = parsedStatus['status'];
    status_ = status_ == undefined ? false : status_;

    return {
        connected: status_,
        country: parsedStatus['country'],
        countrycode: parsedStatus['country_code'] ? parsedStatus['country_code'].toLowerCase() : "",
        city: parsedStatus['city'],
        isp: parsedStatus['isp'],
        server: parsedStatus['host'] ? parsedStatus['host']['domain'] : undefined,
        ip: parsedStatus['ip'],
        coordinates: parsedStatus['coordinates'],
        error: error
    };

}

function getConnectionShortSummary(conn) {
    let result = [
        i18n(conn.connected ? "Connected" : "Not connected"),
    ]
    if(conn.country){
        result = result.concat(["\n", i18n("Country: "), conn.country]);
    }
    if(conn.city){
        result = result.concat(["\n", i18n("City: "), conn.city]);
    }
    if(conn.isp){
        result = result.concat(["\n", i18n("ISP: "), conn.isp]);
    }
    if(conn.server){
        result = result.concat(["\n", i18n("Server: "), conn.server]);
    }
    if(conn.ip){
        result = result.concat(["\n", i18n("IP: "), conn.ip]);
    }
    if(conn.coordinates){
        result = result.concat([
            "\n", i18n("Coordinates: "), conn.coordinates['latitude'], i18n(", "), conn.coordinates['longitude']
        ]);
    }
    if(conn.error){
        result = result.concat(["\n", i18n("Error: "), conn.error]);
    }

    return result.join('');
}
