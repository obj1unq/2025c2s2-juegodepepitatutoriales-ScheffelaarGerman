import wollok.game.*

object pepita {
    var energia = 500
    var property position = game.at(1, 5)

    method image() {
        if (self.fueAtrapada() || self.sinEnergia()) {
            return "pepita-gris.png"
        }
        if (self.estaEnElNido()) {
            return "pepita-grande.png"
        }
        return "pepita.png"
    }

    method volar(km) {
        energia = energia - km * 9
        if (energia <= 0) {
        energia = 0
        self.quedarseSinEnergia()
        }
    }

    method energia() {
        return energia
    }

    method sinEnergia() {
        return energia <= 0
    }

    method fueAtrapada() {
        return position == silvestre.position()
    }

    method estaEnElNido() {
        return position == nido.position()
    }

    method subir() {self.mover(position.up(1))}

    method bajar() { self.mover(position.down(1)) }

    method derecha() { self.mover(position.right(1)) }

    method izquierda() { self.mover(position.left(1)) }

    method mover(siguientePosicion) {
        if (self.puedeMoverseA(siguientePosicion)) {
            self.volarHasta(siguientePosicion)
        }
    }

    method puedeMoverseA(siguientePosicion) {
        return not self.sinEnergia() && self.esPosicionValida(siguientePosicion)
    }

    method esPosicionValida(unaPosicion) {
        return unaPosicion.x() >= 0
            && unaPosicion.x() < game.width()
            && unaPosicion.y() >= 0
            && unaPosicion.y() < game.height()
    }

    method volarHasta(destino) {
        const distancia = self.distanciaA(destino)
        position = destino
        self.volar(distancia)
    }

     method quedarseSinEnergia() {
        game.stop()
    }

    method distanciaA(nuevaPosicion) {
        const distanciaEnX = (nuevaPosicion.x() - position.x()).abs()
        const distanciaEnY = (nuevaPosicion.y() - position.y()).abs()
        return distanciaEnX + distanciaEnY
    }

    method gravedad() {
        const posicionDestino = position.down(1)
        const posicionActualizada = game.at(posicionDestino.x(), posicionDestino.y().max(2))
        if (self.esPosicionValida(posicionActualizada)) {
            position = posicionActualizada
        }
    }
    
}

object silvestre {
    var property position = game.at(6, 2)

    method image() {
        return "silvestre.png"
    }

    method perseguir(personaje) {
        if (personaje.position().x() > position.x()) {
            self.mover(position.right(1))
        } else if (personaje.position().x() < position.x()) {
            self.mover(position.left(1))
        }
    }

    method mover(siguientePosicion) {
        const nuevaX = siguientePosicion.x().min(game.width() - 1).max(3)
        position = game.at(nuevaX, 2)
    }
}

object nido {
    const property position = game.at(8, 8)

    method image() {
        return "nido.png"
    }
}