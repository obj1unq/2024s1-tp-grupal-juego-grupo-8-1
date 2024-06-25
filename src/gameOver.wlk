import wollok.game.*
import nivel.*
import menu.*
import nave.*
import sonido.*

object menuGameOver {
	method iniciar(nave){
		musicaFondo.gameOver()
		game.addVisual(gameOver)
		game.addVisualIn(nave,game.at(12,1))
		keyboard.r().onPressDo({game.clear()
							menu.iniciar()})
		keyboard.backspace().onPressDo({game.stop()})
	}
	
}
object gameOver{
	var property position=game.at(8,5)
	method image(){
		return "game over.png"
	
	}
}
