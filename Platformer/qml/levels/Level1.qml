import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
    id: level
    width: 42 * gameScene.gridSize // 42 because our last tile is a size 30 Ground at row 12




    visible: true

    //接收json数据
    property var json_load: JSON.parse(jsondata.load)

    //这种处理就得已知所有的数据
    Coin
    {
        id:coin_0
        row: json_load.levels[0].Coin[0].row
        column: json_load.levels[0].Coin[0].column
        size: json_load.levels[0].Coin[0].size
        collected:json_load.levels[0].Coin[0].collected  //字符串"false"和false
    }
    Coin{
        id:coin_1
        row: json_load.levels[0].Coin[1].row
        column: json_load.levels[0].Coin[1].column
        size: json_load.levels[0].Coin[1].size
        collected:json_load.levels[0].Coin[1].collected  //字符串"false"和false
    }
    //JSON文件一层一层的来
    EnemyDevil{
        id:enemyDevil_0
        row: json_load.levels[0].npcs[0].row
        column: json_load.levels[0].npcs[0].column
        size:json_load.levels[0].npcs[0].size
        changeDirection: json_load.levels[0].npcs[0].changeDirection
        onlyJumpUpward: true
    }

    EnemyDevil{ //直接创建的
        id:enemyDevil_1
        row: 37
        column: 10
        size:1
        changeDirection: true
        onlyJumpUpward: false
    }
    EnemyDevil{  //直接创建的
        id:enemyDevil_2
        row: 14
        column: 9
        size:1
        changeDirection: false
        onlyJumpUpward: false
    }
    EnemyDevil{  //直接创建的
        id:enemyDevil_3
        row: 12
        column: 9
        size:1
        changeDirection: true
        onlyJumpUpward: false
    }

