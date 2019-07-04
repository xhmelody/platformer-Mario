import QtQuick 2.0
import Felgo 3.0

EnemyBase {
    id: snowmanjump
    entityType: "snowmanjump"

    // this property determines in which the opponent will jump next
    // (-1 = left, 1 = right)
    property int direction: -1

    // 水平和垂直方向的力
    property int verticalJumpForce: 210
    property int horizontalJumpForce: 40

    property bool changeDirection: false

    Tile{
        id : enemy
        property alias enemy : enemy
        image.visible: !hidden
        image.source: alive ? "../../assets/snowMan/snowman-1.png"
                            : "../../assets/snowMan/snowman-8.png"       //死掉的图片
        image.mirror: collider.linearVelocity.x > 0 ? true : false
    }

    //死掉之后    停止跳跃
    onAliveChanged: {
        if(!alive) {
            jumpTimer.stop()
        }
    }

    // the opponents main collider
    BoxCollider {
        id: collider

        bodyType: Body.Dynamic

        // when dead
        active: !alive ? false : true

        // Category3: opponent body
        categories: Box.Category3
        //        categories: Box.Category3
        // Category1: player body, Category2: 地面
        // Category7: 玩家脚下的碰撞检测区域
        collidesWith: Box.Category1 | Box.Category2 | Box.Category7

        // 设置摩擦，防止滚下去
        friction: 1
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player"){
//                jumpTimer.stop()
//                direction = direction * -1
                //让撞击的后  怪物被撞开的误差稍微小点
                collider.linearVelocity.x = 0
                collider.linearVelocity.y = 0
            }

        }

    }

    // this collider checks for collisions from the bottom and starts
    // the jumpTimer, on collision
    BoxCollider {
        id: bottomSensor

        // set size and position
        width: 15
        height: 3

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom

        // the bodyType is dynamic
        bodyType: Body.Dynamic

        // 和怪物共生死
        active: collider.active

        // Category4: 跳跃怪物的脚步碰撞区域
        categories: Box.Category4
        collidesWith: Box.Category2

        collisionTestingOnlyMode: true

        fixture.onContactChanged: {
            var otherEntity = other.getBody().target

            if(collider.linearVelocity.y === 0 && !jumpTimer.running)
                jumpTimer.start()
        }
    }

//    //无敌效果改变碰撞区域
//    function setCollidesWith(){
//        collider.collidesWith = Box.Category2 | Box.Category7
//        invincibleTime.start()
//    }
//    //无敌效果延迟时间
//    Timer{
//        id : invincibleTime
//        interval: 1000
//        onTriggered: {
//            collider.collidesWith = Box.Category1 | Box.Category2 | Box.Category7
//        }
//    }

    // this timer is started in the bottomSensor and makes the opponent jump
    // when triggered
    Timer {
        id: jumpTimer

        interval: 300
        onTriggered: {
            // jump in the current direction
            collider.applyLinearImpulse(Qt.point(direction * horizontalJumpForce, -verticalJumpForce))
            // alternate direction after every jump
            if (changeDirection)
            {
                direction *= -1
            }
        }
    }

      // reset the opponent
      function reset() {
        // We set alive to false here, and reset it to true later,
        // to deactivate the collider while the opponent is reset.
        alive = false

        // this is the reset function of the base entity Opponent.qml
        reset_super()

        // reset direction
        direction = -1

        // reset timer
        if(jumpTimer.running)
          jumpTimer.stop()

        alive = true
      }
}

