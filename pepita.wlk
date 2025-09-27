object pepita {
    var energia = 100
    var property position = game.at(0, 4)

    method comer(comida) {
        energia = energia + comida.energiaQueOtorga()
    }

    method volar(kms) {
        energia = energia - 10 - kms 
    }
    
    method energia() {
        return energia
    }

    method image() {
        if (self.esAtrapada()){
            return "pepita-gris.png"
        } else if (self.estaEnNido()){
            return "pepita-grande.png"
        } else {
          return  "pepita.png"
        }
   }

    method esAtrapada() { return self.position() == silvestre.position()}

    method estaEnNido() {return self.position() == nido.position()}

    method moverSiEsPosicionValida(unaPosicion) {
        if (self.esPosicionValida(unaPosicion)) {
            position = unaPosicion
        }
    }

        method esPosicionValida(unaPosicion) {
            return unaPosicion.x() >= 0
                && unaPosicion.x() < game.width()
                && unaPosicion.y() >= 0
                && unaPosicion.y() < game.height()
            
        }



    method subir() { self.moverSiEsPosicionValida(position.up(1))}
    
    method bajar() { self.moverSiEsPosicionValida(position.down(1))}
    
    method derecha() {self.moverSiEsPosicionValida(position.right(1))}       
    
    method izquierda() {self.moverSiEsPosicionValida(position.left(1))}

}
object silvestre {
    var property position = game.at(6, 2)
    
    method image()
    { return "silvestre.png" }

    method perseguir(personaje) {
    if (personaje.position().x() > self.position().x()) {
        const nuevaX = (self.position().x()+ 1).min(7)
        position = game.at(nuevaX, self.position().y())
        position = position.right(1)
    } else if (personaje.position().x() < self.position().x()) {
        const nuevaX = (self.position().x() - 1).max(1)
        position = game.at(nuevaX, self.position().y())
    }
}

    }


object nido {
    const property position = game.at(4,8)

    method image() { return "nido.png" }
}