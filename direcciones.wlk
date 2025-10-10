import wollok.game.*

object izquierda {
    method siguiente(posicion) {
        return if (posicion.x() > 0) posicion.left(1) else posicion
    }
}

object derecha {
    method siguiente(posicion) {
        return if (posicion.x() < game.width() - 1) posicion.right(1) else posicion
    }
}

object abajo {
    method siguiente(posicion) {
        return if (posicion.y() > 0) posicion.down(1) else posicion
    }
}

object arriba {
    method siguiente(posicion) {
        return if (posicion.y() < game.height() - 1) posicion.up(1) else posicion
    }
}