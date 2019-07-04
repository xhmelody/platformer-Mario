import QtQuick 2.0
import Felgo 3.0

EnemyBase{
    id : hedgehog
    entityType: "hedgehog"

    //-1:怪物向左移动    1：向右
    property int direction: -1
    property int speed: 25

    Tile{
        id : enemy
        width: parent.width
        height: parent.height
        property alias enemy : enemy
        image.visible: true



        image.source: "../../assets/hedgehog/walk-"+pictureNum%3+".png"

        image.mirror: collider.linearVelocity.x > 0 ? true : false
    }

    onAliveChanged: {
      if(!alive) {
        leftAbyssChecker.contacts = 0
        rightAbyssChecker.contacts = 0
      }
    }

    onMovedToPool: {
      leftAbyssChecker.contacts = 0
      rightAbyssChecker.contacts = 0
    }

    BoxCollider {
      id: collider

      bodyType: Body.Dynamic
      active: alive

      //移动的怪物
      categories: Box.Category3
      //1为玩家  2为地面
      // Category2: player body, Category2: player feet sensor,
      // Category5: solids  平台
      collidesWith: Box.Category1 | Box.Category2 | Box.Category7

      linearVelocity: Qt.point(direction * speed, 0)

      onLinearVelocityChanged: {
        if(linearVelocity.x === 0)
          hedgehog.direction = hedgehog.direction*-1             //1 or -1
        linearVelocity.x = direction * speed    //70
      }
    }

    //边缘检测器
    BoxCollider {
      id: leftAbyssChecker

      active: collider.active

      width: 5
      height: 5

      anchors.top: parent.bottom
      anchors.left: parent.left

      categories: Box.Category4
      collidesWith: Box.Category2

      collisionTestingOnlyMode: true

      //如果接触值为0，则存在深渊，对手应将其方向反转。
      property int contacts: 0

      fixture.onBeginContact: contacts++
      fixture.onEndContact: if(contacts > 0) contacts--

      onContactsChanged: if(contacts == 0) direction *= -1
    }

    BoxCollider {
      id: rightAbyssChecker

      active: collider.active

      width: 5
      height: 5
      anchors.top: parent.bottom
      anchors.right: parent.right

      categories: Box.Category4
      collidesWith: Box.Category2

      collisionTestingOnlyMode: true

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

    // when the speed is changed, via the itemEditor, we also want to update
    // the opponents velocity
//    onSpeedChanged: {
//      collider.linearVelocity.x = direction * speed
//    }


    function reset() {
      reset_super()

      direction = -1

      collider.linearVelocity.x = Qt.point(direction * speed, 0)
    }

}
