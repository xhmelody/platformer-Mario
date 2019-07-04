import QtQuick 2.0
import Felgo 3.0

EnemyBase {
  id: ironhead
  entityType: "ironhead"

  // (-1 = left, 1 = right)
  property int direction: -1

  property int verticalJumpForce: 500
  property int horizontalJumpForce: 0

  Tile{
      id : enemy
      property alias enemy : enemy
      image.visible: true
      image.source:  "../../assets/ironhead/ironhead.png"

      image.mirror: player.x>ironhead.x? true : false
  }



  // the opponents main collider
  BoxCollider {
    id: collider

    bodyType: Body.Dynamic

    // when dead
    active: alive

    // Category3: opponent body
    categories: Box.Category3
//        categories: Box.Category3
    // Category1: player body, Category2: 地面
    // Category7: 玩家脚下的碰撞检测区域
    collidesWith: Box.Category1 | Box.Category2 | Box.Category7

    friction: 1

  }

  BoxCollider {
    id: bottomSensor

    width: 15
    height: 3

    anchors.horizontalCenter: parent.horizontalCenter
    anchors.top: parent.bottom

    bodyType: Body.Dynamic

    active: collider.active

    categories: Box.Category4
    // Category5: solids
    collidesWith: Box.Category2

    // this collider is for collision testing only
    collisionTestingOnlyMode: true

    // this is called whenever the contact with another entity begins
    fixture.onContactChanged: {
      var otherEntity = other.getBody().target

      if(collider.linearVelocity.y === 0 && !jumpTimer.running)
        jumpTimer.start()
    }
  }
//  //无敌效果改变碰撞区域
//  function setCollidesWith(){
//      collider.collidesWith = Box.Category2 | Box.Category7
//      invincibleTime.start()
//  }
//  //无敌效果延迟时间
//  Timer{
//      id : invincibleTime
//      interval: 1000
//      onTriggered: {
//          collider.collidesWith = Box.Category1 | Box.Category2 | Box.Category7
//      }
//  }
  // this timer is started in the bottomSensor and makes the opponent jump
  // when triggered
  function changeverticalJumpForce(){
      ironhead.verticalJumpForce=250
  }

  Timer {
    id: jumpTimer

    interval: 300

    onTriggered: {
      collider.applyLinearImpulse(Qt.point(direction * horizontalJumpForce, -verticalJumpForce))

     // direction *= -1
    }
  }


}

