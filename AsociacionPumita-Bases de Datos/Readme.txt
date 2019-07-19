CONEXIÓN A LA BASE

Abrir pgAdmin III. Una vez abierto y conectado el servidor, se crea una nueva base,
a la cual se le debe dar un nombre.

Se abre la carpeta llamada ArchivosProyecto y se copian todos, para pegarlos en la carpeta tmp que está en el equipo.

Creada la base, se presiona el botón SQL, que al mentener presionado arroja la leyenda
"Execute arbitrary SQL queries".

Se va a la carpeta donde este descargado el proyecto y se selecciona el archivo llamado "DDL.sql"
que está dentro de la carpeta sql. Cuando aparezca en pantalla este código, se presiona el botón 
de ejecutar querie.

Nuevamente se presiona el botón "Execute arbitrary SQL queries" y se abre el archivo llamado "Poblacion.sql"
que está dentro de la carpeta sql. Cuando aparezca en pantalla se presiona el botón de ejecutar querie. 

Hecho esto, se presiona el botón "Execute arbitrary SQL queries" nuevamamente, para ejecutar el querie llamado
"Triggers.sql"

De esta manera, ya abremos cargado las tablas de la base, la población y los triggers de la misma.



PARA CONECTAR LA INTERFAZ CON LA BASE

Interfaz hecha en python 2. Abrimos la terminal y debemos ingresar los siguientes comandos.

sudo su

Posterior a esto, se debe ingresar nuestra contraseña del equipo. Y se ingresan los siguientes comandos:

* curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
* python get-pip.py
* pip install psycopg2
* pip install psycopg2-binary
* sudo apt-get install python-gi
* sudo apt-get install --reinstall python-gi (Algunas veces es necesario reinstalar para que funcione)

Para ejecutar la interfaz:
Cambiar el archivo constantes.py con los datos de la base: el nombre y la contraseña.

Abrimos la terminal nuevamente y vamos a la carpeta llamada Interfaz dentro del proyecto.

Una vez en la carpeta desde la terminar, debemos ejecutar la instrucción:

python controlador.py

para que se pueda mostrar la interfaz gráfica de la base. Desde esta ya se puede eliminar, buscar e insertar información
a cada una de las tablas mostradas.
