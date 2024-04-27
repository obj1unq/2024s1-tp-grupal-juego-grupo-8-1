import wollok.game.*

object pepita {

	method position() = game.at(13,1)

	method image() = "pepita.png"
	
	method colision(personaje) {
		personaje.morir()
	}

}