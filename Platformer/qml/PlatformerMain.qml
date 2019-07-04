/*
 *Project name:Runing Man
 *Autor:Xianghang  Zhoujianjun Lzefeng
 *Time:201906024
 *
 */
import Felgo 3.0
import QtQuick 2.0
import "scene"
import "common"
import "dialog"
GameWindow {
  id: gameWindow

  screenWidth: 960
  screenHeight: 640
  FontLoader{
      id:gameFont
      source: "../assets/KGSecondChancesSketch.ttf"
  }
  FontLoader{
      id:gameFont1
      source: "../assets/KGSecondChancesSolid.ttf"
  }

  MenuScene {
    id: menuScene
  }
  GameScene{
     id:gameScene1
  }
  SelectScene{
      id:selectscene
  }
//  Dialog{
//      id:finishadialog
//  }

  property alias dialog: dialog
  Finishdialog{
      id: dialog
  }

  BaseMusic{
      id:music
  }

  state: "menu"

   //this state machine handles the transition between scenes
  states: [
    State {
      name: "menu"
      PropertyChanges {target: menuScene; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: menuScene}
      StateChangeScript {script: music.selectMusics()}
    },
      State {
        name: "level"
        PropertyChanges {target: selectscene; opacity: 1}
        PropertyChanges {target: gameWindow; activeScene: selectscene}
        StateChangeScript {script: music.selectMusics()}
      },
    State {
      name: "game1"
      PropertyChanges {target: gameScene1; opacity: 1}
      PropertyChanges {target: gameWindow; activeScene: gameScene1}
      StateChangeScript {script: music.selectMusics()}
      StateChangeScript{script: GameScene.resetLevel()}
    },
    State {
          name: "finish"
          PropertyChanges {target: physicsWorld ; running: false} // disable physics
          PropertyChanges{target: dialog; opacity:1 }
      }
//      State {
//        name: "game2"
//        PropertyChanges {target: gameScene2; opacity: 1}
//        PropertyChanges {target: gameWindow; activeScene: gameScene2}
//      }
  ]
}

