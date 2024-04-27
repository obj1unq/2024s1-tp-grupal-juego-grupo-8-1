import wollok.game.*
import tablero.*

class Invasor {

	var property vida
	var property image
	var property position
	const escenario = tablero
	var moverHacia = izquierdaInvasor

	method moverHacia(_moverHacia) {
		moverHacia = _moverHacia
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
	method esAtravesable() {
		return false
	}

}
