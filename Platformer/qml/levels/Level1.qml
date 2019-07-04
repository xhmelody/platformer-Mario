import Felgo 3.0
import QtQuick 2.0
import "../entities"
import "." as Levels

Levels.LevelBase {
  id: level

  width: 42 * gameScene.gridSize



  EnemySnowmanjump{
      row:14
      column: 9
      size: 1
      //changeDirection:true
  }
  Block{
      row:12
      column: 12
      size: 1
  }






  EnemySnowman{
      row : 19
      column: 9
      size:1
  }

  //金币
    Repeater{
        model: 6
        Coin{
            row: 5+index*2
            column: 14
            size: 1
        }
    }

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
    GroundFace{
    row:19
    column: 4
    size:4
    }
    EnemyCrystallo{
        row:19
        column: 5
        size: 1
    }

//    Snowball{
//        row:22
//        column: 5
//        size: 1
//    }


    EnemyBighead{
    row:25
    column: 10
    size: 1
    }

    GroundFace{
       row:25
       column:9
       size:4
   }

  EnemyHedgehog{
      row:25
      column: 8
      size: 1
  }

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
    EnemySnowmanjump{
        row:32
        column: 7
        size: 1
        changeDirection: true
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
    EnemyBighead{
        row:42
        column: 7
        size:1
    }


    Ground{
        row:45
        column: 0
        size:18
    }
    Ground{
        row:45
        column: 1
        size:18
    }
    Ground{
        row:45
        column: 2
        size:18
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
        size:11
    }
    Repeater{
       model:3
        Coin{
      row:48+index
      column: 11+index*2
      size:1
    }
    }
    Repeater{
      model:3
        Coin{
            row:51+index
            column:15
            size: 1
        }
}
Repeater
{
    model: 3
    Coin{
        row:54+index*2
        column: 15-index*2
        size: 1
    }
}


    Enemyironhead{
        row:49
        column: 4
        size: 1
        verticalJumpForce: 350
       //changeverticalJumpForce()
    }

    Enemyironhead{
        row:53
        column: 4
        size:1
    }
    Enemyironhead {
        row:57
        column: 4
        size: 1
        verticalJumpForce: 350
    }


    Ground{
        row:59
        column:3
        size:4
    }
    Ground{
        row:59
        column:4
        size:4
    }
    Ground{
        row:59
        column:5
        size:4
    }
    Ground{
        row:59
        column:6
        size:4
    }
    GroundFace{
        row:59
        column:7
        size:4
    }
    GroundFace{
        row:59
        column: 14
        size:3
    }

    GroundFace{
        row:64
        column: 10
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
    Ground{
        row:67
        column: 14
        size:5
    }
    GroundFace{
        row:67
        column: 15
        size:5
    }
    Snowball{
        row:70
        column: 16
        size: 1
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
    EnemyHedgehog{
        row:88
        column: 11
        size: 1
    }
Coin{
    row:87
    column: 11
    size: 1
}

    GroundFace{
        row:87
        column:10
        size:10
    }

Repeater{
    model:5
    Coin{
         row:101
         column:10+index
         size: 1
          }
}
Repeater{
    model:5
    Coin{
         row:102
         column:10+index
         size: 1
          }
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
        column:6
        size:5
    }
    Enemyironhead{
        row:112
        column: 7
        size:1
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

Coin{
    row:121
    column: 7
    size: 1
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
        row:114
        column: 13
        size:5

    }
    Coin{
        row:127
        column: 17
        size: 1
    }
    Block{
        row:116
        column: 17
        size:1
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
    Coin{
        row:133
        column: 7
        size: 1
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


    Coin{
        row:147
        column: 8
        size: 1
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
Repeater{
    model:3
   Coin{
       row:163+index
       column: 8
       size: 1
   }
}
GroundFace{
        row:163
        column:7
        size:3
    }
    GroundFace{
        row:176
        column: 7
        size:20
    }
Platform{
   row:171
   column: 14
   size: 5

}
    Repeater{
        model: 9
      Finish{
         row:189
         column: 8+index
         size:1
      }
      }

    Repeater{
          model:4
        EnemySnowmanjump{

            row:179+index*3
            column: 8
            size: 1
            changeDirection: true
    }
}

}
