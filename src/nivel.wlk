import nave.*
import wollok.game.*
import enemigos.*
import disparo.*
import mapaNivel.*
import menu.*
import sonido.*
import victoria.*

class Nivel {
	var property nave = null
	
	var property enemigos = []
	
	method celdas()
	
	method generar() {
		game.width(self.celdas().anyOne().size())
		game.height(self.celdas().size())
		(0..game.width() -1).forEach({x =>
			(0..game.height() -1).forEach( {y =>
				self.generarCelda(x,y)
			})
		})
	}
	
	method generarCelda(x,y) {
		const celda = self.celdas().get(y).get(x)
		celda.generar(game.at(x,y),self)
	}
	
	method limpiarEnemigos() {
		enemigos=[]		
	}
	method iniciar(){
		//VISUALES
		self.limpiarEnemigos()
		self.generar()
		nave.reiniciarNave()
		//COMPORTAMIENTO DE NAVE
		keyboard.left().onPressDo({ nave.mover(izquierda) })
		keyboard.right().onPressDo({ nave.mover(derecha) })
		game.onCollideDo(nave, { algo => algo.colision(nave) })
		//BALA
		keyboard.space().onPressDo({ 	nave.disparar()
										
		})
		
		//keyboard 
		keyboard.r().onPressDo({game.clear()
								menu.iniciar()})	
								
		/*keyboard.g().onPressDo({game.clear()
								menuVictoria.iniciar(nave)})	*/
	
	}
	method agregarEnemigo(invasor){
		enemigos.add(invasor)
	}
	
	
	method ganar(){
		if (enemigos.isEmpty()){
			nave.ganar()
			game.schedule(100, {self.siguientePantalla()})
		}
	}
	
	method siguientePantalla()
		
	
	
	method quitarInvasor(enemigo){
		enemigos.remove(enemigo)
	}
	
}

object nivel1 inherits Nivel{
	
	var celdas = [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,v,_,v,_,v,_,o,_,v,_,o,_,v,_,v,_,v,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,o,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,o,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_]
	].reverse()
	
	override method celdas(){
		return celdas
	}
	
	override method siguientePantalla(){
		game.clear()
		nivel2.nave(self.nave())
		nivel2.iniciar()
	}
}

object nivel2 inherits Nivel{
	
	var celdas = [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,v,_,o,_,v,_,o,_,v,_,o,_,v,_,o,_,v,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,o,_,v,_,v,_,v,_,o,_,v,_,v,_,v,_,o,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,o,_,v,_,o,_,v,_,o,_,v,_,o,_,v,_,o,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_]
	].reverse()
	
	override method celdas(){
		return celdas
	}
	
	override method siguientePantalla(){
		game.clear()
		nivel3.nave(self.nave())
		nivel3.iniciar()
		musicaFondo.finalBoss()
	}
	
}

object nivel3 inherits Nivel{
	
	var celdas = [
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,n,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,o,_,v,_,v,_,f,_,f,_,v,_,v,_,v,_,o,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,v,_,f,_,f,_,v,_,v,_,v,_,f,_,f,_,v,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,v,_,o,_,o,_,f,_,f,_,v,_,o,_,o,_,v,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,f,_,v,_,v,_,v,_,v,_,v,_,v,_,v,_,f,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_],
		[_,_,_,_,_,_,_,_,_,_,_,_,c,_,_,_,_,_,_,_,_,_,_,_,_]
	].reverse()
	
	override method celdas(){
		return celdas
	}
	
	override method siguientePantalla(){
		game.clear()
		menuVictoria.iniciar(nave) 
	}
}


//posiciones temporal

object arriba {
	method siguiente(position) {
		return position.up(1)
	}
}

object abajo {
	method siguiente(position) {
		return position.down(1)
	}	
}

object izquierda {
	method siguiente(position) {
		return position.left(1)
	}
}
object derecha {
	method siguiente(position) {
		return position.right(1)
	}
}


//MOVIMIENTOS INAVASOR
object izquierdaInvasor {

	const opuesto = derechaInvasor

	method cambiarOpuesto(invasor) {
		invasor.moverHacia(opuesto)
	}

	method siguiente(position) {
		return position.left(1)
	}

}

object derechaInvasor {

	const opuesto = izquierdaInvasor

	method cambiarOpuesto(invasor) {
		invasor.moverHacia(opuesto)
	}

	method siguiente(position) {
		return position.right(1)
	}

}
object tablero {
	
	method pertenece(position) {
		return position.x().between(0, game.width() - 1) &&
			   position.y().between(0, game.height() -1 ) 
	}
	
	method puedeIr(desde, direccion) {
		const aDondeVoy = direccion.siguiente(desde) 
		return self.pertenece(aDondeVoy)
	}
	
	
}

object terrestre{
	
}

object invasores{
	
}