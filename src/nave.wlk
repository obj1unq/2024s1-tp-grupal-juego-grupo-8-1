import wollok.game.*
import nivel.*
object nave {
	
	var property position = game.at(15,1)
	
	method image(){
		return "nave.png"
	}
 	method mover(direct) {
 		if(tablero.puedeIr(self.position(),direct)){
			position = direct.siguiente(self.position())
			}
		}

}
