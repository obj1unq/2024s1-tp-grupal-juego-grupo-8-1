import nave.*
import wollok.game.*
import nivel.*

class Bala {

	var property position  = null
	var property image     = null
	const moverHacia = arriba
	
	method velocidad()
	
	method damage()
	method recorrer() {
		if (not self.esUltimaPosicion()) {
			position = moverHacia.siguiente(self.position())
		} else {
			self.removerBala()
		}
	}

	method esUltimaPosicion() {
		return self.position().y() >= 13
	}
	
	method colision(algo) {
		algo.atacado(self.damage())
		self.removerBala()
	}
	method removerBala() {
		game.removeTickEvent("recorrido de bala " + self.identity())
		game.removeVisual(self)
	}
}

class BalaFactory {
	method bala()
	method crearBala(nave) {
		const bala = self.bala()
		bala.position(game.at(nave.position().x(), nave.position().y() + 1))
		game.addVisual(bala)
		game.onTick(bala.velocidad(), "recorrido de bala " + bala.identity(), { bala.recorrer()})
		return bala
	}

}

object balaFuerteFactory inherits BalaFactory{
	override method bala() {
		return new BalaFuerte()
	}
}

object balaRapidaFactory inherits BalaFactory{
	override method bala() {
		return new BalaRapida()
	}
}

class BalaRapida inherits Bala {
 	override method image() {
 		return "shot_basic.png"
 	}
 	override method damage() {
 		return 1
 	}
 	override method velocidad() {
 		return 150
 	}
}

class BalaFuerte inherits Bala {
 	override method image() {
 		return "shot_basic.png" // luego cambiar png
 	}
 	override method damage() {
 		return  2.5
 	}
 	override method velocidad() {
 		return 250
 	}
}



