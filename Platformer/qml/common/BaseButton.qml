import QtQuick 2.0
import QtQuick.Controls.Styles 1.0
import Felgo 3.0

GameButton{
    id:baseButton
    property int radius:1
    property color newcolor: "blue"
//    property alias image: backgoundimage.source
    property alias text1: text.text
    property alias changecolor:text.color
    Rectangle {
      id: hoverRectangle
      anchors.fill: parent
      radius: baseButton.radius
      color: "white"
      opacity: hovered ? 0.8: 0.5
      gradient: Gradient {
        GradientStop { position: 0.2; color: "#009900" }
        GradientStop { position: 1.0; color: "#804c00" }
      }
    }

    Text{
        id:text
        anchors.centerIn: parent
        font.family: gameFont.name
        font.pixelSize:  20
   }
}
