import Felgo 3.0
import QtQuick 2.0
import "entities"
import "levels"

Scene {
    id: gameScene
    // the "logical size" - the scene content is auto-scaled to match the GameWindow size
    width: 480
    height: 320
    gridSize: 16

    property int offsetBeforeScrollingStarts: 240
    //  property int playerRow: 0
    //  property int playerColumn: 0

    EntityManager {
        id: entityManager
    }

    //  JsonListModel{

    //  }
    //  var json = JSON.stringify(data)

    // the whole screen is filled with an incredibly beautiful blue ...
    Rectangle {
        anchors.fill: gameScene.gameWindowAnchorItem
        color: "#74d6f7"
    }

    // ... followed by 2 parallax layers with trees and grass
    ParallaxScrollingBackground {
        id : one
        sourceImage: "../assets/background/snowmountains.png"
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        // we move the parallax layers at the same speed as the player
        movementVelocity: player.x > offsetBeforeScrollingStarts ? Qt.point(-player.horizontalVelocity,0) : Qt.point(0,0)
        // the speed then gets multiplied by this ratio to create the parallax effect
        ratio: Qt.point(0.3,0)
    }

    //垂直向上的效果
    ParallaxScrollingBackground {
        width: 480
        height: 320
        anchors.fill: parent
        //    sourceImage: "../assets/background/layer1.png"
        anchors.bottom: one.top
        anchors.horizontalCenter: one.horizontalCenter
        //    anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        //    anchors.horizontalCenter: gameScene.gameWindowAnchorItem.horizontalCenter
        movementVelocity: player.y > 160 ? Qt.point(0,player.verticalVelocity) : Qt.point(0,0)
        ratio: Qt.point(0.3,0)
    }

    // this isThis property provides a way to forward key presses, key releases, and keyboard input coming from input methods to other items. This can be useful when you want one item to handle some keys (e.g. the up and down arrow keys), and another item to handle other keys (e.g. the left and right arrow keys). Once an item that has been forwarded keys accepts the event it is no longer forwarded to items later in the list. the moving item containing the level and player
    Item {
        id: viewPort
        height: level.height
        width: level.width
        //    width: player.x
        anchors.bottom: gameScene.gameWindowAnchorItem.bottom
        x: player.x > offsetBeforeScrollingStarts ? offsetBeforeScrollingStarts-player.x : 0

        PhysicsWorld {
            id: physicsWorld
            gravity: Qt.point(0, 25)
            debugDrawVisible: false // enable this for physics debugging
            z: 1000

            onPreSolve: {
                //this is called before the Box2DWorld handles contact events
                var entityA = contact.fixtureA.getBody().target
                var entityB = contact.fixtureB.getBody().target
                if(entityB.entityType === "platform" && entityA.entityType === "player" &&
                        entityA.y + entityA.height > entityB.y) {
                    //by setting enabled to false, they can be filtered out completely
                    //-> disable cloud platform collisions when the player is below the platform
                    contact.enabled = false
                }
            }
        }

        // you could load your levels Dynamically with a Loader component here
        Level1 {
            id: level

        }


        Player {
            property alias player: player
            id: player
            x: 20
            y: -100
        }

        //    //得到人物的坐标  并保存
        //    function getPlayer(){
        //        var PlayerObject = {
        //            x:player.x,
        //            y:player.y,
        //            size:1
        //        }

        //        jsondata.jsonData = PlayerObject;
        //    }

        //      Component.onCompleted: {
        //          getPlayer();
        //      }

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
                player.isBig = false
                //对场景进行重置
                level.reset();
            }
        }
    }

    Rectangle {
        // you should hide those input controls on desktops, not only because they are really ugly in this demo, but because you can move the player with the arrow keys there
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
    //  Timer{
    //      id: clickTimer
    //      interval: 1800;            //间隔1800对应冲量150

    //      onTriggered: {
    //          controller.clickNum = 0
    //          clickTimer.stop();
    //      }
    //  }


    // on desktops, you can move the player with the arrow keys, on mobiles we are using our custom inputs above to modify the controller axis values. With this approach, we only need one actual logic for the movement, always referring to the axis values of the controller
    Keys.forwardTo: controller
    TwoAxisController {
        id: controller
        property int clickNum: 0
        onInputActionPressed: {
            console.debug("key pressed actionName " + actionName)
            if(actionName == "up") {
                player.jump(true)
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

        //    // reset coins
        //    var coins = entityManager.getEntityArrayByType("coin")
        //    for(var coin in coins) {
        //      coins[coin].reset()
        //    }

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

