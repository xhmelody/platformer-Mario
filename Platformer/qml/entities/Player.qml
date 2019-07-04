import Felgo 3.0
import QtQuick 2.0
import"../common"
import "../"
EntityBase {
    id: player
    entityType: "player"
    width: 25
    height: 25
   signal finish
    property alias collider: collider
    property alias horizontalVelocity: collider.linearVelocity.x
    property alias verticalVelocity: collider.linearVelocity.y

    property bool isBig: false
    property bool runGetBig: false

    //    property bool myFlag: true
    //无敌效果
    //无敌效果只用来在玩家变小时候有一段不被怪物杀死的效果      我在无敌效果的时候  短时间设置玩家与怪物的碰撞区域不见 500ms后恢复
    property bool invincible: false

    //switch the picture
    property int pictureNum: 8

    property bool orRight: false

    property bool doubleJump: true

    property int jumpForce: 150
    property int killJumpForce: 150

    //用来平滑的上向跳跃  jumpNum在每一个区域   向上的力是不同的
    property int jumpNum: 20

    property int contacts: 0
    state: contacts > 0 ? "walking" : "jumping"
    onStateChanged: console.debug("player.state " + state)

    scale: isBig ? 1.25 : 1
    Behavior on scale { NumberAnimation { duration: 1000 } }
    transformOrigin: Item.Bottom //变化从底部起

    MultiResolutionImage {
        id : image
        property alias image: image
        width: player.width
        height: player.height
        anchors.fill: collider
        mirror: orRight
        source: "../../assets/player/walk-8.png"
    }

    BoxCollider {
        id: collider

        height: player.height
        width: player.width

        // 我们将摩擦力设为零，让玩家从其他实体的侧面滑下去
        friction: 0
        categories: Box.Category1
        anchors.horizontalCenter: parent.horizontalCenter

        bodyType: Body.Dynamic
        fixedRotation: true
        bullet: true
        sleepingAllowed: false
        force: Qt.point(controller.xAxis*100*16,0)
        onLinearVelocityChanged: {
            if(linearVelocity.x > 170) linearVelocity.x = 170
            if(linearVelocity.x <-170 ) linearVelocity.x = -170
        }
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if (otherEntity.entityType === "coin"){
                otherEntity.collect()
               // otherEntity.coins++

            }
            else if (otherEntity.entityType === "snowball"){
                otherEntity.collect()
//                contacts = 0
                getBig()
            }
            else if (otherEntity.entityType === "platform"){
                otherEntity.onPlatform(true)
            }
//            else if(otherEntity.entityType==="finish")
//            {
//                player.visible=false
//            }
        }

        // 在任何时刻都可以进行碰撞检测
        fixture.onContactChanged: {
            var otherEntity = other.getBody().target

            //在这个碰撞区域中  玩家碰撞到怪物就会被杀死
                     if(otherEntity.entityType === "snowman" || otherEntity.entityType === "snowmanjump"||otherEntity.entityType==="bighead"||otherEntity.entityType==="hedgehog"||otherEntity.entityType==="ironhead"||otherEntity.entityType==="crystallo") {
                if (!invincible)      //false
                {
                    die(true)

                }
                else{
                    otherEntity.setCollidesWith()
                    console.debug("I am invincible")
                    invincible = false
                }
            }

        }

        // 接触结束  离开后
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            // when collision with another object ends, decrease the player's contacts
            if (otherEntity.entityType === "platform")
            {
                otherEntity.onPlatform(false)
            }
//            else if (otherEntity.entityType === "snowball")  //没有这个好像一进来吃掉变大雪球  就可以无线连跳  没找到原因
//            {

//            }
        }
    }

    // 用来处理与怪物之间的接触和杀死怪物
    BoxCollider {
        id: feetSensor

        //根据玩家的大小来设置碰撞区域的大小
        width: 20 * parent.scale
        height: 5 * parent.scale

        // 这个碰撞区域在玩家碰撞区域的下面   而且他的大小随着玩家变大也会变大
        anchors.horizontalCenter: collider.horizontalCenter
        anchors.top: collider.bottom

        bodyType: Body.Dynamic

        active: true

        // Category2: player feet sensor
        categories: Box.Category7
        // Category3: opponent body, Category2: solids
        collidesWith: Box.Category9 | Box.Category3|Box.Category10

        collisionTestingOnlyMode: true

        // this is called whenever the contact with another entity begins
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target

            if(otherEntity.entityType === "snowman" || otherEntity.entityType === "snowmanjump"||otherEntity.entityType==="bighead"||otherEntity.entityType==="crystallo") {

                //踩下怪物的处理
                var playerLowestY = player.y + player.height
                var oppLowestY = otherEntity.y + otherEntity.height

                // ...and if the player's y position is at least
                // 5px above the opponent's...
                if(playerLowestY < oppLowestY - 5) {
                    console.debug("kill enemy")
                    otherEntity.die()
                    //踩死后  玩家向上升一段距离
                    jump(false)
                }
            }

        }
    }


    Timer {
        id: updateTimer

        interval: 60
        running: true
        repeat: true
        onTriggered: {
            var xAxis = controller.xAxis;
            //向左移动

            console.debug("state ======= " + player.state)
            if (xAxis == 1)
            {
                image.source = "../../assets/player/walk-" + pictureNum%8 + ".png"
                pictureNum++
                orRight = false
            }
            else if (xAxis == -1)
            {
                image.source = "../../assets/player/walk-" + pictureNum%8 + ".png"
                pictureNum++
                orRight = true
            }

            // 静止状态下的玩家   我们设置xAxis为0
            if(xAxis == 0) {
                image.source = "../../assets/player/walk-8.png"
                if(Math.abs(player.horizontalVelocity) > 10) player.horizontalVelocity /= 1.5
                else player.horizontalVelocity = 0
            }
        }
    }


    // 让上升看起来更加流畅
    Timer {
        id: ascentControl

        interval: 15
        repeat: true

        onTriggered: {
            if(jumpNum > 0) {
                console.debug("jumpForeLeft = "+ jumpNum)

                var verticalImpulse = 0

                //开始跳跃时
                if(jumpNum == 20) {
                    verticalVelocity = 0
                    verticalImpulse = -jumpForce           //-210
                }
                // 在一次强烈的上升后  我们把上向的力设置小一点
                else if(jumpNum >= 14) {
                    verticalImpulse = -jumpForce / 5
                }
                // 平滑过度
                else {
                    verticalImpulse = -jumpForce / 15
                }
                collider.applyLinearImpulse(Qt.point(0, verticalImpulse))
                jumpNum--
            }
        }
    }

    function die(dieImmediately) {

        if (!isBig)
        {
            gameScene.resetLevel()
        }
        else
        {
            //            isBig = false
            getSmall()
            //这里设置一个无敌时间或者一个事件暂时不能再次碰撞
        }

        //      if(dieImmediately && (!isBig))
        //      {
        //        // ...die
        ////        audioManager.playSound("playerDie")
        ////        gameScene.resetLevel()
        //          gameScene.resetLevel()

        //      }
        //      // else if invincible...
        //      else if(invincible) {
        //        // ... don't do anything
        //      }
        //      // else => (!dieImmediately && !invincible && isBig)...
        //      else {
        //        // ...make player small and invincible for a short time
        //        isBig = false
        ////        startInvincibility(0)

        ////        audioManager.playSound("playerHit")
        //      }
    }

    //对于二级跳  我们设置两个碰撞检测区域  大的包含小的  一个类似于地面   一个类似于平台   地面可以重置跳跃   而平台不可重置跳跃

    function jump(pressedUp) {
        if(pressedUp) {
            // when the player stands on the ground and the jump
            // button is pressed, we start the ascentControl
            if(player.state == "walking") {
                ascentControl.start()
                music.selectSound("playjumpsound")
                //          audioManager.playSound("playerJump")
            }
            else if(doubleJump) {
                ascentControl.start()
                doubleJump = false
                music.selectSound("playjumpsound")
                //          audioManager.playSound("playerJump")
            }
        }
        else {
            // 踩死一只怪物后  向上跳跃一段距离
            verticalVelocity = -killJumpForce
        }
    }


    // this function is called, when the user releases the jump button
    function endJump() {
        // stop ascentControl
        ascentControl.stop()
        // reset jumpForceLeft
        jumpNum = 20
    }


    function getSmall() {
        isBig = false
        invincible = true
        collider.width = player.width
        collider.height = player.height
    }

    function getBig() {
        isBig = true
        collider.width = player.width * 1.25
        collider.height = player.height * 1.25
    }
}

