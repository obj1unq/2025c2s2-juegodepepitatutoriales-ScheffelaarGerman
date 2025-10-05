import wollok.game.*
import comidas.*  

// ** Pepita ** //
object pepita {
    var property position = game.at(0, 4)
    var property energia = 500  
    const muros = [muro1, muro2, muro3, muro4]
    const comidas = [manzana, alpiste]

    method volar(direccion) {
        const nuevaPos = direccion.siguiente(position)
        if (!self.hayMuroEn(nuevaPos) && !self.estaAgotada()) {
            position = nuevaPos
            energia -= 9  
            if (self.estaAgotada()) {
                game.say(self, "¡PERDÍ!")  
                game.schedule(2000, { game.stop() })  
            }
        }
    }

    method hayMuroEn(pos) {
        return muros.any({ muro => muro.position() == pos })
    }

    method quedanComidas() {
        return comidas.any({ comida => game.hasVisual(comida) })  
    }

    method caerPorGravedad() {
        const nuevaPos = position.down(1)
        if (position.y() > 2 && !self.hayMuroEn(nuevaPos)) {
            position = nuevaPos  
        }
    }

    method estaAgotada() {
        return energia < 9  
    }

    method image() {
        if (self.estaAgotada()) {
            return "pepita-gris.png" 
        } else {
            return "pepita.png"
        }
    }

    method colisionarCon(otro) {
        otro.colisionarCon(self) 
    }
}

//** Nido **//
object nido {
    const property position = game.at(4, 8)
    method image() = "nido.png"

    method colisionarCon(pepita) {
        if (!pepita.quedanComidas()) {
            game.say(pepita, "¡GANE!") 
            game.schedule(2000, { game.stop() }) 
        }             
    }
}

// ** Muros **//
object muro1 {
    const property position = game.at(4, 2)
    method image() = "muro.png"
    method colisionarCon(pepita) { }  
}

object muro2 {
    const property position = game.at(6, 4)
    method image() = "muro.png"
    method colisionarCon(pepita) {}
}

object muro3 {
    const property position = game.at(8, 6)
    method image() = "muro.png"
    method colisionarCon(pepita) {}
}

object muro4 {
    const property position = game.at(2, 6)
    method image() = "muro.png"
    method colisionarCon(pepita) {}
}

// ** Silvestre ** //
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

    method image() {
        return "silvestre.png"
    }

    method colisionarCon(pepita) {
        game.say(pepita, "¡PERDÍ!")  
        game.schedule(2000, { game.stop() })  
    }
}

// ** Direcciones ** //
object izquierda {
    method siguiente(posicion) {
        if (posicion.x() > 0) {
            return posicion.left(1)
        } else {
            return posicion
        }
    }
}

object derecha {
    method siguiente(posicion) {
        if (posicion.x() < game.width() - 1) {
            return posicion.right(1)
        } else {
            return posicion
        }
    }
}

object abajo {
    method siguiente(posicion) {
        if (posicion.y() > 0) {
            return posicion.down(1)
        } else {
            return posicion
        }
    }
}

object arriba {
    method siguiente(posicion) {
        if (posicion.y() < game.height() - 1) {
            return posicion.up(1)
        } else {
            return posicion
        }
    }
}