import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "../levels"
import "../common"
import "../dialog"
BaseScene {
    id: gameScene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    gridSize: 16

    property int offsetBeforeScrollingStarts: 240

    EntityManager {
        id: entityManager
    }

    // the whole screen is filled with an incredibly beautiful blue ...
    Rectangle {
        anchors.fill: gameScene.gameWindowAnchorItem
        color: "#74d6f7"
    }
    // the home
    Rectangle{
        width:backgoundimage.width
        height:backgoundimage.height
        x:420
        z:1000
        //      gradient: Gradient {
        //        GradientStop { position: 0.0; color: "#4595e6" }
        //        GradientStop { position: 0.9; color: "#80bfff" }
        //      }
        MultiResolutionImage {
            id:backgoundimage
            anchors.centerIn: parent
            source: "../../assets/background/home.png"
        }
        MouseArea{
            anchors.fill:parent
            onClicked: gameWindow.state="level"
        }
    }
    // ... followed by 2 parallax layers with trees and grass
    ParallaxScrollingBackground {
        id : one
        sourceImage: "../../assets/background/snowmountains.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // we move the parallax layers at the same speed as the player
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3,0)
    }

    //  //垂直向上的效果
    //  ParallaxScrollingBackground {
    //      width: 480
    //      height: 320
    //      anchors.fill: parent
    ////    sourceImage: "../assets/background/layer1.png"
    //    anchors.bottom: one.top
    //    anchors.horizontalCenter: one.horizontalCenter
    ////    anchors.bottom: gameScene.gameWindowAnchorItem.bottom
    ////    anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
    //    movementVelocity: player.y > 160 ? Qt.point(0,player.verticalVelocity) : Qt.point(0,0)
    //    ratio: Qt.point(0.3,0)
    //  }

    Item {
        id: viewPort
        height: level.height
        width: level.width
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-player.x : 0

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)
            debugDrawVisible: false
            z: 1000

            onPreSolve: {
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if(entityB.entityType === "platform" && entityA.entityType === "player" &&
                        entityA.y + entityA.height > entityB.y) {
                    contact.enabled = false
                }
            }
        }

        Level1 {
            id: level
        }
        Player {
            id: player
            x: 20
            y: -100
            z: 1


            //      onFinish: {
            //        if(gameWindow.state ==="game1")
            //          resetLevel()
            //        else if(gameWindow.state === "level") {
            //          // set state to finish, to freeze the game
            //          gameWindow.state = "finish"
            //            gameWindow.dialog.opacity =1
            //          // handle score
            //          //handleScore()

            //          // show finish dialog
            //          finishialog.score = Coin.coins
            //         // finishDialog.opacity = 1
            ////        }
            //     }
            //    }
            //    Player {
            //      id: player
            //      x: 20
            //      y: -100
            //    }
        }
        ResetSensor {
            id : resetSensor
            width: player.width
            height: 0
            x: player.x
            anchors.bottom: viewPort.bottom
            // if the player collides with the reset sensor, he goes back to the start
            onContact: {
                player.x = 20
                player.y = -100
                music.selectSound("playdiesound")
            }
            //      Rectangle {
            //        anchors.fill: parent
            //        color: "yellow"
            //        opacity: 1
            //      }
        }
    }

    Rectangle {
        visible: !system.desktopPlatform
        enabled: visible
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 50
        width: 150
        color: "blue"
        opacity: 0.4

        Rectangle {
            anchors.centerIn: parent
            width: 1
            height: parent.height
            color: "white"
        }
        MultiPointTouchArea {
            anchors.fill: parent
            onPressed: {
                if(touchPoints[0].x < width/2)
                    controller.xAxis = -1
                else
                    controller.xAxis = 1
            }
            onUpdated: {
                if(touchPoints[0].x < width/2)
                    controller.xAxis = -1
                else
                    controller.xAxis = 1
            }
            onReleased: controller.xAxis = 0
        }
    }

    Rectangle {
        // same as the above input control
        visible: !system.desktopPlatform
        enabled: visible
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        height: 100
        width: 100
        color: "green"
        opacity: 0.4

        Text {
            anchors.centerIn: parent
            text: "jump"
            color: "white"
            font.pixelSize: 9
        }
        MouseArea {
            anchors.fill: parent
            onPressed: player.jump(true)
            onReleased: player.endJump()
        }
    }

    //用来处理二级跳
    //对于撞击比较矮小的平台  我们可以另行处理  在碰撞检测里面发送一个信号  让重置二级跳的事件延迟短一些
    //先不处理这里了     可以设置一些场景来掩盖这个bug
    Timer{
        id: clickTimer
        interval: 1800          //间隔1800对应冲量150

        onTriggered: {
            controller.clickNum = 0
            clickTimer.stop()
        }
    }


    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        property int clickNum: 0
        onInputActionPressed: {
            console.debug("key pressed actionName " + actionName)
            if(actionName == "up") {
                player.jump(true)
                //          clickNum++
                //          if (clickNum < 3)
                //          {
                //              player.jump(true)
                ////              clickTimer.start()
                //          }
            }
        }
        onInputActionReleased: {
            // end jump when releasing the up button
            if (actionName == "up"){
                player.endJump()
            }
        }
    }

    function resetLevel() {

        // reset player
        //    player.reset()
        resetSensor.contact()

        //    // reset opponents
        //    var opponents = entityManager.getEntityArrayByType("opponent")
        //    for(var opp in opponents) {
        //      opponents[opp].reset()
        //    }
        var enemybases=entityManager.getEntityArrayByType("bighead")
        for(var enemy in enemybases){
            enemybases[enemy].reset()
        }

        // reset coins
        var coins = entityManager.getEntityArrayByType("coin")
        for(var coin in coins) {
            coins[coin].reset()
        }
        //reset snowmanjump
        var snowmans=entityManager.getEntityArrayByType("snowmanjump")
        for(var snowman in snowmans){
            snowmans[snowman].reset()
        }

        //    // reset mushrooms
        //    var mushrooms = entityManager.getEntityArrayByType("mushroom")
        //    for(var mushroom in mushrooms) {
        //      mushrooms[mushroom].reset()
        //    }

        //    // reset stars
        //    var stars = entityManager.getEntityArrayByType("star")
        //    for(var star in stars) {
        //      stars[star].reset()
        //    }

        //    // reset time and timer
        //    time = 0
        //    levelTimer.restart()
    }

}

