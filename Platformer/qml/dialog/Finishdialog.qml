import QtQuick 2.0
import Felgo 3.0
import "../entities"
import "../scene"
Item {
  id: finishadialog

  // make it appear in front of anything else
  z: 100
   property int score

  // fill game window
width: parent.width
height: parent.height

  opacity: 0 // opaque by default
  enabled: opacity > 0 // otherwise this item would receive mouse events when opaque

//  // if this is true, the user can close this dialog by clicking anywhere in the background
//  property bool closeableByClickOnBackground: true

//  // this MouseArea fills the whole screen
//  MouseArea {
//    anchors.fill: parent

//    // when it's clicked and closeableByClickOnBackground is true, the dialog should be closed
//    onClicked: {
//      if(closeableByClickOnBackground)
//        dialogBase.opacity = 0
//    }
//  }

  // background
  Rectangle {
    anchors.fill: parent

    color: "black"
    opacity: 0.9
  }

Coin{
  id:coin
}
  Text {
    anchors.centerIn: parent
    anchors.verticalCenterOffset: -20

    text: "Success!"

    color: "white"
  }

//  Text {
//    anchors.centerIn: parent

//    text: "Score: " + coin.coins

//    color: "white"
//  }

//  Text {
//    anchors.centerIn: parent
//    anchors.verticalCenterOffset: 20

//    // this property holds the current leaderboard
////    property var currentLeaderboard: {
////      if(levelEditor.currentLevelData.levelMetaData) {
////        // if id exists, return it
////        if(levelEditor.currentLevelData.levelMetaData.id)
////          return levelEditor.currentLevelData.levelMetaData.id
////        // else if publishedLevelId exists, return it
////        else if(levelEditor.currentLevelData.levelMetaData.publishedLevelId)
////          return levelEditor.currentLevelData.levelMetaData.publishedLevelId
////      }
////      // else return defaultLeaderboard
////      return undefined
////    }

//    // show the user's current highscore and rank
////    text: "Your Highscore: " + gameNetwork.userHighscoreForLeaderboard(currentLeaderboard)
////          + " (#" + gameNetwork.userPositionForLeaderboard(currentLeaderboard) + ")"

////    color: "#80bfff"

//    // only visible if level has been published
////    visible: currentLeaderboard !== undefined
//  }

  // Buttons ------------------------------------------

  GameButton {
    id: restartButton

    text: "Restart"

    width: 100

    anchors.bottom: parent.bottom
    anchors.bottomMargin: 50
    anchors.left: parent.left
    anchors.leftMargin: 100

    onClicked: {
      // close dialog
      finishadialog.opacity = 0
       gameScene1.opacity=1
      // reset state to play
     GameWindow.state="game1"

      // reset and restart level
      gameScene.resetLevel()
    }
  }

 GameButton {
    id: backButton

    text: "Menu"

    width: 100

    anchors.bottom: parent.bottom
    anchors.bottomMargin: 50
    anchors.right: parent.right
    anchors.rightMargin: 100

    onClicked: {
      // close dialog
      finishadialog.opacity = 0
     selectscene.opacity=1
      // reset state to play
      GameWindow.state = "level"
       GameScene.resetLevel()
      // go back to menu
     // gameScene.backPressed()
    }
  }
}
