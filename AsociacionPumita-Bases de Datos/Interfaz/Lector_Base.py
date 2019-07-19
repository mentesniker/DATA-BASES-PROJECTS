import Modelo
import Tupla
import gi
gi.require_version('Gtk','3.0')
from gi.repository import Gtk as gtk
#Clase que lee las tuplas de las tablas de la base 
class Lector_Base():
	#Constructor de la clase,se inicializan las variables del
	#modelo,un objeto de la clase modelo,necesrio para hacer querys    
	def __init__(self):
		global m
		m = Modelo.Modelo()

	#metodo que te da todas las tuplas de una tabla
	#segun el parametro recibidp
	#parametros: i,un indice que hace referencia al numero de la tabla
	#de la cual queremos las tuplas
	#regresa una lista con las tuplas de la tabla seleccionada
	def dame_tuplas(self,i):
		datosRegreso = list()
		if 0 == i:
			#ASEGURADORA
			arr = m.ejecutar_query("SELECT num_sucursal::text,Nombre,To_char(horario_apertura, 'HH:MI'),To_char(horario_cierre, 'HH:MI')  from aseguradora")
			return Tupla.Tupla("Aseguradora",["num_sucursal", "Nombre","apertura","cierre"],arr,gtk.ListStore(str,str,str,str),gtk.ListStore(str,str,str,str),["num_sucursal"])
		if 1 == i:
			#BORRAR
			arr = m.ejecutar_query("SELECT num_economico::text,id_log_vehiculo::text,razon,To_char(fecha_baja, 'YYYY/MM/DD')  from borrar")
			return Tupla.Tupla("Borrar",["num_economico", "id_log_vehiculo","razon","fecha_Baja"],arr,gtk.ListStore(str,str,str,str),gtk.ListStore(str,str,str,str),["num_economico","id_log_vehiculo"])
		if 2 == i:
			#LOG_VEHICULO
			arr = m.ejecutar_query("SELECT id_log_vehiculo::text,num_economico::text,razon,To_char(baja, 'YYYY/MM/DD')  from log_vehiculo")
			return Tupla.Tupla("Log_Vehiculo",["id_log_vehiculo", "num_economico","razon","fecha_Baja"],arr,gtk.ListStore(str,str,str,str),gtk.ListStore(str,str,str,str),["id_log_vehiculo"])
		if 3 == i:
			#seguro_vehiculo
			arr = m.ejecutar_query("SELECT num_serie::text,num_sucursal::text,cobertura  from seguro_vehiculo")
			return Tupla.Tupla("seguro_vehiculo",["num_serie", "num_sucursal","cobertura"],arr,gtk.ListStore(str,str,str),gtk.ListStore(str,str,str),["num_serie","num_sucursal"])
		if 4 == i:
			#Asociado
			arr = m.ejecutar_query("SELECT rfc,nombre_asociado,paterno_asociado,materno_asociado,ciudad_asociado,calle_asociado,numero_asociado::text,cp_asociado,To_char(fecha_ingreso, 'YYYY/MM/DD'),correo_electronico_asociado,fotografia_asociado,esduenio::text,eschofer::text,telefono_celular_asociado,num_licencia::text from asociado")
			return Tupla.Tupla("asociado",["rfc","nombre_asociado","paterno_asociado","materno_asociado","ciudad_asociado","calle_asociado","numero_asociado","cp_asociado","fecha_ingreso","correo_electronico","fotografia_asociado","esduenio","eschofer","telefono_celular","num_licencia"],arr,gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str,str,str,str,str),["rfc"])
		if 5 == i:
			#Agente
			arr = m.ejecutar_query("SELECT num_agente::text,nombre_agente,paterno_agente,materno_agente,ciudad_agente,calle_agente,numero_agente::text,cp_agente,telefono_celular_cliente::text,correo_electronico_cliente from agente")
			return Tupla.Tupla("agente",["num_agente","nombre_agente","paterno_agente","materno_agente","ciudad_agente","calle_agente","numero_agente","cp_agente","telefono_celular_cliente","correo_electronico_cliente"],arr,gtk.ListStore(str,str,str,str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str,str,str,str),["num_agente"])
		if 6 == i:
			#Cliente
			arr = m.ejecutar_query("SELECT curp,To_char(hora_entrada, 'HH:MI'),To_char(hora_salida, 'HH:MI') from cliente")
			return Tupla.Tupla("cliente",["curp", "hora_entrada","hora_salida"],arr,gtk.ListStore(str,str,str),gtk.ListStore(str,str,str),["curp"])
		if 7 == i:
			#Cobro
			arr = m.ejecutar_query("SELECT id_cobro::text,id_viaje::text,curp,descuento::text,monto::numeric::text,monto_final::numeric::text from cobro")
			return Tupla.Tupla("cobro",["id_cobro","id_viaje","curp","descuento","monto","monto_final"],arr,gtk.ListStore(str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str),["id_cobro","id_viaje"])
		if 8 == i:
			#Conducir
			arr = m.ejecutar_query("SELECT num_economico::text,rfc from conducir")
			return Tupla.Tupla("conducir",["num_economico","rfc"],arr,gtk.ListStore(str,str),gtk.ListStore(str,str),["num_economico","rfc"])
		if 9 == i:
			#ganancias
			arr = m.ejecutar_query("SELECT id_ganancia::text,id_viaje::text,curp,rfc,ganancia::numeric::text,esbono::text from ganancias")
			return Tupla.Tupla("ganancias",["id_ganancia","id_viaje","curp","rfc","ganancia","esbono"],arr,gtk.ListStore(str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str),["id_ganancia"])
		if 10 == i:
			##Informacion_cliente
			arr = m.ejecutar_query("SELECT curp,nombre_cliente,paterno_cliente,materno_cliente,ciudad_cliente,calle_cliente,numero_cliente::text,cp_cliente,tipo_cliente,fotografia_cliente,telefono_casa,telefono_celular_cliente,edificio,correo_electronico_cliente from informacion_cliente")
			return Tupla.Tupla("informacion_cliente",["curp","nombre_cliente","paterno_cliente","materno_cliente","ciudad_cliente","calle_cliente","numero_cliente","cp_cliente","tipo_cliente","fotografia_cliente","telefono_casa","telefono_celular_cliente","edificio","correo_electronico"],arr,gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str,str,str,str),["curp"])
		if 11 == i:
			#Multa
			arr = m.ejecutar_query("SELECT num_multa::text,num_economico::text,num_agente::text,rfc,articulo::text,To_char(hora, 'HH:MI'),monto::numeric::text,To_char(fecha_infraccion, 'YYYY/MM/DD'),calle_infraccion,ciudad_infraccion,cp_infraccion from multa")
			return Tupla.Tupla("multa",["num_multa","num_economico","num_agente","rfc","articulo","hora","monto","fecha_infraccion","calle_infraccion","ciudad_infraccion","cp_infraccion"],arr,gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str),["num_multa"])	
		if 12 == i:
			#ser
			arr = m.ejecutar_query("SELECT num_economico::text,num_serie::text from ser")
			return Tupla.Tupla("ser",["num_economico","num_serie"],arr,gtk.ListStore(str,str),gtk.ListStore(str,str),["num_economico","num_serie"])
	
		if 13 == i:
			#Vehiculo
			arr = m.ejecutar_query("SELECT num_serie::text,anio::text,capacidad::text,marca,modelo,num_cilindros::text,num_puertas::text,llanta_refaccion::text,tipo_transmision,tipo_combustible,pasajeros::text from vehiculo")
			return Tupla.Tupla("vehiculo",["num_serie","anio","capacidad","marca","modelo","num_cilindros","num_puertas","llanta_refaccion","tipo_transmision","tipo_combustible","pasajeros"],arr,gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str,str,str,str,str),["num_serie"])
		
		if 14 == i:
			#vehiculo_asociado
			arr = m.ejecutar_query("SELECT num_economico::text,rfc  from vehiculo_asociado")
			return Tupla.Tupla("vehiculo_asociado",["num_economico","rfc"],arr,gtk.ListStore(str,str),gtk.ListStore(str,str),["num_economico"])
		
		if 15 == i:
			#Viaje
			arr = m.ejecutar_query("SELECT id_viaje::text,curp,rfc,num_economico::text,To_char(tiempo, 'HH:MI'),distancia::text,lugar_origen,lugar_destino,To_char(fecha_viaje, 'YYYY/MM/DD') from viaje")
			return Tupla.Tupla("viaje",["id_viaje","curp","rfc","num_economico","tiempo","distancia","lugar_origen","lugar_destino","fecha_viaje"],arr,gtk.ListStore(str,str,str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str,str,str),["id_viaje","curp"])