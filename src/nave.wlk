import wollok.game.*
import nivel.*
import disparo.*
class Nave {
	var property estadoNave = vivo
	var property position = game.at(12,0)
	var property puedeDisparar=true
	method image()
	
	method estadoNave(estadoNave_) { 
			estadoNave = estadoNave_
	}
	
 	method mover(direccion) {
 		if(self.puedeMover(direccion)){
			position = direccion.siguiente(self.position())
			}
	}
	method puedeMover(direccion){
		return estadoNave.puedeMover() && tablero.puedeIr(self.position(),direccion)
	}
	method ganar() {
		self.estadoNave(ganador)
		self.activarEstado()
	}
	method morir(){
		self.estadoNave(destruido)
		self.activarEstado()
	} 
	method disparar() {
		if (puedeDisparar) {
			self.tipoBala().crearBala(self)
			self.puedeDisparar(false)
			game.schedule(self.velocidadDeDisparo(), {self.puedeDisparar(true)})
			}
	}
	method tipoBala() 
	method velocidadDeDisparo()
	method activarEstado() {
		estadoNave.nave(self)
		estadoNave.activar()		
	}
	method colision(algo) {
		
	}
}
object nave1 inherits Nave{
	var property tipoBala = balaRapidaFactory
	override method velocidadDeDisparo() {
		return 600
	}
	override method tipoBala() {
		return tipoBala
	}
	override method image(){
		return "nave.png"
	}
}
object nave2 inherits Nave{
	var property tipoBala = balaFuerteFactory
	override method velocidadDeDisparo() {
		return 1000
	}
	override method tipoBala() {
		return tipoBala
	}
	override method image(){
		return "nave2.png"
	}
}
class EstadoDeNave {
	var property nave = null
	
	method puedeMover() = false
	
	method puedeDisparar() = false
	
	method activar()
}

object vivo inherits EstadoDeNave{
	override method puedeMover() = true
	override method activar() {
	}

}


object ganador inherits EstadoDeNave {
	
	override method activar(){
		game.say(nave, "Mision Cumplida!")
		nave.position(game.at(12,1))
		game.schedule(1000, { game.stop()})
	}
}

object destruido inherits EstadoDeNave{
	override method activar() {
		game.clear()
		game.addVisualIn(nave,game.at(12,1))
		game.say(nave, "Mision Fallida!")
		game.schedule(1000, { game.stop()})
	}
}

