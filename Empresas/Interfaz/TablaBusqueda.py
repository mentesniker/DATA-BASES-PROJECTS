import gi
gi.require_version('Gtk','3.0')
from gi.repository import Gtk as gtk
import Tupla

#Clase para crear una tabla que contenga los resultados de las busquedas
class TablaBusqueda(gtk.Window):
    #Constructor de la clase
    #Crea un treeview que contiene las tuplas devueltas por la busqueda
    #Parametros: tupla,un objeto de la clase tupla, que contiene
    # la ariable listaBusqueda, donde estan las tuplas del resultado de 
    #la busqueda,y con las cuales inicializamos el scrollable_treeview de la clase
    def __init__(self,tupla):
        gtk.Window.__init__(self, title="Resultados de la busqueda")
        self.set_border_width(10)
        self.set_position(gtk.WindowPosition.CENTER)
        self.set_default_size(400, 400)

        self.outter_box = gtk.VBox(False,spacing=10)
        self.add(self.outter_box) 
        tree = gtk.TreeView(tupla.get_listaBusqueda())
        for i, column_title in enumerate(tupla.get_columnas()):
            renderer = gtk.CellRendererText()
            column = gtk.TreeViewColumn(column_title, renderer, text=i)
            tree.append_column(column)
        self.scrollable_treelist = gtk.ScrolledWindow()
        self.scrollable_treelist.set_vexpand(True)
        self.scrollable_treelist.set_hexpand(True)
        self.outter_box.pack_start(self.scrollable_treelist, False, True, 0)
        self.scrollable_treelist.add(tree)