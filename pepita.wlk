import wollok.game.*

// ** Pepita **
object pepita {
    var property position = game.at(0, 4)
    var property energia = 500  

    const muros = [muro1, muro2, muro3, muro4]

    method volar(direccion) {
        const nuevaPos = direccion.siguiente(position)  
     
        if (!self.hayMuroEn(nuevaPos) && energia >= 9) {  
            position = nuevaPos
            energia -= 9
          
            if (self.estaAgotada()) {
                game.stop()
            }
        }
    }

    method hayMuroEn(pos) {
        return muros.any({ muro => muro.position() == pos })
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
        if (self.estaAgotada() || self.esAtrapada()) {
            return "pepita-gris.png"
        } else {
            return "pepita.png"
        }
    }

    method esAtrapada() {
        return position == silvestre.position()
    }
}

//** Muros **//
object muro1 {
    const property position = game.at(4, 2)  
    method image() = "muro.png"
}

object muro2 {
    const property position = game.at(6, 4) 
    method image() = "muro.png"
}

object muro3 {
    const property position = game.at(8, 6) 
    method image() = "muro.png"
}

object muro4 {
    const property position = game.at(2, 6) 
    method image() = "muro.png"
}

//** Silvestre **//
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
}

// ** Direcciones **//
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