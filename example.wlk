class Nave {
  var velocidad //kms /seg
  var direccion
  

  
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
}

//Distintos tipos de nave

class NavesBaliza inherits Nave{
    var baliza

    method MostrarBaliza(){
      return baliza
    }

    method cambiarColorDeBaliza(colorNuevo){
      baliza = colorNuevo
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
}

class NavesDeCombate inherits Nave{
    var estaVisible = true
    var estaDesplegado = false

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

    }
    method mensajesEmitidos(){

    }
    method primerMensajeEmitido(){

    }
    method ultimoMensajeEmitido(){

    }
    method esEscueta(){

    }
    method emitioMensaje(mensaje){
      
    }

}