//    Block{//直接创建的
//        id:block_1
//        row : 13
//        column: 9
//        size:1
//    }

    Block{
        id:block_0
        row : json_load.levels[0].Block.row
        column: json_load.levels[0].Block.column
        size:json_load.levels[0].Block.size
    }

    Platform{
        id:platform_0
        row : json_load.levels[0].Platform.row
        column: json_load.levels[0].Platform.column
        size:json_load.levels[0].Platform.size
    }

    EnemySnowman{
        id:enemySnowMan_0
        row : json_load.levels[0].npcs[1].row
        column: json_load.levels[0].npcs[1].column
        size:json_load.levels[0].npcs[1].size
    }

    //    //金币
    //      Repeater{
    //          model: 7
    //          Coin{
    //              row: json_load.levels[0].Coin[index].row
    //              column: json_load.levels[0].Coin[index].column
    //              size: json_load.levels[0].Coin[index].size
    //              collected:json_load.levels[0].Coin[index].collected  //字符串"false"和false
    //          }
    //      }

    //场景重置函数    //这里每一个对象都是一个实体   所以这里麻烦  但也没有办法   可以用数组
    function reset(){
        coin_0.reset();
        coin_1.reset();
        enemyDevil_0.reset();
        enemyDevil_1.reset();
        enemyDevil_2.reset();
        enemySnowMan_0.reset();
        block_0.reset();
    }

    function getLevel(){
        var tempLevel = {
            "levels":[
                {
                    "name":"Village",
                    "Coin":[
                        {
                            "row":coin_0.row,
                            "column":coin_0.column,
                            "size":coin_0.size,
                            "collected":coin_0.collected,
                            "name":"coin_0"
                        },
                        {
                            "row":coin_1.row,
                            "column":coin_1.column,
                            "size":coin_1.size,
                            "collected":coin_1.collected,
                            "name":"coin_1"
                        }
                    ],
                    "npcs":[
                        {
                            "row":enemyDevil_0.row,
                            "column":enemyDevil_0.column,
                            "size":enemyDevil_0.size,
                            "changeDirection":enemyDevil_0.changeDirection,
                            "name":"enemyDevil_0"
                        },
                        {
                            "row":enemySnowMan_0.row,
                            "column":enemySnowMan_0.column,
                            "size":enemySnowMan_0.size,
                            "name":"enemySnowMan_0"
                        }
                    ],
                    "Block":{
                        "row":block_0.row,
                        "column":block_0.column,
                        "size":block_0.size,
                        "name":"block_0"
                    },
                    "Platform":{
                        "row":platform_0.row,
                        "column":platform_0.column,
                        "size":platform_0.size,
                        "name":"platform_0"
                    }
                }
            ],
            "Player":{
                "name":"superMan",
                "x":player.x,
                "y":player.y
            }
        }
        jsondata.jsonData = tempLevel;
    }


      Component.onCompleted: {
          getLevel();
      }




    //  //生成json对象
    //  function getData(){

    //          var getCoin = {
    //              row:22,
    //              colunm:12,
    //              size:1
    //          }

    //      var getCoin = [
    //                  {
    //                      row:22,
    //                      column:13,
    //                      size:1,
    //                      collected:true
    //                  },
    //                  {
    //                      row:23,
    //                      column:13,
    //                      size:1,
    //                      collected:true
    //                  },
    //                  {
    //                      row:24,
    //                      column:13,
    //                      size:1,
    //                      collected:true
    //                  },
    //                  {
    //                      row:25,
    //                      column:13,
    //                      size:1,
    //                      collected:true
    //                  }

    //      ]
    //      if (getCoin.isArray())
    //      {

    //      }
    //      jsondata.jsonData = getCoin;
    //  }


    //  Rectangle{
    //      width: 200
    //      height: 200
    //      color: "red"
    //      Text
    //      {
    //          id: n
    //          text: json_load.Points[0].x
    //      }
    //  }

    //    Rectangle{
    //        width: 200
    //        height: 200
    //        color: "red"
    //        Text
    //        {
    //            id: n
    //            text: json_load.player.name     //player和level是同一级的
    //        }
    //    }

    //      Rectangle{
    //          width: 200
    //          height: 200
    //          color: "red"
    //          Text
    //          {
    //              id: n
    //              text: json_load.levels.Coin[0].row     //player和level是同一级的
    //          }
    //      }

    //        Rectangle{
    //            width: 200
    //            height: 200
    //            color: "red"
    //            Text
    //            {
    //                id: n
    //                text: json_load.levels[0].Coin[0].collected     //player和level是同一级的
    //            }
    //        }




    //  //金币
    //    Repeater{
    //        property int number: 0
    //        model: 7
    //        Coin{
    ////            row: json_load.levels[0].Coin[index].row
    ////            column: json_load.levels[0].Coin[index].column
    ////            size: json_load.levels[0].Coin[index].size

    //            row: json_load.levels[0].Coin[index].row
    //            column:14
    //            size:1
    //        }
    //    }
    //    //金币
    //      Repeater{
    //          model: 6
    //          Coin{
    //              row: 5+index
    //              column: 14
    //              size: 1
    //          }
    //      }



    Ground {
        row: 0
        column: 0
        size: 23
    }
    Ground{
        row: 0
        column: 1
        size: 23
    }
    Ground{
        row: 0
        column: 2
        size: 23
    }
    Ground{
        row:0
        column: 3
        size: 23
    }
    Ground{
        row:0
        column: 4
        size: 23
    }
    Ground{
        row: 0
        column: 5
        size: 19
    }
    Ground{
        row:0
        column: 6
        size: 19
    }
    Ground{
        row:0
        column: 7
        size: 15
    }
    GroundFace{
        row:0
        column: 8
        size:15
    }
    GroundFace{
        row:15
        column: 7
        size:4
    }

    Coin{
        row:15
        column:10
        size:1
    }
    Coin{
        row:16
        column:10
        size:1
    }
    Coin{
        row:17
        column:10
        size:1
    }
    Coin{
        row:18
        column:10
        size:1
    }

