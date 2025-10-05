import wollok.game.*
import pepita.*  

object manzana {
    const base = 5
    var madurez = 1
    const property position = game.at(7, 3)  
    
    method energiaQueOtorga() {
        return base * madurez  
    }
    
    method madurar() {
        madurez = madurez + 1
        
    }
    
    method image() = "manzana.png"  
    
    method colisionarCon(pepita) {
        game.removeVisual(self)  
        pepita.energia(pepita.energia() + self.energiaQueOtorga()) 
    }
}

object alpiste {
    const property position = game.at(1, 7)  
    
    method energiaQueOtorga() {
        return 20  
    }
    
    method image() = "alpiste.png"  
    
    method colisionarCon(pepita) {
        game.removeVisual(self)  
        pepita.energia(pepita.energia() + self.energiaQueOtorga())  
    }
}

