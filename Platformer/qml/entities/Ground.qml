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
              image.source: "../../assets/ground/ground2.png"
          }
      }
  }
}
