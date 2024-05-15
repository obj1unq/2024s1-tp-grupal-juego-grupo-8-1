import wollok.game.*
import nivel.*
class Nave {
	var property estadoNave = vivo
	var property position = game.at(12,0)
	
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
		estadoNave.nave(self)
		estadoNave.activar()
	}
	method morir(){
		self.estadoNave(destruido)
		estadoNave.nave(self)
		estadoNave.activar()
	}
	method atacar(){
		/*if(puedeDisparar()){
			bala.disparar()
		}*///cuando este la clase bala creada se agregara el disparo
	}
	method puedeDisparar(){
		return estadoNave.puedeDisparar()
	}
	method colision(algo) {
		
	}
}
object nave1 inherits Nave{
	override method image(){
		return "nave.png"
	}
}
object nave2 inherits Nave{
	override method image(){
		return "nave2.png"
	}
}
object vivo {
	
	method puedeMover() = true
	
	method puedeDisparar() = false

	method activar() {
	}

}

object ganador{
	
	var property nave = null
	
	method puedeMover() = false
	
	method puedeDisparar() = false
	
	method activar(){
		game.say(nave, "Mision Cumplida!")
		nave.position(game.at(12,1))
		game.schedule(1000, { game.stop()})
	}
}

object destruido{
	
	var property nave = null
	
	method puedeMover() = false
	
	method puedeDisparar() = false
	
	method activar() {
		game.clear()
		game.addVisualIn(nave,game.at(12,1))
		game.say(nave, "Mision Fallida!")
		game.schedule(1000, { game.stop()})
	}
}

