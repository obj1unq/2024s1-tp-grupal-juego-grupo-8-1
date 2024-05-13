import wollok.game.*
import nivel.*
import nave.*


class Invasor {

	var property position
	const escenario = tablero
	var moverHacia = izquierdaInvasor
	const property nivel
	var vida = null
	
	method definirVida()
	
	method image()

	method moverHacia(_moverHacia) {
		moverHacia = _moverHacia
	}
	
	method atacado(valor) {
		if (vida-valor == 0) {
			game.removeVisual(self)
			nivel.quitarInvasor()
			nivel.ganar()
		}
		else vida -= valor
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
		cohete.estadoNave(destruido)
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
		return "invasorFuerte.png"
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

object enemigosFactory {
	
	method crearInvasores(posiciones,nivel_){
		posiciones.forEach({posicion => self.crearInvasor(posicion,nivel_)})
	}
	
	method crearInvasor(posicion,nivel_){
		const invasor = new InvasorVerde(position=posicion,nivel=nivel_)
		invasor.definirVida()
		game.addVisual(invasor)
		game.onCollideDo(invasor, {algo => algo.colision(invasor)})
		game.onTick(500, "invasion", {invasor.movimiento()})
		nivel_.enemigos().add(invasor)
		return invasor
	}
}
