import wollok.game.*

object pepita {
    var energia = 200
    var property position = game.at(0, 4)

    method comer(comida) {
        energia = energia + comida.energiaQueOtorga()
    }

    method volar() {
        if (self.tieneEnergiaParaVolar()) {
            energia = energia - 9
        }
    }
    
    method energia() {
        return energia
    }

    method tieneEnergiaParaVolar() {
        return energia >= 9
    }

    method image() {
        if (self.esAtrapada()) {
            game.say(self, "¡PERDISTE! Te atrapo Silvestre")
            game.stop()
            return "pepita-gris.png"
        } else if (not self.tieneEnergiaParaVolar()) {
            game.say(self, "¡PERDISTE! Te quedaste sin energía")
            game.stop()
            return "pepita-gris.png"
        } else if (self.estaEnNido() && self.noQuedanComidas()) {
            game.say(self, "¡GANASTE!")
            game.stop()
            return "pepita-grande.png"
        } else if (self.estaEnNido()) {
            return "pepita-grande.png"
        } else {
            return "pepita.png"
        }
    }

    method esAtrapada() { 
        return self.position() == silvestre.position()
    }

    method estaEnNido() {
        return self.position() == nido.position()
    }

    method noQuedanComidas() {
        return not game.allVisuals().contains(manzana) && not game.allVisuals().contains(alpiste)
    }

    method colisionarCon(personaje) {
        // Pepita no hace nada al colisionar consigo misma
    }

    method intentarMover(direccion) {
        if (self.tieneEnergiaParaVolar()) {
            self.moverSiEsPosicionValida(direccion)
        }
    }

    method moverSiEsPosicionValida(unaPosicion) {
        if (self.puedeMoverseA(unaPosicion)) {
            self.volar()
            position = unaPosicion
        }
    }

    method puedeMoverseA(unaPosicion) {
        return self.esPosicionValida(unaPosicion) && self.tieneEnergiaParaVolar()
    }

    method esPosicionValida(unaPosicion) {
        return unaPosicion.x() >= 0
            && unaPosicion.x() < game.width()
            && unaPosicion.y() >= 0
            && unaPosicion.y() < game.height()
    }

    method subir() { 
        if (self.tieneEnergiaParaVolar()) {
            self.intentarMover(position.up(1))
        }
    }
    
    method bajar() { 
        if (self.tieneEnergiaParaVolar()) {
            self.intentarMover(position.down(1))
        }
    }
    
    method derecha() { 
        if (self.tieneEnergiaParaVolar()) {
            self.intentarMover(position.right(1))
        }
    }       
    
    method izquierda() { 
        if (self.tieneEnergiaParaVolar()) {
            self.intentarMover(position.left(1))
        }
    }
}

object silvestre {
    var property position = game.at(6, 2)
    
    method image() { 
        return "silvestre.png" 
    }

    method perseguir(personaje) {
        if (personaje.tieneEnergiaParaVolar()) {
            const nuevaX = if (personaje.position().x() > self.position().x()) {
                (self.position().x() + 1).min(game.width() - 1)
            } else if (personaje.position().x() < self.position().x()) {
                (self.position().x() - 1).max(0)
            } else {
                self.position().x()
            }
            position = game.at(nuevaX, self.position().y())
        }
    }

    method colisionarCon(personaje) {
        personaje.image() // Llama a image() para detectar esAtrapada() y terminar el juego
    }
}

object nido {
    const property position = game.at(4, 8)

    method image() { 
        return "nido.png" 
    }

    method colisionarCon(personaje) {
        personaje.image() // Llama a image() para verificar si no quedan comidas y ganar
    }
}

object manzana {
    var property position = game.at(3, 3)
    
    method image() { 
        return "manzana.png" 
    }
    
    method energiaQueOtorga() {
        return 30
    }

    method colisionarCon(personaje) {
        personaje.comer(self)
        game.removeVisual(self)
    }
}

object alpiste {
    var property position = game.at(7, 5)
    
    method image() { 
        return "alpiste.png" 
    }
    
    method energiaQueOtorga() {
        return 20
    }

    method colisionarCon(personaje) {
        personaje.comer(self)
        game.removeVisual(self)
    }
}