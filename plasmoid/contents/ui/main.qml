import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtGraphicalEffects 1.12

import QtQml.Models 2.1

import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.plasmoid 2.0

import '../code/nordstatus.js' as NordStatus
import '../code/flags.js' as Flags

Item {
    
    QtObject {
        id: dataModel
        property var status: ({
            connected: false,
            server: "",
            country: "",
            city: "",
            ip: "",
            technology: "",
            protocol: ""
        })        
    }
        
    // Always display the compact view.
    // Never show the full popup view even if there is space for it.
    Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation

    Plasmoid.toolTipMainText: i18n("NordVPN Status");
    Plasmoid.toolTipSubText: NordStatus.getConnectionShortSummary(dataModel.status)
            
    Plasmoid.compactRepresentation: Item {        
        PlasmaCore.IconItem {
            id: nordvpnIcon
            anchors.centerIn: parent
            width: Math.round(parent.width * 0.9)
            height: width
            source: plasmoid.file('', 'icons/nordvpn.svg')
        }
        
        ColorOverlay {
            anchors.fill: nordvpnIcon
            source: nordvpnIcon
            color: dataModel.status.connected ? theme.textColor : theme.negativeTextColor
        }
        
        Image {
            id: flagIcon
            visible: dataModel.status.connected && Flags.get2LetterCode(dataModel.status.country)
            source: "../icons/flags/png/" + Flags.get2LetterCode(dataModel.status.country) + ".png"
            width: 16
            height: 11
            x: nordvpnIcon.width - width
            y: nordvpnIcon.height - height
        }
       
    }
        
    PlasmaCore.DataSource {
        id: executable
        engine: "executable"
        connectedSources: [NordStatus.nordStatusCommand]
        onNewData: {
            var exitCode = data["exit code"]
            var exitStatus = data["exit status"]
            var stdout = data["stdout"]
            var stderr = data["stderr"]
            dataModel.status = NordStatus.parseStatusString(stdout)
        }
        
        interval: 2000
    }
}
