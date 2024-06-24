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
	
	var loop = false
	
	method iniciar(){
		self.parar()
		fondo = soundProducer.sound("musicaFondo.mp3")
		fondo.shouldLoop(true)
		loop = true
		game.schedule(500, { fondo.play()} )
	}
	
	method gameOver(){
		self.parar()
		fondo = soundProducer.sound("sonidoGameOver.mp3")
		fondo.play()
		loop = false
		
	}
	
	method finalBoss(){
		self.parar()
		fondo = soundProducer.sound("musicaJefe.mp3")
		fondo.shouldLoop(true)
		loop = true
		game.schedule(500, { fondo.play()} )
	}
	method parar(){
		if(loop){
			fondo.shouldLoop(false)
			fondo.stop()
		}
	}
}