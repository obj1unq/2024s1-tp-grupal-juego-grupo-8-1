import wollok.game.*
import nivel.*
import nave.*


class Invasor {

	var property vida
	var property image
	var property position
	const escenario = tablero
	var moverHacia = izquierdaInvasor

	method moverHacia(_moverHacia) {
		moverHacia = _moverHacia
	}
	
	method atacado(valor) {
		if (vida-valor == 0) {game.removeVisual(self)}
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

object enemigosFactory {
	
	method crearInvasores(posiciones){
		posiciones.forEach({posicion => self.crearInvasor(posicion)})
	}
	
	method crearInvasor(posicion){
		const invasor = new Invasor(image="invasor-Verde.png",position=posicion,vida=1)
		game.addVisual(invasor)
		game.onCollideDo(invasor, {algo => algo.colision(invasor)})
		game.onTick(500, "invasion", {invasor.movimiento()})
		return invasor
	}
}
