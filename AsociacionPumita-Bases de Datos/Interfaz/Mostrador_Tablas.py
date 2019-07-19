import gi
gi.require_version('Gtk','3.0')
from gi.repository import Gtk as gtk
import Modelo
import Tabla
import Tupla
import Lector_Base

#Clase que muestra un ventana con las tablas disponibles
#utiliza un treeview para mostrar las tablas y un radio button 
#para seleccionar una tabla y mostrar su tuplas
class MostradorTablas(gtk.Window):
    #constructor de la clase,recibe como parametros un arreglo 
    #donde se gurada la tupla correspondiente a cada tabla
    #para poder construir los treeviews
    #Se inicializa un treeview para mostrar las tablas
    #y el radio button de las mismas
    def __init__(self):
        global Lector
        global VentanaActiva
        Lector = Lector_Base.Lector_Base() 
        self.VentanaActiva = False
        gtk.Window.__init__(self, title="Asociacion El pumita")
        self.set_default_size(400, 200)
        self.liststore = gtk.ListStore(str, bool)
        self.liststore.append(["Aseguradora", False])
        self.liststore.append(["Borrar", False])
        self.liststore.append(["Log Vehiculo", False])
        self.liststore.append(["Seguro Vehiculo", False])
        self.liststore.append(["Asociado", False])
        self.liststore.append(["Agente", False])
        self.liststore.append(["Cliente", False])
        self.liststore.append(["Cobro", False])
        self.liststore.append(["Conducir", False])
        self.liststore.append(["ganancias", False])
        self.liststore.append(["Informacion del Cliente", False])
        self.liststore.append(["Multa", False])
        self.liststore.append(["ser", False])
        self.liststore.append(["vehiculo", False])
        self.liststore.append(["vehiculo del asociado", False])
        self.liststore.append(["viaje", False])

        treeview = gtk.TreeView(model=self.liststore)

        renderer_text = gtk.CellRendererText()
        column_text = gtk.TreeViewColumn("Tablas", renderer_text, text=0)
        treeview.append_column(column_text)

        renderer_radio = gtk.CellRendererToggle()
        renderer_radio.set_radio(True)
        renderer_radio.connect("toggled", self.on_cell_radio_toggled)

        column_radio = gtk.TreeViewColumn("Seleccionar", renderer_radio, active=1)
        treeview.append_column(column_radio)

        self.add(treeview)

    #funcion que se manda a llamar cuando un radio button es presionado
    #Se crea con esta funcion un WB_WINDOW para mostrar la tabla con sus tuplas 
    def on_cell_radio_toggled(self, widget, path):
        selected_path = gtk.TreePath(path)
        aux = 0
        cont = 0
        for row in self.liststore:
            if (row.path == selected_path):
                cont = aux
            row[1] = (row.path == selected_path)
            aux += 1
        self.Crear_ventana(cont)

    #Metodo que crea una ventana de tipo Tabla, con todos sus datos asociados
    #Recibe el parametro conti,que es el indice del arreglo de Datos
    #donde se guardan las variables tuplas
    def Crear_ventana(self,conti):
        if self.VentanaActiva:
            dialog = gtk.MessageDialog(self, 0, gtk.MessageType.ERROR,
            gtk.ButtonsType.CANCEL, "Error")
            dialog.format_secondary_text("El sistema solo soporta una ventana abierta a la vez :(")
            dialog.run()
            dialog.destroy()
        else:
            self.VentanaActiva = True
            win = Tabla.WB_Window(Lector.dame_tuplas(conti))
            win.CrearArbol()
            win.crearBotones(conti)
            win.connect("destroy",self.desactivarVentana)
            win.show_all()
            gtk.main()
    #Metodo para destruir una ventana y reiniciar la bandera de Ventana Activa
    #Recibe como parametros a self,el obejeto que llamo el metodo
    #w el widget del que queremos destruir la ventana
    def desactivarVentana(self,w):
        w.Cerrar_SubVentanas()
        self.VentanaActiva = False
        gtk.main_quit()