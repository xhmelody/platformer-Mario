import QtQuick 2.0
import Felgo 3.0

EnemyBase{
    id : snowman
    entityType: "snowman"

    //-1:怪物向左移动    1：向右
    property int direction: -1
    property int speed: 35

    Tile{
        id : enemy
        property alias enemy : enemy
        image.visible: !hidden
        image.source: alive ? "../../assets/snowMan/headless"+pictureNum%8+".png"
                            : "../../assets/snowMan/headless8.png"
        image.mirror: collider.linearVelocity.x > 0 ? true : false
    }


    BoxCollider {
      id: collider
      bodyType: Body.Dynamic

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
      //和怪物一起
      active: collider.active

      // 让他尽量很小
      width: 5
      height: 5

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
      // 改变方向   当这块碰撞区域和地面的碰撞区域离开接触
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
      // Category2: 地面
      collidesWith: Box.Category2

      collisionTestingOnlyMode: true
      property int contacts: 0

      fixture.onBeginContact: contacts++
      fixture.onEndContact: if(contacts > 0) contacts--

      onContactsChanged: if(contacts == 0) direction *= -1
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

    function reset() {
     //base里的重置
      reset_super()
      direction = -1
      collider.linearVelocity.x = Qt.point(direction * speed, 0)
    }

}
