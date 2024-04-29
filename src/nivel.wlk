import wollok.game.*
import nave.*
import enemigos.*
object nivel {
	
	method iniciar(){
		game.addVisual(nave)
		keyboard.left().onPressDo({ nave.mover(izquierda) })
		keyboard.right().onPressDo({ nave.mover(derecha) })
		
		game.onCollideDo(nave, { algo => algo.colision(nave) })
		
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
