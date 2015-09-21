// Copyright 2015 Esri.

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// http://www.apache.org/licenses/LICENSE-2.0

// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import QtQuick 2.3
import Esri.ArcGISRuntime 100.00
import Esri.ArcGISExtras 1.1

Rectangle {
    width: 800
    height: 600

    property real scaleFactor: System.displayScaleFactor
    property string statusText

    // Create MapView that contains a Map
    MapView {
        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            bottom: statusBar.top
        }

        Map {
            // Set the initial basemap to Streets
            BasemapStreets {}

            // Set up signal handler to determine load status
            // Load status should be loaded once the basemap successfully loads
            onLoadStatusChanged: {
                switch (loadStatus) {
                case Enums.LoadStatusFailedToLoad:
                    statusText = "Failed to Load";
                    break;
                case Enums.LoadStatusLoaded:
                    statusText = "Loaded";
                    break;
                case Enums.LoadStatusLoading:
                    statusText = "Loading...";
                    break;
                case Enums.LoadStatusNotLoaded:
                    statusText = "Not Loaded";
                    break;
                case Enums.LoadStatusUnknown:
                    statusText = "Unknown";
                    break;
                default:
                    statusText = "Unknown";
                    break;
                }
            }
        }
    }

    Rectangle {
        id: statusBar
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        height: 30 * scaleFactor
        color: "lightgrey"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }

        Text {
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 10 * scaleFactor
            }
            text: "Map Load Status: %1".arg(statusText)
            font.pixelSize: 14 * scaleFactor
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        border {
            width: 0.5 * scaleFactor
            color: "black"
        }
    }
}