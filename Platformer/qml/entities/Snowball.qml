import QtQuick 2.0
import Felgo 3.0

//没用
TiledEntityBase{
    id : snowball
    entityType: "snowball"
    //是否被玩家吃掉
    property bool collected: false
    width: gameScene.gridSize
    height: gameScene.gridSize

    Image {
        id: image
        anchors.fill: parent
        source: "../../assets/snowball/snowball.png"
        visible: !snowball.collected
    }

    BoxCollider {
        id: collider
        anchors.fill: snowball
        width: parent.width-10
        height: parent.height-10
//        x:snowball.x
//        anchors.bottom: snowball.bottom
        //被收集后，不能在进行收集    不再进行碰撞
        active: !collected
        //这个碰撞是静止的，只进行碰撞检测即可
        bodyType: Body.Dynamic
        collisionTestingOnlyMode: true
        // Category6: 雪球
        categories: Box.Category5
        // Category1: 玩家
        //Category2:地面
        collidesWith: Box.Category1
    }



    // set collected to true
    function collect() {
        console.debug("I am becoming big")
        snowball.collected = true
    }

    // reset snowball
    function reset() {
        snowball.collected = false
    }
}
