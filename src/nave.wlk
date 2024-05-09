import wollok.game.*
import nivel.*
object nave {
	var property estadoNave = vivo
	
	var property position = game.at(15,1)
	
	method image(){
		return "nave.png"
	}
	method estadoNave(estadoNave_) {
		if (estadoNave != estadoNave_) {
			estadoNave = estadoNave_
			estadoNave.activar()
		}
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
	}
	method morir(){
		self.estadoNave(destruido)
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

object vivo {
	method puedeMover() = true
	
	method puedeDisparar() = false

	method activar() {
	}

}

object ganador{
	method puedeMover() = false
	
	method puedeDisparar() = false
	
	method activar(){
		game.say(nave, "Mision Cumplida!")
		nave.position(game.at(15,1))
		game.schedule(1000, { game.stop()})
	}
}

object destruido{
	method puedeMover() = false
	
	method puedeDisparar() = false
	
	method activar() {
		game.say(nave, "Mision Fallida!")
		game.schedule(1000, { game.stop()})
	}
}

