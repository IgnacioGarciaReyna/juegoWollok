import wollok.game.*

object contrarios {

	const property todos = #{}

	method agregarNuevo() {
		const nuevo = new Contrario()
		game.addVisual(nuevo)
		todos.add(nuevo)
	}

	method avanzarTodos() {
		todos.forEach({ contrario => contrario.avanzar()})
	}

}

class Contrario {

	var property image = "aleman.png"
	var property position = game.at(19, (0 .. 4).anyOne())

	method avanzar() {
		position = position.left(1)
	}

}

