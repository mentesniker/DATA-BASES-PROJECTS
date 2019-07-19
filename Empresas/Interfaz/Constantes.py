#Clase simple que define constantes para poder conectarse a la base
class constantes():
	def __init__(self):
		self.NameDB = "TareaExam"
		self.user = "postgres"
		self.password = "123"
	#metodo que regresa el nombre de la base
	def get_name(self):
		return self.NameDB
	#metodo que regresa el usuario
	def get_user(self):
		return self.user
	#metodo que regresa el password
	def get_password(self):
		return self.password
