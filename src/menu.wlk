import wollok.game.*
import nivel.*
import nave.*

object menu {
	method iniciar(){
		
		//VISUALES DEL MENU
		game.addVisual(nave1menu)
		game.addVisual(nave2menu)
		game.addVisual(numero1)
		game.addVisual(numero2)
		
		//FONDO DE TODO EL GAME ACTUALMENTE
		game.boardGround("space.jpg")
		self.musicaFondo()
		
		//SELECCION DE NAVE
		keyboard.num1().onPressDo({ game.clear()
									
									//INICIAR NIVEL CON NAVE 1
									nivel1.nave(nave1)
								    nivel1.iniciar()
								 })
		keyboard.num2().onPressDo({ game.clear()
			
									//INICIAR NIVEL CON NAVE 2	
									nivel1.nave(nave2)
								    nivel1.iniciar()
								 })
		
		
	}
	method musicaFondo(){
		const fondo = game.sound("musicaFondo.mp3")
		fondo.shouldLoop(true)
		game.schedule(500, { fondo.play()} )
	}
}

object nave1menu {
	var property position=game.at(8,5)
	method image(){
		return "nave(agrandado).png"
	}
}

object nave2menu {
	var property position=game.at(15,5)
	 method image(){
		return "nave2 (agrandado).png"
	}
}

object numero1 {
	var property position=game.at(8,1)
	method image(){
		return "1.png"
	}
}

object numero2 {
	var property position=game.at(15,1)
	 method image(){
		return "2.png"
	}
}