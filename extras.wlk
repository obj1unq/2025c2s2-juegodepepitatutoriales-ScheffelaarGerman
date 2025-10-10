import wollok.game.*
import pepita.*

object tablero {
    method dentro(posicion) {
        return posicion.x().between(0, game.width() - 1) and posicion.y().between(0, game.height() - 1)
    }
}

object gravedad {
    const property cuerposLibres = #{pepita}

    method comenzar() {
        game.onTick(800, "GRAVEDAD", { cuerposLibres.forEach({ cuerpo => cuerpo.caerPorGravedad() }) })
    }

    method detener() {
        game.removeTickEvent("GRAVEDAD")
    }
}

object libre {
    method puedeIr(siguientePosicion) {
        return tablero.dentro(siguientePosicion) and game.getObjectsIn(siguientePosicion).all({ visual => visual.atravesable() })
    }
}

object ganadora {
    method puedeIr(siguientePosicion) {
        return false
    }
}

object perdedora {
    method puedeIr(siguientePosicion) {
        return false
    }
}


