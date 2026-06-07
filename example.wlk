class Nave {
  var property velocidad //kms /seg
  var direccion
  var combustible  //en litros
  

  
  method acelerar(cuanto) {
    velocidad =  velocidad + cuanto
    return velocidad.min(100000 )
  }

  method desacelerar(cuanto){
    velocidad = velocidad - cuanto
    return velocidad.max(0)
  }
  method irHaciaElSol(){
    return 10

  }
  method escaparDelSol(){
    return -10
  }
  method ponerseParaleloAlSol(){
    return 0
  }
  method acercarseUnPocoAlSol(){
    return (direccion + 1).min(10)
  }
  method alejarseUnPocoDelSol(){
    return (direccion - 1).max(-10)
  }

  method combustible(){
    return combustible
  }
  method cargarCombustible(litros){
    combustible = combustible + litros
    return combustible
  }
  method descargarCombustible(litros){
    combustible = combustible - litros
    return combustible
  }

  method prepararViaje(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  } // cada nave sabe como debe hacerlo

  method estaTranquila(){
    return (combustible >=4000 && self.velocidad() < 12000)
  }
}

//Distintos tipos de nave

class NavesBaliza inherits Nave{
    var baliza

    method mostrarBaliza(){
      return baliza
    }

    method cambiarColorDeBaliza(colorNuevo){
      baliza = colorNuevo
    }
    override method prepararViaje(){
      super()
      self.cambiarColorDeBaliza("verde")
      self.ponerseParaleloAlSol()
    }
    override method estaTranquila(){
      
      return super() && baliza != "rojo"


    }
}

class NavesDePasajeros inherits Nave{
  var cantidadDePasajeros
  var racionesCargadas
  var bebidasCargadas

  method cantidadDePasajeros(){
    return cantidadDePasajeros
  }
  method sumarPasajero(unPasajero){
    cantidadDePasajeros= cantidadDePasajeros + unPasajero
    return cantidadDePasajeros
  }

  method cantidadDeRacionesCargadas(){
      racionesCargadas
  }
  method cargarRacionesDeComida(cantidad){
    racionesCargadas = racionesCargadas + cantidad
    return racionesCargadas
  }
  method cantidadDeBebidasCargadas(){
    return bebidasCargadas
  }

  method cargarBebidas(cantidad){
    bebidasCargadas = bebidasCargadas + cantidad
    return bebidasCargadas
  }
  override method prepararViaje(){
    super()
    self.cargarRacionesDeComida(4)* cantidadDePasajeros
    self.cargarBebidas(6)* cantidadDePasajeros
    self.acercarseUnPocoAlSol()
  }
}

class NaveHospital inherits NavesDePasajeros{
  var tienePreparadosLosQuirofanos = true

  method tienePreparadosLosQuirofanos(){
    return tienePreparadosLosQuirofanos
  }
  method prepararLosQuirofanos(){
    tienePreparadosLosQuirofanos = true
  }
  override method estaTranquila(){
    return super() &&  not tienePreparadosLosQuirofanos          
  } 
}

class NavesDeCombate inherits Nave{
    var estaVisible = true
    var estaDesplegado = true
    const mensajesEmitidos = []

    method ponerseVisible(){
      return estaVisible

    }
    method ponerseInvisible(){
      estaVisible = false

    }
    method estaInvisible(){
      return not estaVisible

    }

    method desplegarMisiles(){
      estaDesplegado = true

    }
    method replegarMisiles(){
      estaDesplegado = false

    }
    method misilesDesplegados(){
      return estaDesplegado 
      
    }
    method emitirMensaje(mensaje){
      return mensaje.add("unMensaje")
    }
    method mensajesEmitidos(){
      return mensajesEmitidos
    }
    method primerMensajeEmitido(){
      return mensajesEmitidos.first()

    }
    method ultimoMensajeEmitido(){
      return mensajesEmitidos.last()

    }
    method esEscueta(){
      return  not mensajesEmitidos.all({m=>m.length() > 30})

    }
    method emitioMensaje(mensaje){
      return mensajesEmitidos.isEmpty()

    }
    override method prepararViaje(){
      super()
      self.acelerar(15000)
      self.ponerseVisible()
      self.replegarMisiles()
      self.emitirMensaje("Saliendo en misión")
    }

    override method estaTranquila(){
      
      return super() && not estaDesplegado
    }
}
class NaveDeCombateSigilosa inherits NavesDeCombate{

    override method estaTranquila(){
      return super() && estaVisible
    }
}