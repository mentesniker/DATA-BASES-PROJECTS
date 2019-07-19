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
			#DIRIGIR
			arr = m.ejecutar_query("SELECT rfc,curp,To_char(fecha_inicio, 'YYYY/MM/DD')  from empresa.dirigir")
			return Tupla.Tupla("dirigir",["rfc", "curp","fecha_inicio"],arr,gtk.ListStore(str,str,str),gtk.ListStore(str,str,str),["rfc","curp","fecha_inicio"])
		if 1 == i:
			#EMPLEADO
			arr = m.ejecutar_query("SELECT nombre,materno,paterno,To_char(f_nac, 'YYYY/MM/DD'),curp,num::text,calle,ciudad,cp::text  from empresa.empleado")
			return Tupla.Tupla("empleado",["nombre", "materno","paterno","f_nac","curp","num","calle","ciudad","cp"],arr,gtk.ListStore(str,str,str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str,str,str),["curp"])
		if 2 == i:
			#Empresa
			arr = m.ejecutar_query("SELECT rfc,razon_social,num::text,calle,ciudad,cp::text  from empresa.empresa")
			return Tupla.Tupla("empresa",["rfc", "razon_social","num","calle","ciudad","cp"],arr,gtk.ListStore(str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str),["razon_social"])
		if 3 == i:
			#proyecto
			arr = m.ejecutar_query("SELECT numproy::text,nombre,To_char(fecha_inicio, 'YYYY/MM/DD'),To_char(fecha_fin, 'YYYY/MM/DD'),rfc,curp,numhoras::text from empresa.proyecto")
			return Tupla.Tupla("proyecto",["numproy","nombre","To_char(fecha_inicio, 'YYYY/MM/DD')","To_char(fecha_fin, 'YYYY/MM/DD')","rfc","curp","numhoras"],arr,gtk.ListStore(str,str,str,str,str,str,str),gtk.ListStore(str,str,str,str,str,str,str),["num_proy"])
		if 4 == i:
			#Supervisar
			arr = m.ejecutar_query("SELECT curp_supervisor,curp_supervisado from empresa.supervisar")
			return Tupla.Tupla("supervisar",["curp_supervisor","curp_supervisado"],arr,gtk.ListStore(str,str),gtk.ListStore(str,str),["curp_supervisor","curp_supervisado"])
		if 5 == i:
			#Trabajar
			arr = m.ejecutar_query("SELECT salario::text,To_char(fecha_ingreso, 'YYYY/MM/DD'),rfc,curp from empresa.trabajar")
			return Tupla.Tupla("trabajar",["salario","fecha_ingreso","rfc","curp"],arr,gtk.ListStore(str,str,str,str),gtk.ListStore(str,str,str,str),["salario","fecha_ingreso","rfc","curp"])
