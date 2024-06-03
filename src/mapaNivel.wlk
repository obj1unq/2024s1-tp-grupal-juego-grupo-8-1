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
object o{
	method generar(position,nivel){
		 ovniFactory.crearInvasor(position,nivel)
	}
	
}

object c{
	method generar(position,nivel){
		game.addVisual(nivel.nave())
	}
	
}

object n{
	method generar(position,nivel){
		const nodriza= nodrizaFactory.crearInvasor(position,nivel)
		game.onTick(4000, "refuerzos"+ nodriza.identity(), {nodriza.invocarEnemigos()})
	}
	
}
/*var celdas = [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,v,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_]
	].reverse()
 mapa para pasar el nivel rapido 
 
 */