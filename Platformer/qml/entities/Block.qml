import QtQuick 2.0
import Felgo 3.0

//我准备在砖块里面嵌套一个snowball(一个顶出物体的)，但由于嵌套后碰撞区域的位置和图片的位置后不是很好处理  就是碰撞区域和图片不能重合
//这个好像是因为在实体中设置位置时有问题即TiledEntityBase中的坐标设置

//所以我直接在这里设置三个碰撞区域    在砖块上用图片贴   还要简单点

TiledEntityBase {
    id: block
    entityType: "block"
    property bool collected: false
    property bool hadHit: false    //已经被撞击
    property bool whetherHit: false  //是否能被撞击   能的话 上面就可以出现奖励

    Tile{
        //这里实现动态效果  循环贴图
        //这里可以切换   当玩家顶一次后   换一张图片
        image.source: "../../assets/ground/mid.png"
        id: oneBlock
        width: gameScene.gridSize
        height: gameScene.gridSize
        visible: true
    }

    BoxCollider{
        id : mainCollider
        anchors.fill: parent
        bodyType: Body.Static
        categories: Box.Category2
    }

    //这个碰撞检测用于顶出雪球
    BoxCollider {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.bottom
        width: parent.width-10
        height: 5
        bodyType: Body.Static
        categories: Box.Category13
        collidesWith: Box.Category1
        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player"){
                player.contacts++
                hadHit = true
            }
        }
        fixture.onEndContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player"){
                player.contacts--
            }
        }
    }

    //用来收集雪球
    BoxCollider {
        id: collider
        anchors.bottom: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        //被收集后，不能在进行收集    不再进行碰撞
        active: !collected && hadHit
        //这个碰撞是静止的，只进行碰撞检测即可
        bodyType: Body.Static
        collisionTestingOnlyMode: true
        // Category6: 雪球
        categories: Box.Category5
        // Category1: 玩家
        //Category2:地面
        collidesWith: Box.Category1

        fixture.onBeginContact: {
            var otherEntity = other.getBody().target
            if(otherEntity.entityType === "player"){
                collected = true
                //对玩家进行处理    如果是其他物体    吃后的效果需要不同   这里可以处理得不同
                otherEntity.isBig = true
                otherEntity.getBig()
            }
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

    Image {
        id: image
        width: parent.width
        height: parent.height
        anchors.bottom: parent.top
        source: "../../assets/snowball/snowball.png"
        visible: !collected && hadHit
    }
    function reset() {
        block.collected = false
        block.hadHit = false
    }

}


