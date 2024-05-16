import wollok.game.*
import nivel.*
import nave.*

object menu {
	method iniciar(){
		game.addVisual(nave1menu)
		game.addVisual(nave2menu)
		game.addVisual(numero1)
		game.addVisual(numero2)
		keyboard.num1().onPressDo({ game.clear() nivel1.iniciar() })
		keyboard.num2().onPressDo({ game.clear() nivel1.iniciar()})
		game.start()
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