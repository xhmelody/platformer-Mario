import QtQuick 2.0
import Felgo 3.0

TiledEntityBase{
    id : coin
    entityType: "coin"

    property bool collected: false
    Tile{

        //金币还没有被收集，显示false
        property alias sprite: sprite
        id: sprite
        width: gameScene.gridSize
        height: gameScene.gridSize
        visible: !coin.collected
        image.source: "../../assets/Coin/coin.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: sprite
        //金币被收集后，不能在进行收集
        active: !collected
        //这个碰撞是静止的，只进行碰撞检测即可
        bodyType: Body.Static
        collisionTestingOnlyMode: true
        // Category6: 金币
        categories: Box.Category6
        // Category1: 玩家
        collidesWith: Box.Category1
    }

    // set collected to true
    function collect() {
        console.debug("collect coin")
        coin.collected = true
    }

    // reset coin
    function reset() {
        coin.collected = false
    }
}





//import QtQuick 2.0
//import Felgo 3.0

//Item {
//    property int column: 0
//    property int row: 0
//    property int size // gets set in Platform.qml and Ground.qml
//    Row{
//        Repeater{
//            model: size
//            EntityBase {
//                property alias coin: coin
//                property int xCoordinates: row
//                id: coin
//                entityType: "coin"

//                //金币还没有被收集，显示false
//                property bool collected: false

//                // instead of directly modifying the x and y values of your tiles, we introduced rows and columns for easier positioning, have a look at Level1.qml on how they are used
//                x: xCoordinates*gameScene.gridSize
//                y: level.height - (column+1)*gameScene.gridSize
////                xCoordinates : xCoordinates+1
//                width: gameScene.gridSize
//                height: gameScene.gridSize

//                MultiResolutionImage {
//                    property alias sprite: sprite
//                    id: sprite
//                    width: parent.width
//                    height: parent.height
//                    visible: !coin.collected
//                    source: "../../assets/Coin/coin.png"

//                }

//                BoxCollider {
//                    id: collider
//                    anchors.fill: parent
//                    //金币被收集后，不能在进行收集
//                    active: !collected
//                    //这个碰撞是静止的，只进行碰撞检测即可
//                    bodyType: Body.Static
//                    collisionTestingOnlyMode: true
//                    // Category6: 金币
//                    categories: Box.Category6
//                    // Category1: 玩家
//                    collidesWith: Box.Category1
//                }

//                // set collected to true
//                function collect() {
//                    console.debug("collect coin")
//                    coin.collected = true
//                }

//                // reset coin
//                function reset() {
//                    coin.collected = false
//                }


//            }
//        }
//    }
//}


