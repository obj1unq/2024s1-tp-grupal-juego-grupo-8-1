import nave.*
import wollok.game.*
import nivel.*

class Bala {

	var property position  = null
	var property image     = null
	const moverHacia
	const property bando
	
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
		if(algo.bando()!=bando){
			self.removerBala()
			algo.atacado(self)
		}
		
	}
	method removerBala() {
		game.removeTickEvent("recorrido de bala " + self.identity())
		game.removeVisual(self)
	}
}

class BalaFactory {
	method bala(direccion,bando_)
	method crearBala(nave,direccion) {
		const bala = self.bala(direccion,nave.bando())
		bala.position(nave.posicionCanion())
		game.addVisual(bala)
		game.onTick(bala.velocidad(), "recorrido de bala " + bala.identity(), { bala.recorrer()})
		return bala
	}
	method posicionBala(nave){
		nave.posicionCanion()
	}

}

object balaFuerteFactory inherits BalaFactory{
	override method bala(direccion,bando_) {
		return new BalaFuerte(moverHacia=direccion,bando=bando_)
	}
}

object balaRapidaFactory inherits BalaFactory{
	override method bala(direccion,bando_) {
		return new BalaRapida(moverHacia=direccion,bando=bando_)
	}
}

object balaEnemigoFactory inherits BalaFactory{
	override method bala(direccion,bando_) {
		return new BalaEnemigo(moverHacia=direccion,bando=bando_)
	}
}

class BalaRapida inherits Bala {
 	override method image() {
 		return "shot_basic_bueno.png"
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
 		return "shot_basic_bueno2.png" // luego cambiar png
 	}
 	override method damage() {
 		return  2.5
 	}
 	override method velocidad() {
 		return 250
 	}
}

class BalaEnemigo inherits Bala{
	
	override method image() {
 		return "shot_basic.png" // luego cambiar png
 	}
 	override method damage() {
 		return  1
 	}
 	override method velocidad() {
 		return 250
 	}
 	
 	override method esUltimaPosicion() {
		return self.position().y() < 1
	}
}



