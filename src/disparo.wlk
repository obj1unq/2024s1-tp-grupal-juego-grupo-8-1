import nave.*
import wollok.game.*
import nivel.*

class Bala {

	var property velocidad
	var property position = null
	var property image
	const moverHacia = arriba
	var property damage

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

object balaFactory {

	method crearBala(nave) {
		const bala = new Bala(image = "shot_basic.png", velocidad = 200, damage = 1)
		bala.position(game.at(nave.position().x(), nave.position().y() + 1))
		game.addVisual(bala)
		game.onTick(bala.velocidad(), "recorrido de bala " + bala.identity(), { bala.recorrer()})
		return bala
	}

}

