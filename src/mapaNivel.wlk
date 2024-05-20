import enemigos.*
import nave.*
import wollok.game.*
import nivel.*

object _ {
	
	method generar(position,nivel){
		
	}
}

object v{
	method generar(position,nivel){
		invasorVerdeFactory.crearInvasor(position,nivel)
	}
	
}

object f{
	method generar(position,nivel){
		invasorFuerteFactory.crearInvasor(position,nivel)
	}
	
}
object n{
	method generar(position,nivel){
		 nodrizaFactory.crearInvasor(position,nivel)
	}
	
}

object c{
	method generar(position,nivel){
		game.addVisual(nivel.nave())
	}
	
}