import wollok.game.*
import nivel.*
import disparo.*
import gameOver.*
import sonido.*

class Nave {
	var property estadoNave = vivo
	var property position = game.at(12,0)
	var property puedeDisparar=true
	const invasor = false
	const property bando = terrestre
	var property vida
	var property daniado=false
	
	method image()
	
	method estadoNave(estadoNave_) { 
			estadoNave = estadoNave_
	}
	method reiniciarNave(){
		estadoNave=vivo
		position = game.at(12,0)
		puedeDisparar = true
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
			self.tipoBala().crearBala(self,arriba)
			game.sound("disparo.mp3").play()
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
	
	method atacado(bala){
		soundProducer.sound("hitNave.mp3").play()
		if(vida-bala.damage()<= 0){
			vida=vida-bala.damage()
			self.morir()
		}else{	vida=vida-bala.damage()
				game.onTick(100, "daniado", {self.daniado()})
				game.schedule(500, { 	game.removeTickEvent("daniado")
										self.daniado(false)
				} )
		}
	}
	method daniado(){
		if(daniado){
			daniado=false
		}
		else{
			daniado=true
		}
	}
	method posicionCanion(){
		return game.at(self.position().x(), self.position().y() + 1)
	}
}
object nave1 inherits Nave(vida=5){
	var property tipoBala = balaRapidaFactory
	override method velocidadDeDisparo() {
		return 600
	}
	override method tipoBala() {
		return tipoBala
	}
	override method image(){
		return 
		if(not daniado){
			"nave.png"
		}
		else{
			"navedaniado.jpg"
		}
	}
	override method reiniciarNave(){
		super()
		vida=5
		
	}
}
object nave2 inherits Nave(vida=3){
	var property tipoBala = balaFuerteFactory
	override method velocidadDeDisparo() {
		return 1000
	}
	override method reiniciarNave(){
		super()
		vida=3
		
	}
	override method tipoBala() {
		return tipoBala
	}
	override method image(){
		return 
		if(not daniado){
			"nave2.png"
		}
		else{
			"navedaniado.jpg"
		}
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
		nave.position(game.at(12,1))
		nave.estadoNave(vivo)
		//game.schedule(1000, { game.stop()})
	}
}

object destruido inherits EstadoDeNave{
	override method activar() {
		game.clear()
		menuGameOver.iniciar(nave)
		//game.schedule(5000, { game.stop()})
	}
}
	


