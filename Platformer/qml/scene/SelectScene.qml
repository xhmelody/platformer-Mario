import QtQuick 2.0
import Felgo 3.0
import "../common"

BaseScene{
    id:selectscene
    Rectangle{
        id: background
        anchors.fill: parent.gameWindowAnchorItem
        gradient: Gradient {
          GradientStop { position: 0.0; color: "#4595e6" }
          GradientStop { position: 0.9; color: "#80bfff" }
        }
//        opacity: 0.5
    }
    Column{
        spacing: 5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        BaseButton {
          id: game1
          text1: qsTr("Level 1")
          changecolor: "blue"
          width: 90
          height: 30
          radius: 1/4*height
          onClicked: gameWindow.state="game1"
          }
        BaseButton {
          id: game2
//          image.source: "../../assets/background/arcticskies1.png"
          text1: qsTr("Lelve 2")
          changecolor: "yellow"
          width: 90
          height: 30
          radius: 1/4*height
          }
         BaseButton {
         id: backButton
//         image.source: "../../assets/background/arcticskies1.png"
         text1: qsTr("Back")
         width: 90
         height: 30
         changecolor: "green"
         radius: 1/4*height
         onClicked:
         {

             gameWindow.state="menu"

         }
    }
}


}