//    GroundFace{
//        row:19
//        column: 5
//        size:4
//    }



//    GroundFace{
//        row:25
//        column:7
//        size:3
//    }



    Ground{
        row:30
        column: 0
        size:13
    }
    Ground{
        row:30
        column: 1
        size:13
    }
    Ground{
        row:30
        column: 2
        size:13
    }
    Ground{
        row:30
        column: 3
        size:13
    }
    Ground{
        row:30
        column: 4
        size:13
    }
    Ground{
        row:30
        column: 5
        size:5
    }
    GroundFace{
        row:30
        column: 6
        size:5
    }
    GroundFace{
        row:35
        column: 4
        size:4
    }

    Ground{
        row:39
        column:5
        size:4
    }
    Ground{
        row:39
        column:6
        size:4
    }
    GroundFace{
        row:39
        column:7
        size:4
    }


    Ground{
        row:45
        column: 0
        size:17
    }
    Ground{
        row:45
        column: 1
        size:17
    }
    Ground{
        row:45
        column: 2
        size:17
    }
    Ground{
        row:45
        column: 3
        size:3
    }
    Ground{
        row:45
        column: 4
        size:3
    }
    Ground{
        row:45
        column: 5
        size:3
    }
    Ground{
        row:45
        column: 6
        size:3
    }
    GroundFace{
        row:45
        column: 7
        size:3
    }
    GroundFace{
        row:48
        column:3
        size:10
    }
    GroundFace{
        row:51
        column:6
        size:4
    }
    Ground{
        row:58
        column:3
        size:4
    }
    Ground{
        row:58
        column:4
        size:4
    }
    Ground{
        row:58
        column:5
        size:4
    }
    Ground{
        row:58
        column:6
        size:4
    }
    GroundFace{
        row:58
        column:7
        size:4
    }

    GroundFace{
        row:64
        column: 10
        size:3
    }
    GroundFace{
        row:59
        column: 13
        size:3
    }

    Ground{
        row:67
        column: 0
        size:5
    }
    Ground{
        row:67
        column: 1
        size:5
    }
    Ground{
        row:67
        column: 2
        size:5
    }
    Ground{
        row:67
        column: 3
        size:5
    }
    Ground{
        row:67
        column: 4
        size:5
    }
    Ground{
        row:67
        column: 5
        size:5
    }
    Ground{
        row:67
        column: 6
        size:5
    }
    Ground{
        row:67
        column: 7
        size:5
    }
    Ground{
        row:67
        column: 8
        size:5
    }
    Ground{
        row:67
        column: 9
        size:5
    }
    Ground{
        row:67
        column: 10
        size:5
    }
    Ground{
        row:67
        column: 11
        size:5
    }
    Ground{
        row:67
        column: 12
        size:5
    }
    Ground{
        row:67
        column: 13
        size:5
    }
    GroundFace{
        row:67
        column: 14
        size:5
    }



    GroundFace{
        row:75
        column: 12
        size:3
    }
    GroundFace{
        row:81
        column:11
        size:3
    }

    Ground{
        row:87
        column:0
        size:10
    }
    Ground{
        row:87
        column:1
        size:10
    }
    Ground{
        row:87
        column:2
        size:10
    }
    Ground{
        row:87
        column:3
        size:10
    }
    Ground{
        row:87
        column:4
        size:10
    }
    Ground{
        row:87
        column:5
        size:10
    }
    Ground{
        row:87
        column:6
        size:10
    }
    Ground{
        row:87
        column:7
        size:10
    }
    Ground{
        row:87
        column:8
        size:10
    }
    Ground{
        row:87
        column:9
        size:10
    }
    GroundFace{
        row:87
        column:10
        size:10
    }


    GroundFace{
        row:101
        column:9
        size:2
    }


    GroundFace{
        row:107
        column:9
        size:3
    }
    GroundFace{
        row:110
        column:7
        size:5
    }
    GroundFace{
        row:115
        column: 8
        size:3
    }
    Ground{
        row:107
        column:0
        size:11
    }
    Ground{
        row:107
        column:1
        size:11
    }
    Ground{
        row:107
        column:2
        size:11
    }
    Ground{
        row:107
        column:3
        size:11
    }
    Ground{
        row:107
        column:4
        size:11
    }
    Ground{
        row:107
        column:5
        size:11
    }
    Ground{
        row:107
        column:6
        size:11
    }
    Ground{
        row:107
        column:7
        size:3
    }
    Ground{
        row:107
        column: 8
        size:3
    }
    Ground{
        row:115
        column: 7
        size:3
    }



    GroundFace{
        row:121
        column:6
        size:2
    }
    Ground{
        row:121
        column: 0
        size:2
    }
    Ground{
        row:121
        column: 1
        size:2
    }
    Ground{
        row:121
        column: 2
        size:2
    }
    Ground{
        row:121
        column: 3
        size:2
    }
    Ground{
        row:121
        column: 4
        size:2
    }
    Ground{
        row:121
        column: 5
        size:2
    }


    GroundFace{
        row:121
        column:11
        size:4
    }
    GroundFace{
        row:113
        column: 13
        size:4
    }
    GroundFace{
        row:121
        column:16
        size:3
    }
    GroundFace{
        row:127
        column:16
        size:3
    }
    GroundFace{
        row:133
        column:14
        size:2
    }
    GroundFace{
        row:138
        column:11
        size:2
    }


    GroundFace{
        row:127
        column: 5
        size:3
    }
    Ground{
        row:127
        column: 0
        size:3
    }
    Ground{
        row:127
        column: 1
        size:3
    }
    Ground{
        row:127
        column: 2
        size:3
    }
    Ground{
        row:127
        column: 3
        size:3
    }
    Ground{
        row:127
        column: 4
        size:3
    }

    GroundFace{
        row:133
        column: 6
        size:3
    }
    Ground{
        row:133
        column: 0
        size:3
    }
    Ground{
        row:133
        column: 1
        size:3
    }
    Ground{
        row:133
        column: 2
        size:3
    }
    Ground{
        row:133
        column: 3
        size:3
    }
    Ground{
        row:133
        column: 4
        size:3
    }
    Ground{
        row:133
        column: 5
        size:3
    }



    GroundFace{
        row:139
        column: 5
        size:4
    }
    Ground{
        row:139
        column: 0
        size:4
    }
    Ground{
        row:139
        column: 1
        size:4
    }
    Ground{
        row:139
        column: 2
        size:4
    }
    Ground{
        row:139
        column: 3
        size:4
    }
    Ground{
        row:139
        column: 4
        size:4
    }



    GroundFace{
        row:147
        column:8
        size:6
    }
    Ground{
        row:147
        column:0
        size:11
    }
    Ground{
        row:147
        column:1
        size:11
    }
    Ground{
        row:147
        column:2
        size:11
    }
    Ground{
        row:147
        column:3
        size:11
    }
    Ground{
        row:147
        column:4
        size:11
    }
    Ground{
        row:147
        column:5
        size:11
    }
    Ground{
        row:147
        column:6
        size:11
    }
    Ground{
        row:147
        column:7
        size:11
    }
    GroundFace{
        row:153
        column: 11
        size:2
    }
    Ground{
        row:153
        column:10
        size:2
    }
    Ground{
        row:153
        column:9
        size:2
    }
    Ground{
        row:153
        column:8
        size:2
    }
    GroundFace{
        row:155
        column:9
        size:3
    }
    Ground{
        row:155
        column:8
        size:3
    }

    GroundFace{
        row:144
        column:16
        size:5
    }
    GroundFace{
        row:149
        column:15
        size:3
    }


    GroundFace{
        row:163
        column:7
        size:3
    }
    GroundFace{
        row:171
        column: 7
        size:20
    }

    //    Ground{
    //        row:100
    //    }
}
