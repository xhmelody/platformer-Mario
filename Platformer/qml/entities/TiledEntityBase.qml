import Felgo 3.0
import QtQuick 2.0
import "../levels"
import "../scene"
EntityBaseDraggable {
  id: tiledEntity
  property int column: 0
  property int row: 0
  property int size

  x: row*gameScene.gridSize
  y: level.height - (column+1)*gameScene.gridSize
  width: gameScene.gridSize * size
  height: gameScene.gridSize
}

