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
		if(fondo!=null){
			self.parar()
		}
		fondo = game.sound("musicaFondo.mp3")
		fondo.shouldLoop(true)
		game.schedule(500, { fondo.play()} )
	}
	
	method gameOver(){
		self.parar()
		fondo = game.sound("sonidoGameOver.mp3")
		fondo.play()
		game.schedule(5000, {fondo = game.sound("musicaFondo.mp3")//cambiar por musica de game over para loop
							fondo.shouldLoop(true)
							fondo.play()
		} )
	}
	
	method finalBoss(){
		self.parar()
		fondo = game.sound("musicaJefe.mp3")
		fondo.shouldLoop(true)
		game.schedule(500, { fondo.play()} )
	}
	method parar(){
		fondo.shouldLoop(false)
		fondo.stop()
	}
}