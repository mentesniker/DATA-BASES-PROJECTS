from datetime import datetime
import gi
gi.require_version('Gtk','3.0')
from gi.repository import Gtk as gtk
import Modelo
import Tabla
import Mostrador_Tablas
import Tupla

#Metodo Main de la interfaz
#Aqui se crean e inicializan los diferentes objetos necesarios para ejecutar la interfaz
datosRegreso = list()
m = Modelo.Modelo()
win = Mostrador_Tablas.MostradorTablas()
win.connect("destroy", gtk.main_quit)
win.show_all()
gtk.main()
