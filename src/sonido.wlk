import wollok.game.*

object soundProducer {
	
	var provider = game
	
	method provider(_provider){
		provider = _provider
	}
	
	method sound(audioFile) = provider.sound(audioFile)
	
}

object soundProviderMock {
	
	method sound(audioFile) = soundMock
	
}

object soundMock {
	
	method pause(){}
	
	method paused() = true
	
	method play(){}
	
	method played() = false
	
	method resume(){}
	
	method shouldLoop(looping){}
	
	method shouldLoop() = false
	
	method stop(){}
	
	method volume(newVolume){}
	
	method volume() = 0
}

object musicaFondo{
	
	var property fondo = null
	
	method iniciar(){
		fondo = game.sound("musicaFondo.mp3")
		fondo.shouldLoop(true)
		game.schedule(500, { fondo.play()} )
	}
	
	method gameOver(){
		fondo.shouldLoop(false)
		fondo.stop()
		fondo = game.sound("sonidoGameOver.mp3")
		fondo.shouldLoop(true)
		game.schedule(500, { fondo.play()} )
	}
	
}