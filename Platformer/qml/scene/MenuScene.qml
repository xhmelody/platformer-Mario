import QtQuick 2.0
import Felgo 3.0
import "../common"
import "../"
BaseScene{
    id:menuScene


    Rectangle {
      id: background
      anchors.fill: parent
      MultiResolutionImage{
          anchors.fill: parent.gameWindowAnchorItem
          anchors.top: parent.top
          anchors.left: parent.left
          anchors.right: parent.right
          anchors.bottom: parent.bottom
          source: "../../assets/background/menubg.png"
      }

      Rectangle{
          id:toprectangle
          width: parent.width
          height:parent.height/4
          anchors.top:parent.top
          anchors.topMargin:5
          opacity: 0.5
          Text {
              id: welcome
              anchors.centerIn: parent
              text: qsTr("Welcom To My World")
              font.family: gameFont1.name
              font.pixelSize:  30
          }
          radius: toprectangle.height/4
    }
    }
    Column{
        spacing:5
        anchors.top:parent.top
        anchors.topMargin: 220
        anchors.left: parent.left
        anchors.leftMargin: 30
      BaseButton {
        id: playButton
        text1: "Play"
        x:180
        width: 90
        height: 30
//        anchors.horizontalCenter: menuScene.horizontalCenter
        changecolor:"red"
        radius: 1/4*height
        onClicked: {
            gameWindow.state="level"
        }
      }
    BaseButton {
      id: selectButton
      text1: qsTr("Exit")
      changecolor: "green"
      //anchors.horizontalCenter:menuScene.horizontalCenter
      x:180
      width: 90
      height: 30
      radius: 1/4*height
      onClicked: Qt.quit()
      }
    }
    MultiResolutionImage {
      id: musicButton
      width:30
      height:40
      // show music icon
      source: "../../assets/music/music.png"
      // reduce opacity, if music is disabled
      opacity: settings.musicEnabled ? 0.9 : 0.4

      anchors.top: parent.top
      anchors.topMargin: 90
      anchors.right: parent.right
      anchors.rightMargin: 30

      MouseArea {
        anchors.fill: parent

        onClicked: {
          // switch between enabled and disabled
          if(settings.musicEnabled)
            settings.musicEnabled = false
          else
            settings.musicEnabled = true
        }
      }
    }

}
