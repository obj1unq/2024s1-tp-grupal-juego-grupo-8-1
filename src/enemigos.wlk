import wollok.game.*
import nivel.*
import nave.*


class Invasor {

	var property position
	const escenario = tablero
	var moverHacia = izquierdaInvasor
	const property nivel
	var vida = null
	
	method vida(){
		return vida
	}
	
	method definirVida()
	
	method image()

	method moverHacia(_moverHacia) {
		moverHacia = _moverHacia
	}
	
	method atacado(valor) {
		if (vida-valor == 0) {
			self.eliminarmeDeJuego()
			self.eliminarmeDelNivel()			
		}
		else vida -= valor
	}
	method eliminarmeDeJuego() {
		game.removeVisual(self)
		game.removeTickEvent("invasion" + self.identity())
	}
	
	method eliminarmeDelNivel() {
		nivel.quitarInvasor(self)
		nivel.ganar()
	}
	method movimiento() {
		if (self.puedeMover(moverHacia)) {
			position = moverHacia.siguiente(self.position())
		} else {
			self.bajarYCambiarDireccion()
		}
	}
	
	method bajarYCambiarDireccion() {
		self.bajar()
		moverHacia.cambiarOpuesto(self)	
	}
	method bajar() {
		position = abajo.siguiente(self.position()) 
		
	}	
	method puedeMover(direccion) {
		return escenario.puedeIr(self.position(), direccion)
	}
	method colision(cohete) {
		cohete.morir()
	}
	
	method morir() {
		
	}

}

class InvasorVerde inherits Invasor{
	
	 override method definirVida(){
		vida=1
	}
	
	override method image(){
		return "invasor-Verde.png"
	}
}

class InvasorFuerte inherits Invasor{
	
	override method definirVida(){
		vida=3
	}
	
	override method image(){
		return "enemigoFuerte.png"
	}
}

class Nodriza inherits Invasor{
	
	override method definirVida(){
		vida=5
	}
	
	override method image(){
		return "nodriza.png"
	}
}

class FactoryInvasor {
	
	method invasor(posicion, nivel)
	
	method crearInvasor(posicion,nivel_){
		const invasor = self.invasor(posicion, nivel_)
		invasor.definirVida()
		game.addVisual(invasor)
		game.onCollideDo(invasor, {algo => algo.colision(invasor)})
		game.onTick(500, "invasion"+ invasor.identity(), {invasor.movimiento()})
		nivel_.enemigos().add(invasor)
		return invasor
	}
}


object invasorVerdeFactory inherits FactoryInvasor {

	override method invasor(posicion, _nivel) {
		return new InvasorVerde(nivel= _nivel, position=posicion)
}

}

object invasorFuerteFactory inherits FactoryInvasor {

	override method invasor(posicion, _nivel) {
		return new InvasorFuerte(nivel= _nivel, position=posicion)
}

}

object nodrizaFactory inherits FactoryInvasor{
	
	override method invasor(posicion, _nivel) {
		return new Nodriza(nivel= _nivel, position=posicion)
	}
	
}








