# NordVPN Status Plasmoid

This is an unofficial plasmoid widget that provides a graphical way to control your NordVPN connection. It has been independently developed and is not affiliated with NordVPN in any way.

This was developed for and tested with KDE Plasma 5.18.5 on Kubuntu 20.04.

## Development Requirements

You will need to install the following packages to be able to run, test and package the plasmoid:
`qtdeclarative5-dev`
`qml-module-qttest`
`plasma-sdk`

## Installing

To install the plasmoid so that it becomes available in the "Add Widgets..." menu in Plasma, change directory to the root folder of the project, and run the following:
```
kpackagetool5 -t Plasma/Applet --install ./plasmoid
```

## Uninstalling
To uninstall the plasmoid, run the following command:
```
kpackagetool5 --remove ./plasmoid
```

## Previewing 

To run the plasmoid in a preview environment, change directory to the root folder of the project, and run the following:
```
plasmoidviewer -a ./plasmoid
```

## Unit tests

Change directory to the root directory and run to following command
```
qmltestrunner
```
