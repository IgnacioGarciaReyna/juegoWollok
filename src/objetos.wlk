/** First Wollok example */ import wollok.game.*
import direcciones.*

object lionel {

	var property camiseta = "lionel-titular.png"
	var esSuplente = false
	var property position = game.at(1, 2)
	var llevandoLaPelota = false

	method camisetaTitular() {
		camiseta = "lionel-titular.png"
		esSuplente = false
	}

	method cambiarCamiseta() {
		return if (esSuplente) {
			self.camisetaTitular()
		} else {
			self.cambiarCamisetaASuplente()
		}
	}

	method cambiarCamisetaASuplente() {
		camiseta = "lionel-suplente.png"
		esSuplente = true
	}

	method image() {
		return camiseta
	}

	method buscarla() {
		position = pelota.position()
	}

	method patear() {
		self.validarSiHayPelota()
		self.soltarPelota()
		pelota.calcularPateado()
	}

	method taquito() {
		pelota.validarPosition()
		pelota.position(game.at(pelota.calculoTaquito(), pelota.position().y()))
	}

	method mover(direccion) {
		const paso = 1
		position = direccion.siguientes(position, paso)
		if (llevandoLaPelota) {
			self.moverPelota(direccion)
		}
	}

	method hayPelotaEnPosicion() {
		return position == pelota.position()
	}

	method validarSiHayPelota() {
		if (not self.hayPelotaEnPosicion()) {
			self.error("No hay pelota que llevar")
		}
	}

	method llevarPelota() {
		self.validarSiHayPelota()
		llevandoLaPelota = true
	}

	method validarSiTieneLaPelota() {
		if (not llevandoLaPelota) {
			self.error("Lionel no tiene la pelota")
		}
	}

	method soltarPelota() {
		if (llevandoLaPelota) {
			llevandoLaPelota = false
		}
	}

	method moverPelota(direccion) {
		pelota.mover(direccion, 1)
	}

}

object pelota {

	const property image = "pelota.png"
	var property position = game.at(5, 5)

	method calcularPateado() {
		if ((game.width() - self.position().x()) > 3) {
			self.mover(derecha, 3)
		} else {
			self.mover(derecha, game.width() - self.position().x() - 1)
		}
	}

	method mover(direccion, veces) {
		position = direccion.siguientes(position, veces)
	}

	method calculoTaquito() {
		const distanciaPateo = 2
		const calculo = position.x() - distanciaPateo
		return calculo.max(0)
	}

	method validarPosition() {
		if (not ( self.position() == lionel.position() )) {
			self.error("la pelota no está en la misma posicion de lionel")
		}
	}

}

