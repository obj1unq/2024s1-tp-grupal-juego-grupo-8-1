import wollok.game.*
import nivel.*
import menu.*
import nave.*
import sonido.*

object menuVictoria
 {
	method iniciar(nave){
		musicaFondo.victory()
		game.addVisual(misionCumplida)
		game.addVisualIn(nave,game.at(12,1))
		game.say(nave, "Mision Cumplida!")
		keyboard.r().onPressDo({game.clear()
							menu.iniciar()})
		keyboard.backspace().onPressDo({game.stop()})
	}
	
}
object misionCumplida{
	var property position=game.at(6,3)
	method image(){
		return "victoria.png"
	
	}
}
