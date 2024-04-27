import wollok.game.*

object tablero {

	method pertenece(position) {
		return position.x().between(0, game.width() - 1) && position.y().between(0, game.height() - 1)
	}

	method puedeIr(desde, direccion) {
		const aDondeVoy = direccion.siguiente(desde)
		return self.pertenece(aDondeVoy)
	}

	method hayObstaculo(position) {
		const visuales = game.getObjectsIn(position)
		return visuales.any({ visual => not visual.esAtravesable() })
	}

}

//DIRECCIONES DE INVASORES
object abajo {

	method siguiente(position) {
		return position.down(1)
	}

}

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

