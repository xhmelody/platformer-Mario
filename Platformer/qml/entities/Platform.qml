import QtQuick 2.0
import Felgo 3.0

//因为重力效果，动态移动的物体都会受重力的影响   我这里只有模糊的设置速度差来抵消重力效果
//当人物站在平台上的时候    重力效果也不一样

TiledEntityBase {
  id: platform
  entityType: "platform"
  //-1:平台向上移动    1：向下
  property int direction: -1
  property int speed: 35
  property bool playerOnPlatform: false


  Row{
      id: titleRow
      Repeater{
          model: size
          Tile{
              image.source: "../../assets/platform/bridgecloud-light-platform.png"
          }
      }
  }

  BoxCollider {
    id: collider
    anchors.fill: parent
    bodyType: Body.Dynamic
    categories: Box.Category11     //后面可以设置为同一组  现在先就这样
    collidesWith: Box.Category1 | Box.Category2

    // 设置速度
    linearVelocity: Qt.point(0, direction * speed)
    //让速度连续
    onLinearVelocityChanged: {
        linearVelocity.y = direction * speed
    }
  }

  //在地面的上面设置一个碰撞区域   用来重置二级跳
  BoxCollider {
      id : platformface
      anchors.bottom: parent.top
      anchors.horizontalCenter: parent.horizontalCenter
      width: parent.width-4
        height: 0.2
      bodyType: Body.Static
      categories: Box.Category9
      collidesWith: Box.Category1
      fixture.onBeginContact:{
          var otherEntity = other.getBody().target
          if (otherEntity.entityType === "player"){
              otherEntity.contacts++
              otherEntity.doubleJump = true
          }
      }
      // 接触结束  离开后
      fixture.onEndContact: {
          var otherEntity = other.getBody().target
          if (otherEntity.entityType === "player"){
              otherEntity.contacts--
          }
      }
  }

  //这里处理有问题
  Timer{
      interval: 5000
      running: true
      repeat: true
      onTriggered: {
          platform.direction = platform.direction * -1
          if (direction === 1)
          {
              speed = -0.5
          }
          else if (playerOnPlatform && direction === -1){
              speed = 53
          }
          else {
              speed = 35
          }
      }
  }
  //通过这个设置人物是否站在平台上    在与不在的速度差不一样
  function onPlatform(standOnPlatform){
      playerOnPlatform = standOnPlatform
  }

}
