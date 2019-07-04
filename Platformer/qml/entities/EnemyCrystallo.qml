import QtQuick 2.0
import Felgo 3.0

EnemyBase{
    id : crystallo
    entityType: "crystallo"

    //-1:怪物向左移动    1：向右
    property int direction: -1
    property int speed: 35

    Tile{
        id : enemy
        property alias enemy : enemy
        image.visible: !hidden
        image.source: alive ? "../../assets/crytallo/crystallo-left-"+pictureNum%3+".png"
                            : "../../assets/crytallo/shattered-left.png"
        image.mirror: collider.linearVelocity.x > 0 ? true : false
    }

    onAliveChanged: {
      if(!alive) {
        leftAbyssChecker.contacts = 0
        rightAbyssChecker.contacts = 0
      }
    }

    // main collider
    BoxCollider {
      id: collider
      bodyType: Body.Dynamic

      // when dead
      //我那里只需要当dead的时候   为false
      active: !alive ? false : true

      //移动的怪物
      categories: Box.Category3
      //1为玩家  2为地面
      // Category1: 玩家, Category2: 地面
      // Category7: 玩家脚下的那部分区域
      collidesWith: Box.Category1 | Box.Category2 | Box.Category7

      linearVelocity: Qt.point(direction * speed, 0)

      onLinearVelocityChanged: {
        // 停止移动，就像相反的方向移动
        if(linearVelocity.x === 0)
          snowman.direction = snowman.direction*-1             //1 or -1
        // 确保速度恒定
        linearVelocity.x = direction * speed    //35
      }
    }

    //在怪物的左边和右边设置一小块区域  用来检测是否到地面的边缘  用来让转向
    //边缘检测器
    BoxCollider {
      id: leftAbyssChecker

      // only active, when the main collider is active
      active: collider.active

      // we make it rather small
      width: 5
      height: 5

      // place it left, below the opponent
      anchors.top: parent.bottom
      anchors.left: parent.left

      // Category4: 边缘碰撞区域
      categories: Box.Category4
      // Category2：地面
      collidesWith: Box.Category2

      collisionTestingOnlyMode: true

      //如果接触值为0，则存在深渊，对手应将其方向反转。
      property int contacts: 0

      //处理
      fixture.onBeginContact: contacts++
      fixture.onEndContact: if(contacts > 0) contacts--

      // 改变方向
      onContactsChanged: if(contacts == 0) direction *= -1
    }

    BoxCollider {
      id: rightAbyssChecker

      active: collider.active

      // size and position
      width: 5
      height: 5
      anchors.top: parent.bottom
      anchors.right: parent.right

      // Category4: opponent sensor
      categories: Box.Category4
      // Category5: solids
      collidesWith: Box.Category2

      collisionTestingOnlyMode: true

      // handle contacts
      property int contacts: 0

      fixture.onBeginContact: contacts++
      fixture.onEndContact: if(contacts > 0) contacts--

      onContactsChanged: if(contacts == 0) direction *= -1
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

    // reset the opponent
    function reset() {
      // this is the reset function of the base entity Opponent.qml
      reset_super()

      // reset direction
      direction = -1

      // reset force
      collider.linearVelocity.x = Qt.point(direction * speed, 0)
    }

}
