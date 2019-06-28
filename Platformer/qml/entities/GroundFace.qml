import QtQuick 2.0
import Felgo 3.0

TiledEntityBase {
    id: ground
    entityType: "ground"

    Row{
        id: titleRow
        Repeater{
            model: size
            Tile{
                image.source: "../../assets/ground/snowmountain-ground2.png"
            }
        }
    }

    BoxCollider {

        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width-10
        height: parent.height-10
        anchors.fill: parent
        //      anchors.top: parent.top
        bodyType: Body.Static
        categories: Box.Category2
    }

    //在地面的上面设置一个碰撞区域   用来重置二级跳
    BoxCollider {
        id : groundface
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
}

