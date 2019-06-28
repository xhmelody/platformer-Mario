import Felgo 3.0
import QtQuick 2.0

Item {
  width: gameScene.gridSize
  height: gameScene.gridSize
  property alias image: sprite
  property string pos: "mid" // can be either "mid","left" or "right"

  MultiResolutionImage {
    id: sprite
    width: parent.width
    height: parent.height
  }
}

