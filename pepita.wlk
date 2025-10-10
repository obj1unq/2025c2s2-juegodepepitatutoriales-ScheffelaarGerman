import wollok.game.*
import comidas.*
import direcciones.*
import extras.*

object pepita {
    var property position = game.at(0, 4)
    var property energia = 500
    var property estado = libre
    const comidas = [manzana, alpiste]

    method image() {
    if (estado == libre) {
        return if (self.estaAgotada()) "pepita-gris.png" else "pepita.png"
    } else if (estado == ganadora) {
        return "pepita-grande.png"
    } else {
        return "pepita-gris.png" 
    }
}

    method volar(direccion) {
        const nuevaPos = direccion.siguiente(position)
        self.validarMover(nuevaPos)
        position = nuevaPos
        energia -= 9
        if (self.estaAgotada()) {
            self.perder()
        }
    }

    method validarMover(pos) {
        if (!self.puedeMover(pos)) {
            self.error("No puedo ir ahí")
        }
    }

    method puedeMover(pos) {
        return !self.estaAgotada() and estado.puedeIr(pos)
    }

    method caerPorGravedad() {
        const nuevaPos = position.down(1)
        if (position.y() > 2 and estado.puedeIr(nuevaPos)) {
            position = nuevaPos
        } else if (self.estaAgotada()) {
            self.perder()
        }
    }

    method estaAgotada() {
        return energia < 9
    }

    method comer(comida) {
        energia += comida.energiaQueOtorga()
        if (game.hasVisual(comida)) {
            game.removeVisual(comida)
        }
    }

    method ganar() {
        estado = ganadora
        game.say(self, "¡GANÉ!")
        gravedad.detener()
        game.schedule(2000, { game.stop() })
    }

    method perder() {
        estado = perdedora
        game.say(self, "¡PERDÍ!")
        gravedad.detener()
        game.schedule(2000, { game.stop() })
    }

    method colisionarCon(otro) {
        otro.colisionarCon(self)
    }

    method quedanComidas() {
        return comidas.any({ comida => game.hasVisual(comida) })
    }
}

object nido {
    const property position = game.at(4, 8)
    method image() = "nido.png"
    method atravesable() = true

    method colisionarCon(pepita) {
        if (!pepita.quedanComidas()) {
            pepita.ganar()
        }
    }
}

object silvestre {
    const limiteALaIzquierda = 3
    const alturaPiso = 2
    var property position = game.at(limiteALaIzquierda, alturaPiso)

    method perseguir(personaje) {
        const xPersonaje = personaje.position().x()
        const xSilvestre = position.x()
        if (xPersonaje > xSilvestre) {
            position = derecha.siguiente(position)
        } else if (xPersonaje < xSilvestre) {
            const nuevaPos = izquierda.siguiente(position)
            position = game.at(nuevaPos.x().max(limiteALaIzquierda), alturaPiso)
        }
    }

    method image() = "silvestre.png"
    method atravesable() = true

    method colisionarCon(pepita) {
        pepita.perder()
    }
}

object muro1 {
    const property position = game.at(3, 3)
    method image() = "muro.png"
    method atravesable() = false
    method colisionarCon(pepita) {}
}

object muro2 {
    const property position = game.at(6, 4)
    method image() = "muro.png"
    method atravesable() = false
    method colisionarCon(pepita) {}
}

object muro3 {
    const property position = game.at(8, 6)
    method image() = "muro.png"
    method atravesable() = false
    method colisionarCon(pepita) {}
}

object muro4 {
    const property position = game.at(2, 6)
    method image() = "muro.png"
    method atravesable() = false
    method colisionarCon(pepita) {}
}