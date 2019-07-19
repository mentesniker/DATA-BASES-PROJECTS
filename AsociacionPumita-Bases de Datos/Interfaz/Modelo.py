import psycopg2
import Constantes
class Modelo():
	#Constructor de la clase,se conecta a la base de datos
    #e inicializa las variables conn(la conexion de la base)
    #cursor(el objeto para hacer querys sobre la base)
    #y las constantes de la base(nombre de la base,...)
    def __init__(self):
        self.c = Constantes.constantes()
        self.conn = psycopg2.connect(database=self.c.get_name(), user = self.c.get_user(), password = self.c.get_password(), host = "127.0.0.1", port = "5432")
        self.cursor = self.conn.cursor()
    #Funcion que te regresa el resultado de ejecutar un query como un arreglo de tuplas
    #recibe como parametros la query que se quiera ejecutar
    #regresa una lista con el resultado de la query ejecutada
    def ejecutar_query(self,Query):
    	self.cursor.execute(Query)
    	rows = self.cursor.fetchall()
    	lista = list()
    	for row in rows:
    		lista.append(row)
    	return lista     
    #Funcion que inserta la tupla, al la tabla pasada como parametro
    #se reciben como parametros el nombre de la tabla
    #los valores en forma de (%s,%s,...)
    #los valores a insertar en la tabla
    def agregar(self,tabla,valores,tupl):
    	self.cursor.execute("INSERT INTO " + tabla + " VALUES (" + valores +")" ,tupl)
    	self.conn.commit()
    #Funcion que ejecuta un rollback por si alguna operacion esta pendiente,o porque salio mal algo
    def hacer_rollBack(self):
    	self.conn.rollback()
    #Funcion que elimina una tupla de bd
    #apoyandose de los parametros recibidos para poder identificarla
    #se recibe un arreglo de arreglos con los valores y la llave a la
    #que hacen referencia
    def Eliminar_TuplaM(self,nombreTabla,keysV):
        aux1 = list()
        for e in keysV:
            aux1.append(" = ".join(e))
        aux = " AND ".join(aux1)
        cadena = "DELETE from " + nombreTabla + " where " + aux       
        self.cursor.execute(cadena)
        self.conn.commit()