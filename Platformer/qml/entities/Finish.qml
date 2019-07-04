import QtQuick 2.0
import Felgo 3.0
import "../dialog"

TiledEntityBase{
    id : finsh
    entityType: "finsh"


    Tile{


        property alias sprite: sprite
        id: sprite
        width: gameScene.gridSize
        height: gameScene.gridSize

        image.source: "../../assets/finish/finish.png"
    }

    BoxCollider {
        id: collider
        anchors.fill: sprite

        active: true

        bodyType: Body.Static
        collisionTestingOnlyMode: true
        // Category6: 终点
        categories: Box.Category10
        // Category1: 玩家
        collidesWith: Box.Category1
        fixture.onBeginContact: {
        var otherEntity = other.getBody().target
            if(otherEntity.entityType==="player")
            {

                 gameWindow.state="finish"

            }
        }
    }




}





