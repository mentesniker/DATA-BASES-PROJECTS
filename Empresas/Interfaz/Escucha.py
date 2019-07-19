import Modelo
#Clase que "escucha" los cambios ocurridos en la interfaz y
#los reporta a la base de datos
class Escucha():
	#Constructor de la clase,se inicializan las variables del
	#nombre de la tabla, el numero de columnas de la tabla que esta escuchando
	#y el modelo de la base para que pueda reportarle cambios 
	def __init__(self,tabla,column):
		self.m = Modelo.Modelo()
		self.columnas = column
		self.Tabla = tabla
	#funcion que agrega una tupla a
	#la tabla pasada en el constructor
	#se recibe como parametros la tupla que queremos anadir
	#regresa true en caso de que la operacion
	#fue exitosa
	def agregar_tupla(self,e):
		valores = list()
		i = 1
		while i <= self.columnas:
  			valores.append("%s")
  			i += 1
		self.m.agregar(self.Tabla,','.join(valores),e)
		return True
	#funcion que manda a llamar el metodo rollback de la
	#clase modelo
	def Regresa(self):
		self.m.hacer_rollBack()
	#funcion que manda a llamar el metodo de eliminar_tuplaM
	#de la clase modelo
	#recibe como parametro una lista de valores y la llave a 
	#la cual hacen referencia
	#regresa true en caso de que la operacion fue exitosa 
	def borrar_Mtupla(self,keysVal):
		self.m.Eliminar_TuplaM(self.Tabla,keysVal)
		return True