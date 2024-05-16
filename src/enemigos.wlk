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

object invasorFactory {
	const enemigos = [invasorVerdeFactory,invasorFuerteFactory,nodrizaFactory]
	
	method crearInvasores(enemigo,posiciones,nivel_){
		posiciones.forEach({posicion => enemigos.get(enemigo).crearInvasor(posicion,nivel_)})
	}
	
}

object invasorVerdeFactory {

	method crearInvasor(posicion,nivel_){
		const invasor = new InvasorVerde(position=posicion,nivel=nivel_)
		invasor.definirVida()
		game.addVisual(invasor)
		game.onCollideDo(invasor, {algo => algo.colision(invasor)})
		game.onTick(500, "invasion" + invasor.identity() , {invasor.movimiento()})
		nivel_.enemigos().add(invasor)
		return invasor
	}
}

object invasorFuerteFactory {

	method crearInvasor(posicion,nivel_){
		const invasor = new InvasorFuerte(position=posicion,nivel=nivel_)
		invasor.definirVida()
		game.addVisual(invasor)
		game.onCollideDo(invasor, {algo => algo.colision(invasor)})
		game.onTick(500, "invasion"+ invasor.identity(), {invasor.movimiento()})
		nivel_.enemigos().add(invasor)
		return invasor
	}
}

object nodrizaFactory {

	method crearInvasor(posicion,nivel_){
		const invasor = new Nodriza(position=posicion,nivel=nivel_)
		invasor.definirVida()
		game.addVisual(invasor)
		game.onCollideDo(invasor, {algo => algo.colision(invasor)})
		game.onTick(500, "invasion"+ invasor.identity(), {invasor.movimiento()})
		nivel_.enemigos().add(invasor)
		return invasor
	}
}
