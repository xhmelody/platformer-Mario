import Felgo 3.0
import QtQuick 2.0
import QtMultimedia 5.0

Item{
    id:musicManager
    Component.onCompleted: selectMusics()
    BackgroundMusic{
        id:menumusic
        autoPlay: false
        source:"../../assets/music/menuMusic.mp3"
    }
    BackgroundMusic{
        id:selectmusic
        autoPlay: false
        source:"../../assets/music/editMusic.mp3"
    }
    BackgroundMusic{
        id:playmusic
        autoPlay: false
        source:"../../assets/music/playMusic.mp3"
    }

    SoundEffect {
      id: playjumpsound
      source: "../../assets/music/phaseJump1.wav"
    }
    SoundEffect {
      id: playdiesound
      source: "../../assets/music/lose.wav"
    }


    function selectMusics(){
    if(gameWindow.state==="menu"||gameWindow.state==="level"){
        if(gameWindow.state==="menu"){
            musicManager.musicStart(menumusic)
        }else
            musicManager.musicStart(selectmusic)
        }else{
            musicManager.musicStart(playmusic)
    }
    if(gameWindow.state==="finish"){
        musicManager.musicStart(selectmusic)
    }
}

    function musicStart(music){
        if(!music.playing){
             menumusic.stop()
             selectmusic.stop()
             playmusic.stop()
             music.play()
        }
    }


    function selectSound(sound){
        if(sound==="playjumpsound"){
            playjumpsound.play()
        }else if(sound==="playdiesound"){
            playdiesound.play()
        }else{
            console.debug("unknown sound name:", sound)
    }
}
}
