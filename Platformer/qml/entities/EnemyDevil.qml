import QtQuick 2.0
import Felgo 3.0

EnemyBase {
    id: enemyJumper
    entityType: "enemyJumper"

    //当怪物脚下的碰撞区域与地面碰撞区域接触时，启动计时器，改变方向，设置冲量

    //初始化向左
    property int direction: -1

    // 水平和垂直方向的力
    property int verticalJumpForce: 210
    property int horizontalJumpForce: 40

    property bool changeDirection: false
    property bool onlyJumpUpward: false

    Tile{
        id : enemy
        property alias enemy : enemy
        image.visible: !hidden
        image.source: alive ? "../../assets/snowMan/headless1.png"
                            : "../../assets/snowMan/headless8.png"       //死掉的图片
        image.mirror: collider.linearVelocity.x > 0 ? true : false
    }

    //死掉之后    停止跳跃
    onAliveChanged: {
        if(!alive) {
            jumpTimer.stop()
        }
    }

    BoxCollider {
        id: collider

        bodyType: Body.Dynamic

        active: !alive ? false : true

        // Category3: 怪物
        categories: Box.Category3
        // Category1: 玩家, Category2: 地面
        // Category7: 玩家脚下的碰撞检测区域
        collidesWith: Box.Category1 | Box.Category2 | Box.Category7

        // 设置摩擦，防止滚下去
        friction: 1
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "player"){
                //让撞击的后  怪物被撞开的误差稍微小点     或者这里可以让玩家和它的碰撞区域暂时消失
                collider.linearVelocity.x = 0
                collider.linearVelocity.y = 0
                jumpTimer.stop()
            }

        }

    }

    //用于触发跳跃
    BoxCollider {
        id: bottomSensor
        width: 15
        height: 3

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom

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

    //无敌效果改变碰撞区域
    function setCollidesWith(){
        collider.collidesWith = Box.Category2 | Box.Category7
        invincibleTime.start()
    }
    //无敌效果延迟时间
    Timer{
        id : invincibleTime
        interval: 1000
        onTriggered: {
            collider.collidesWith = Box.Category1 | Box.Category2 | Box.Category7
        }
    }


    Timer {
        id: jumpTimer

        interval: 300
        onTriggered: {
            //设置冲量
            collider.applyLinearImpulse(Qt.point(direction * horizontalJumpForce, -verticalJumpForce))

            if (onlyJumpUpward)
            {
                direction = 0
            } else if (changeDirection)
            {
                direction *= -1
            }
        }
    }


    function reset() {
        //为了在重置时，碰撞区域失效
        alive = false

        //把上级的数据重置
        reset_super()

        // 重置方向
        direction = -1
        //重置时间
        if(jumpTimer.running)
            jumpTimer.stop()

        alive = true
    }
}

