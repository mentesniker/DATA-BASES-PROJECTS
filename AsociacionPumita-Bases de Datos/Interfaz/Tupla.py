import gi
gi.require_version('Gtk','3.0')
from gi.repository import Gtk as gtk
#Clase Tupla
#la clase Tupla sirve para guardar mucha informacion acerca de una tabla
class Tupla():
	#Constructor de la clase
	#Se inicializan las variables de llaves(una lista con los nombres de las columnas que son llaves)
	#columnas,los nombres de las columnas de la tabla
	#Tabla, el nombre de la Tabla
	#elementos, las tuplas de la tabla
	#listSt, listStore la listStore con las tuplas de la tabla
	#datosReg, un listStore vacia para poder mostrar los resultados de las querys
	#indiceLLave, una lista con los indices de las llaves de la lista de columnas
	def __init__(self,tabla,column,elementosTabla,listS,listaBusqued,key):
		self.llave = key
		self.columnas = column
		self.Tabla = tabla
		self.elementos = elementosTabla 
		self.listSt = listS
		self.listaBusqueda = listaBusqued
		self.datosReg = list()
		self.indiceLlave = list()
		ind = 0
		for e in self.columnas:
			for i in self.llave:
				if i == e:
					self.indiceLlave.append(ind)
			ind += 1
		for e in elementosTabla:
			self.listSt.append(list(e))
	#Metodo para regresar elementos
	#regresa elementos
	def get_elementos(self):
		return self.elementos
	#Metodo para regresar el elemento al cual apuntan los indices
	#i,d
	#se reciben los parametros,i,d que son los indices a los
	#cuales se quiere acceder de la lista de elementos
	#regresa un elemento de la lista de elementos
	def get_indiceElemento(self,i,d):
		return self.elementos[i][d]
	#Metodo para regresar la tupla a la que apunta el indice
	#parametros: el indice de la tupla buscada
	#regresa el elemento al cual apunta el indice
	def get_indiceElementos(self,indice):
		return self.elementos[indice]
	#Metodo para regresar columnas
	#regresa columnas
	def get_columnas(self):
		return self.columnas
	#Metodo para regresar el nombre de la tabla
	#regresa el nombre de la tabla
	def get_nombre(self):
		return self.Tabla
	#Metodo para regresar elementos
	#regresa elementos
	def get_tuplas(self):
		return self.elementos
	#Metodo para regresar listSt
	#regresa lisSt
	def get_listStore(self):
		return self.listSt
	#Metodo para regresar listaBusqueda
	#regresa listaBusqueda
	def get_listaBusqueda(self):
		return self.listaBusqueda
	#Metodo para regresar la primera entrada
	#de la lista de llaves
	#regresa la primera entrada
	#de la lista de llaves
	def get_llave(self):
		return self.llave[0]
	#Metodo para regresar las llaves
	#regresa llave
	def get_llaves(self):
		return self.llave
	#Metodo para regresar el primer indice de la lista
	#de llaves
	#regresa el primer indice de la lista de llaves
	def get_indiceLave(self):
		return self.indiceLlave[0]
	#Metodo para regresar indiceLlave
	#regresa indiceLlave
	def get_inidicesLlaves(self):
		return self.indiceLlave
	#Metodo para regresar una lista de listas
	#valores con el nombre de la llave a la que hace referencia
	#parametros: listaV,una tupla de la cual queremos saber cuales
	#son sus llaves
	#regresa una lista de listas de los valores de las llaves
	#junto con el nombre de la llave
	def get_valor_llave(self,listaV):
		aux2 = list()
		aux = list()
		for e in listaV:
			if e.isdigit():
				aux2.append(e)
			else:
				aux2.append("'"+e+"'")
		for i in self.indiceLlave:
			aux.append([self.llave[i],aux2[i]])
		return aux
	#Metodo para regresar el indice de la columna segun el nombre 
	#pasado como parametro
	#parametros: nombre de la columna que queremos saber su indice
	#regresa el indice de la columna
	def get_indiceColumna(self,col):
		ind = 0
		for e in self.columnas:
			if col == e:
				return ind
			ind += 1
		return -1
	#Metodo para eliminar un elemento de la
	#lista de elementos
	def borrar_elemento(self,e):
		self.elementos.remove(e)
	#Metodo para eliminar un elemento de la
	#lista de elementos en un indice determinado
	#parametros: indice,el indice del elemento que queremos borrar
	def borrar_elementosIndice(self,indice):
		self.elementos.pop(indice)
	#Metodo para insertar un elemento en la listStore
	#de la clase
	#parametros: e el elemento que queremos insertar
	def insertar_en_listStore(self,e):
		self.listSt.append(e)
	#Metodo para vaciar la listStore
	#de la clase
	def vaciar_listStore(self):
		self.listSt.clear()
	#Metodo para vaciar la listaBusqueda de la clase
	#de la clase
	def vaciar_listaBusqueda(self):
		self.listaBusqueda.clear()
	#Metodo para insertar un elemento en la listaBusqueda
	#de la clase
	#parametros: e el elemento que queremos insertar
	def insertar_en_listaBusqueda(self,e):
		self.listaBusqueda.append(e)
	#Metodo que nos regresa la longitud de la lista
	#busqueda de la clase
	#regresa la longitud de la lista busqueda de la clase
	def longitud_listaBusqueda(self):
		return len(self.listaBusqueda)