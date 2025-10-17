import wollok.game.*
import pepita.*
import randomizer.*

//** Fábricas **//
object manzanaFactory {
    method crear() {
        return new Manzana(position = randomizer.emptyPosition())
    }
}

object alpisteFactory {
    method crear() {
        return new Alpiste(
            position = randomizer.emptyPosition(), 
            peso = (40..100).anyOne() 
        )
    }
}

//** central de comidas **//
object comidas {
    const factories = [manzanaFactory, alpisteFactory] 
    const enElTablero = #{}

    method comenzar() {
        game.onTick(3000, "COMIDAS", { self.nuevaComida() })
    }

    method maximo() = 3

    method nuevaComida() {
        if (enElTablero.size() < self.maximo()) {
            const comida = self.crearComida()
            game.addVisual(comida)
            enElTablero.add(comida)
        }
    }

    method crearComida() {
        return self.elegirFactory().crear()
    }

    method elegirFactory() = factories.anyOne()

    method remover(comida) {
        if (enElTablero.contains(comida)) {
            enElTablero.remove(comida)
            game.removeVisual(comida)
        }
    }
}

//** Clases **//
class Manzana {
    const base = 5
    var madurez = 1
    const property position

    method image() = "manzana.png"
    method atravesable() = true

    method energiaQueOtorga() = base * madurez

    method madurar() {
        madurez += 1
    }

    method colisionarCon(pepita) {
        pepita.comer(self)
    }
}

class Alpiste {
    const property position
    const peso

    method image() = "alpiste.png"
    method atravesable() = true

    method energiaQueOtorga() = peso 

    method colisionarCon(pepita) {
        pepita.comer(self)
    }
}

