class Nave {
  var property velocidad //kms /seg
  var direccion
  var combustible //en litros
  
  method acelerar(cuanto) {
    velocidad += cuanto
    return velocidad.min(100000)
  }
  
  method desacelerar(cuanto) {
    velocidad -= cuanto
    return velocidad.max(0)
  }
  
  method irHaciaElSol() = 10
  
  method escaparDelSol() = -10
  
  method ponerseParaleloAlSol() = 0
  
  method acercarseUnPocoAlSol() = (direccion + 1).min(10)
  
  method alejarseUnPocoDelSol() = (direccion - 1).max(-10)
  
  method combustible() = combustible
  
  method cargarCombustible(litros) {
    combustible += litros
    return combustible
  }
  
  method descargarCombustible(litros) {
    combustible -= litros
    return combustible
  }
  
  method prepararViaje() {
    self.cargarCombustible(30000)
    self.acelerar(5000)
  } // cada nave sabe como debe hacerlo
  
  method estaTranquila() = (combustible >= 4000) && (self.velocidad() < 12000)

  method estaDeRelajo(){
    self.estaTranquila()
  }
} //Distintos tipos de nave

class NavesBaliza inherits Nave {
  var baliza
  const coloresDeBalizaCambiados = []
  
  method mostrarBaliza() = baliza
  
  method cambiarColorDeBaliza(colorNuevo) {
    baliza = colorNuevo
  }
  
  override method prepararViaje() {
    super()
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }
  
  override method estaTranquila() = super() && (baliza != "rojo")
  
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  
  method escapar() {
    self.irHaciaElSol()
  }
  
  method avisar() {
    self.cambiarColorDeBaliza("rojo")
  }

  override method estaDeRelajo(){
    super()
    coloresDeBalizaCambiados.size() == 1

  }
}

class NavesDePasajeros inherits Nave {
  var cantidadDePasajeros
  var racionesCargadas
  var bebidasCargadas
  const racionesServidas = []
  const bebidasServidas = []
  
  method cantidadDePasajeros() = cantidadDePasajeros
  
  method sumarPasajero(unPasajero) {
    cantidadDePasajeros += unPasajero
    return cantidadDePasajeros
  }
  
  method cantidadDeRacionesCargadas() = racionesCargadas
  
  method cargarRacionesDeComida(cantidad) {
    racionesCargadas += cantidad
    return racionesCargadas
  }
  
  method cantidadDeBebidasCargadas() = bebidasCargadas
  
  method cargarBebidas(cantidad) {
    bebidasCargadas += cantidad
    return bebidasCargadas
  }
  
  override method prepararViaje() {
    super()
    self.cargarRacionesDeComida(4) * cantidadDePasajeros
    racionesCargadas = racionesCargadas - 4
    racionesServidas.add(4)
    self.cargarBebidas(6) * cantidadDePasajeros
    bebidasCargadas = bebidasCargadas - 6
    bebidasServidas.add(6)
    self.acercarseUnPocoAlSol()
  }
  
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  
  method escapar() {
    velocidad *= 2
  }
  
  method avisar() {
    racionesCargadas =
    (self.cantidadDeRacionesCargadas() - cantidadDePasajeros).max(0)
    bebidasCargadas =
     (self.cantidadDeBebidasCargadas() - (cantidadDePasajeros * 2)).max(0)
  }

  override method estaDeRelajo(){
    super()
    racionesServidas.size() < 50

  }

  }


class NaveHospital inherits NavesDePasajeros {
  var tienePreparadosLosQuirofanos = true
  
  method tienePreparadosLosQuirofanos() = tienePreparadosLosQuirofanos
  
  method prepararLosQuirofanos() {
    tienePreparadosLosQuirofanos = true
  }
  
  override method estaTranquila() = super() && (not tienePreparadosLosQuirofanos)

  override method recibirAmenaza(){
      super()
      self.prepararLosQuirofanos()
  }
}

class NavesDeCombate inherits Nave {
  var estaVisible = true
  var estaDesplegado = true
  const mensajesEmitidos = []
  
  method ponerseVisible() = estaVisible
  
  method ponerseInvisible() {
    estaVisible = false
  }
  
  method estaInvisible() = not estaVisible
  
  method desplegarMisiles() {
    estaDesplegado = true
  }
  
  method replegarMisiles() {
    estaDesplegado = false
  }
  
  method misilesDesplegados() = estaDesplegado
  
  method emitirMensaje(mensaje) = mensaje.add("unMensaje")
  
  method mensajesEmitidos() = mensajesEmitidos
  
  method primerMensajeEmitido() = mensajesEmitidos.first()
  
  method ultimoMensajeEmitido() = mensajesEmitidos.last()
  
  method esEscueta() = not mensajesEmitidos.all({ m => m.length() > 30 })
  
  method emitioMensaje(mensaje) = mensajesEmitidos.isEmpty()
  
  override method prepararViaje() {
    super()
    self.acelerar(15000)
    self.ponerseVisible()
    self.replegarMisiles()
    self.emitirMensaje("Saliendo en misión")
  }
  
  override method estaTranquila() = super() && (not estaDesplegado)
  
  method recibirAmenaza() {
    self.escapar()
    self.avisar()
  }
  
  method escapar() {
    2.times(self.acercarseUnPocoAlSol()) //repite dos veces la accion de acercarse al sol
  }
  
  method avisar() {
    return self.emitirMensaje( "Amenaza recibida")
  }
}

class NaveDeCombateSigilosa inherits NavesDeCombate {
  override method estaTranquila() = super() && estaVisible

  override method recibirAmenaza(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}