import Felgo 3.0
import QtQuick 2.0
import "../scene"
Item {
  width: gameScene.gridSize
  height: gameScene.gridSize
  property alias image: sprite
  property string pos: "mid"
  MultiResolutionImage {
    id: sprite
    width: parent.width
    height: parent.height
//    visible: !allowedToBuild

  }
}

