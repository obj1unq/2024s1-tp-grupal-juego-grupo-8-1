import nave.*
import wollok.game.*
import enemigos.*
import disparo.*


object nivel {
	
	var property nave = null
	
	var property posiciones = #{}
	
	var property posicionesx =[6,8,10,12,14,16,18,20]
	var property posicionesy =[4,6,8,10]
	var property enemigos = []
	
	method crearPosiciones() {
		
		posicionesx.forEach({x=> 
								posicionesy.forEach({y =>
												posiciones.add(game.at(x,y))
								})
		})
	}
	method iniciar(){
		self.crearPosiciones()
		invasorVerdeFactory.crearInvasores(posiciones,self)
		
		self.nave(nave2)
		
		game.addVisual(nave)
		keyboard.left().onPressDo({ nave.mover(izquierda) })
		keyboard.right().onPressDo({ nave.mover(derecha) })
		
		game.onCollideDo(nave, { algo => algo.colision(nave) })
		
		
		
		game.onTick(1500, "Nueva Bala ", { balaFactory.crearBala(nave)})
		
		game.start()
	}
	
	method ganar(){
		if (enemigos.isEmpty()){
			nave.ganar()
		}
	}
	
	method quitarInvasor(){
		enemigos = enemigos.drop(1)
	}
	
}


//posiciones temporal

object arriba {
	method siguiente(position) {
		return position.up(1)
	}
}

object abajo {
	method siguiente(position) {
		return position.down(1)
	}	
}

object izquierda {
	method siguiente(position) {
		return position.left(1)
	}
}
object derecha {
	method siguiente(position) {
		return position.right(1)
	}
}


//MOVIMIENTOS INAVASOR
object izquierdaInvasor {

	const opuesto = derechaInvasor

	method cambiarOpuesto(invasor) {
		invasor.moverHacia(opuesto)
	}

	method siguiente(position) {
		return position.left(1)
	}

}

object derechaInvasor {

	const opuesto = izquierdaInvasor

	method cambiarOpuesto(invasor) {
		invasor.moverHacia(opuesto)
	}

	method siguiente(position) {
		return position.right(1)
	}

}
object tablero {
	
	method pertenece(position) {
		return position.x().between(0, game.width() - 1) &&
			   position.y().between(0, game.height() -1 ) 
	}
	
	method puedeIr(desde, direccion) {
		const aDondeVoy = direccion.siguiente(desde) 
		return self.pertenece(aDondeVoy)
	}
	
	
}
