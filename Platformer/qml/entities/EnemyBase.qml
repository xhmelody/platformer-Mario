import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
  id: enemyBase
  entityType: "enemyBase"

  property int startX
  property int startY

  property int pictureNum: 1

  //怪物是否活着
  property bool alive: true
  //是否隐藏
  property bool hidden: false
  z: 1 // 让怪物显示在最前面

  //在创建或移动实体时更新实体的开始位置
  onEntityCreated: updateStartPosition()
  onEntityReleased: updateStartPosition()

  // this timer hides the opponent a few seconds after its death
  Timer {
    id: hideTimer
    interval: 2000

    onTriggered: hidden = true
  }
  //用一个计时器   来处理怪物的移动的   循环贴图
  Timer {
    id: switchPictureTimer
    interval: 300
    running: true
    repeat: true

    onTriggered: {
        console.debug("pictureNum = "+pictureNum)
        pictureNum++
    }
  }

  function updateStartPosition()
  {
    startX = x
    startY = y
  }

  //重置所有怪物
  function reset_super()
  {
    //所有怪物都变活
    alive = true


    // stop hideTimer, to avoid unwanted, delayed hiding of the opponent
    hideTimer.stop()
    // 取消隐藏
    hidden = false

    // 重置坐标
    x = startX
    y = startY

    // 重置速度
    collider.linearVelocity.x = 0
    collider.linearVelocity.y = 0

    // 重置力
    collider.force = Qt.point(0, 0)
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

  function die() {
    alive = false

    hideTimer.start()

      //音乐
//    if(variationType == "walker")
//      audioManager.playSound("opponentWalkerDie")
//    else if(variationType == "jumper")
//      audioManager.playSound("opponentJumperDie")

  }

}


