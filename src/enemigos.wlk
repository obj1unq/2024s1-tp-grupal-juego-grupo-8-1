import wollok.game.*
import nivel.*
import nave.*
import disparo.*
import sonido.*


class Invasor {

	var property position
	const escenario = tablero
	var moverHacia = izquierdaInvasor
	const property nivel
	var vida = null
	const invasor = true
	const property bando = invasores
	
	method velocidad()
	
	method vida(){
		return vida
	}
	
	method definirVida()
	
	method image()

	method moverHacia(_moverHacia) {
		moverHacia = _moverHacia
	}
	
	method recibirDanio(valor){
		if (vida-valor <= 0) {
			self.morir()
		}
		else vida -= valor
	}
	
	method atacado(disparo) {
		if(bando!=disparo.bando()){
			self.recibirDanio(disparo.damage())
		}
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
	
	method iniciarOntick(){
		game.onTick(self.velocidad(), "invasion"+ self.identity(), {self.movimiento()})
	}
	
	method morir() {
		soundProducer.sound("muerte.mp3").play()
		self.eliminarmeDeJuego()
		self.eliminarmeDelNivel()
	}

}

class InvasorVerde inherits Invasor{
	
	override method velocidad(){
		return 500
	}
	
	 override method definirVida(){
		vida=1
	}
	
	override method image(){
		return "invasor-Verde.png"
	}
}

class InvasorFuerte inherits Invasor{
	
	override method velocidad(){
		return 500
	}
	
	override method definirVida(){
		vida=3
	}
	
	override method image(){
		return "enemigoFuerte.png"
	}
}

class Ovni inherits Invasor{
	
	override method velocidad(){
		return 500
	}
	
	override method definirVida(){
		vida=2
	}
	
	override method image(){
		return "nave_invasor.png"
	}
	
	override method iniciarOntick(){
		super()
		game.onTick(1500, "asalto"+ self.identity(), {self.disparar()})
	}
	method disparar(){
		balaEnemigoFactory.crearBala(self,abajo)
	}
	method posicionCanion(){
		return game.at(self.position().x(), self.position().y() - 1)
	}
	override method morir(){
		super()
		game.removeTickEvent("asalto" + self.identity())
	}
}

class Nodriza inherits Invasor{
	
	override method velocidad(){
		return 1000
	}
	
	override method definirVida(){
		vida=5
	}
	
	override method image(){
		return "nodriza.png"
	}
	
	override method movimiento() {
		if (self.puedeMover(moverHacia)) {
			position = moverHacia.siguiente(self.position())
		} else {
			moverHacia.cambiarOpuesto(self)
			position = moverHacia.siguiente(self.position())
		}
	}
	
	method invocarEnemigos(){
		invasorVerdeFactory.crearInvasor(position.down(1),nivel)
	}
	
	override method eliminarmeDeJuego(){
		super()
		game.removeTickEvent("refuerzos" + self.identity())
	}
}

class FactoryInvasor {
	
	method invasor(posicion, nivel)
	
	method crearInvasor(posicion,nivel_){
		const invasor = self.invasor(posicion, nivel_)
		invasor.definirVida()
		game.addVisual(invasor)
		game.onCollideDo(invasor, {algo => algo.colision(invasor)})
		invasor.iniciarOntick()
		nivel_.agregarEnemigo(invasor)
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

object ovniFactory inherits FactoryInvasor{
	
	override method invasor(posicion, _nivel) {
		return new Ovni(nivel= _nivel, position=posicion)
	}
	
}

object nodrizaFactory inherits FactoryInvasor{
	
	override method invasor(posicion, _nivel) {
		return new Nodriza(nivel= _nivel, position=posicion)
	}
}








