const costoDeVidaAnual=9999

class Lote{
	var property hectareas
	var property rendimientoAnual
	var property cultivo
	
	method ingresoAnual(){
		return hectareas*rendimientoAnual
	}
	
	method cultivoExcedido(){
		return cultivo.intensidad()*hectareas > 50
	}
	
	method ingresoSuficiente(){
		return self.ingresoAnual() >= costoDeVidaAnual
	}
	
	method sumarHectareas(porcentaje){
		return hectareas+hectareas*porcentaje
	}
	
	method mantenerIngreso(porcentaje){
		const ingresoAnterior=self.ingresoAnual()
		self.sumarHectareas(porcentaje)
		rendimientoAnual=ingresoAnterior/hectareas
	}
}

class Cultivo{
	var property iintensidad
	
}

class CultivoCombinado{
	
	var property listaCultivos
	
	method iintensidad(){
		return listaCultivos.map({unCultivo => unCultivo.iintensidad()}).sum()/listaCultivos.size()
	}
}

object graboland {
	var property lotes = []
	var property iniciativas=[duplicarProductividad,mantenerIngreso,mantenerIngreso]
	method agregarLote(lote) {
		lotes.add(lote)
	}
	method porcentajeLotesProduccionSuficiente() {
		return lotes.filter({unLote => unLote.ingresoSuficiente()}).size()/lotes.size()
	}
	
	method aumentoGeneralizado(porcentaje){
		lotes.filter({unLote => !unLote.ingresoSuficiente() && !unLote.cultivoExcedido()}).forEach({
			unLote => unLote.sumarHectareas(porcentaje)
		})
	}

	
}

object duplicarProductividad{
	
	method accion(lotes){
		lotes.forEach({
			// porcentaje de 0 a 1
			unLote => unLote.sumaHectareas(1)
		})
	}
}



object mantenerIngreso{
	var property porcentaje
	
	method accion(lotes){
		lotes.forEach({
			unLote => unLote.mantenerIngreso(porcentaje)
		})
	}
}

object cambiarCultivo{
	var property cultivo
	
	method accion(lotes){
		lotes.forEach({
			unLote => unLote.cultivo(cultivo)
		})
	}
}


class Iniciativa{
	var property personas
	
	method esExitosa()
	
	method aplicar(){
		if(self.esExitosa()){
			graboland.iniciativas().forEach({
				iniciativa => iniciativa.accion(graboland.lotes())
			})
		}
	}
}

class Tractorazo inherits Iniciativa{
	var policiasActivos
	
	override method esExitosa(){
		return (personas>=10000) && (policiasActivos<personas)
	}
	
	
}

class ProyectoLey inherits Iniciativa{
	var avaladaMayoritariamente
		
	override method esExitosa(){
		return (personas>=100) && avaladaMayoritariamente
	}
}

class IniciativaVirtual inherits Iniciativa{
	var likes
	var trolls
	
	override method esExitosa(){
		return (personas>=1000) && (trolls/likes <= 0.2)
	}
}

class IniciativaVegana inherits Iniciativa{
	var cohetes
	var animales
	var gretaVive
	
	override method esExitosa(){
		return animales>cohetes && animales>personas && gretaVive
	}
}
