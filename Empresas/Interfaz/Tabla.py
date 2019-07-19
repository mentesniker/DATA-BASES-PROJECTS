import TablaBusqueda
import gi
gi.require_version('Gtk','3.0')
from gi.repository import Gtk as gtk
import Tupla
import Escucha
#Metodo para dibujar la tabla sobre la que 
#se mostraran las tuplas
#hereda de la clase gtk.Window
class WB_Window(gtk.Window):
    #constructor de la clase
    #se inicializan las variables de
    #chismoso, es un objeto de la clase escucha, lo usamos
    #para poder reportar los cambios a la bd
    #tupla,la tupla que va a contener toda la informacion
    #de esta tabla
    #parametros: un objeto de la clase tupla
    #que guarda toda la informacion de la tabla
    def __init__(self,tupl):
        global chismoso
        global tupla
        self.Vi = None
        self.Vb = None
        self.Vbo = None
        tupla = tupl
        chismoso = Escucha.Escucha(tupla.get_nombre(),len(tupla.get_columnas()))
        gtk.Window.__init__(self, title=tupla.get_nombre())
        self.set_border_width(10)
        self.set_position(gtk.WindowPosition.CENTER)
        if len(tupla.get_columnas())*125 > 800:
            self.set_default_size(800, 400)
        else:
            self.set_default_size(len(tupla.get_columnas())*125, 400)

    #Metodo para crear un scrollable_treeview
    #Que es la tabla donde se mostraran las tuplas
    #se utiliza informacion del objeto de la clase
    #tupla para poder construirse
    def CrearArbol(self):
        self.outter_box = gtk.VBox(False,spacing=10)
        self.add(self.outter_box) 
        tree = gtk.TreeView(tupla.get_listStore())
        for i, column_title in enumerate(tupla.get_columnas()):
            renderer = gtk.CellRendererText()
            column = gtk.TreeViewColumn(column_title, renderer, text=i)
            tree.append_column(column)
        self.scrollable_treelist = gtk.ScrolledWindow()
        self.scrollable_treelist.set_vexpand(True)
        self.scrollable_treelist.set_hexpand(True)
        self.outter_box.pack_start(self.scrollable_treelist, False, True, 0)
        self.scrollable_treelist.add(tree)

    #Metodo para crear los botones de la ventana
    #parametros: contador, un entero que nos indica
    #si la tabla es de solo lectura o escritura-lectura
    def crearBotones(self,contador):
        hbox = gtk.ButtonBox.new(gtk.Orientation.HORIZONTAL)
        hbox.set_layout(gtk.ButtonBoxStyle.CENTER) 
        self.outter_box.pack_start(hbox, False, True, 0)

        button_bus = gtk.Button(label="Buscar")
        button_bus.connect("clicked", self.Ventana_Buscar)
        hbox.add(button_bus)
        if contador != 7 and contador != 9 and contador != 2:
            button_Ins = gtk.Button(label="Insertar")
            button_Ins.connect("clicked", self.Ventana_Insertar)
            hbox.add(button_Ins)
            button_Borr = gtk.Button(label="Borrar")
            button_Borr.connect("clicked", self.Ventana_Borrar)
            hbox.add(button_Borr)

    #Metodo para crear una ventana con los campos de busqueda
    #recibe como parametros button,que es un objeto de la clase
    #widget,en especifico el botton que mando a crear esta ventana
    def Ventana_Buscar(self,button):
        global entry
        global campo_entry
        self.Vb = gtk.Window(title="Buscar En La Base")
        self.Vb.set_border_width(10)
        self.Vb.set_default_size(400, 200)
        vbox = gtk.Box(orientation=gtk.Orientation.VERTICAL, spacing=6)
        self.Vb.add(vbox)
        campo_entry = gtk.Entry()
        campo_entry.set_text("Ingresar la columna")
        vbox.pack_start(campo_entry, True, True, 0)
        entry = gtk.Entry()
        entry.set_text("Valor a buscar")
        vbox.pack_start(entry, True, True, 0)


        hbox = gtk.ButtonBox.new(gtk.Orientation.HORIZONTAL)
        hbox.set_layout(gtk.ButtonBoxStyle.CENTER) 
        button_bus = gtk.Button(label="Buscar")
        button_bus.connect("clicked", self.BuscarCambios)
        hbox.add(button_bus)
        vbox.pack_start(hbox, True, True, 0)
        self.Vb.show_all()

    #Metodo para cerrar las ventanas de busqueda,insertar e eliminar
    #al cerrar la ventana principal
    def Cerrar_SubVentanas(self):
        if self.Vb is not None:
            self.Vb.destroy()
        if self.Vi is not None:
            self.Vi.destroy()
        if self.Vbo is not None:
            self.Vbo.destroy()

    #Metodo para crear una ventana con los campos de borrado
    #recibe como parametros button,que es un objeto de la clase
    #widget,en especifico el botton que mando a crear esta ventana
    def Ventana_Borrar(self,button):
        global listaObjetos2
        self.Vbo = gtk.Window(title="Borrar Registro")
        self.Vbo.set_border_width(10)
        self.Vbo.set_default_size(400, 200)
        vbox = gtk.Box(orientation=gtk.Orientation.VERTICAL, spacing=6)
        self.Vbo.add(vbox)
        i = 0
        listaObjetos2 = list()
        for e in tupla.get_llaves():
            listaObjetos2.append(gtk.Entry())
        for e in tupla.get_llaves():
            listaObjetos2[i].set_text(e)
            i += 1
        for e in listaObjetos2:
            vbox.pack_start(e, True, True, 0)


        hbox = gtk.ButtonBox.new(gtk.Orientation.HORIZONTAL)
        hbox.set_layout(gtk.ButtonBoxStyle.CENTER) 
        button_bus = gtk.Button(label="Borrar")
        button_bus.connect("clicked", self.BorrarCambios)
        hbox.add(button_bus)
        vbox.pack_start(hbox, True, True, 0)
        self.Vbo.show_all()

    #Metodo para crear una ventana con los campos de insertar
    #recibe como parametros button,que es un objeto de la clase
    #widget,en especifico el botton que mando a crear esta ventana
    def Ventana_Insertar(self,button):
        global listaObjetos
        self.Vi = gtk.Window(title="Insertar Registro")
        self.Vi.set_border_width(10)
        self.Vi.set_default_size(400, 200)
        vbox = gtk.Box(orientation=gtk.Orientation.VERTICAL, spacing=6)
        self.Vi.add(vbox)
        i = 0
        listaObjetos = list()
        for e in tupla.get_columnas():
            listaObjetos.append(gtk.Entry())
        for e in tupla.get_columnas():
            listaObjetos[i].set_text(e)
            i += 1
        for e in listaObjetos:
            vbox.pack_start(e, True, True, 0)
        hbox = gtk.ButtonBox.new(gtk.Orientation.HORIZONTAL)
        hbox.set_layout(gtk.ButtonBoxStyle.CENTER) 
        button_bus = gtk.Button(label="Insertar")
        button_bus.connect("clicked", self.SubirCambios)
        hbox.add(button_bus)
        vbox.pack_start(hbox, True, True, 0)
        self.Vi.show_all()

    #Metodo para comunicarse con el escucha
    #y asi poder mandar los cambio registrados a la bd
    #en especifico para insertar una tupla
    #recibe como parametros button,que es un objeto de la clase
    #widget,en especifico el botton que mando a crear esta ventana
    #Atrapa la exception error,que es cualquier error
    #que la base pueda mandar
    def SubirCambios(self,button):
        aux = list()
        for e in listaObjetos:
            aux.append(e.get_text())
        while True:
            try:
                if chismoso.agregar_tupla(aux):
                    break
            except Exception as error:
                            chismoso.Regresa()
                            dialog = gtk.MessageDialog(self, 0, gtk.MessageType.ERROR,
                            gtk.ButtonsType.CANCEL, "Error")
                            dialog.format_secondary_text(repr(error))
                            dialog.run()
                            dialog.destroy()
                            return    
        tupla.insertar_en_listStore(aux)
        dialog = gtk.MessageDialog(self, 0, gtk.MessageType.INFO,
            gtk.ButtonsType.OK, "Finalizado")
        dialog.format_secondary_text(
            "Se ha agregado satisfactoriamente la tupla")
        dialog.run()
        dialog.destroy()

    #Metodo para comunicarse con el escucha
    #y asi poder mandar los cambio registrados a la bd
    #en especifico para insertar borrar una tupla
    #recibe como parametros button,que es un objeto de la clase
    #widget,en especifico el botton que mando a crear esta ventana
    #Atrapa la exception error,que es cualquier error
    #que la base pueda mandar
    def BorrarCambios(self,button):
        if len(listaObjetos2) > 0:
            indice = 0
            posiblesEliminar = list()
            hayUna = False
            i = 0
            for e in tupla.get_elementos():
                for i in e:
                    if i == listaObjetos2[0].get_text():
                        posiblesEliminar.append(e)
            for e in listaObjetos2:
                for j in posiblesEliminar:
                    hayUna = False
                    for i in j:
                        if i == e.get_text():
                            hayUna = True
                    if not hayUna:
                        posiblesEliminar.remove(j)
            if len(posiblesEliminar) == 0:
                dialog = gtk.MessageDialog(self, 0, gtk.MessageType.ERROR,
                gtk.ButtonsType.CANCEL, "Error")
                dialog.format_secondary_text("No se ha encontrado la tupla")
                dialog.run()
                dialog.destroy()
                return  
            while True:
                try:
                    if chismoso.borrar_Mtupla(tupla.get_valor_llave(posiblesEliminar[0])):
                        break
                except Exception as error:
                    chismoso.Regresa()
                    dialog = gtk.MessageDialog(self, 0, gtk.MessageType.ERROR,
                    gtk.ButtonsType.CANCEL, "Error")
                    dialog.format_secondary_text(repr(error))
                    dialog.run()
                    dialog.destroy()
                    return
            tupla.borrar_elemento(posiblesEliminar[0])
            tupla.vaciar_listStore()
            for r in tupla.get_elementos():
                tupla.insertar_en_listStore(list(r))
            dialog = gtk.MessageDialog(self, 0, gtk.MessageType.INFO,
            gtk.ButtonsType.OK, "Finalizado")
            dialog.format_secondary_text(
            "Se ha borrado satisfactoriamente la tupla")
            dialog.run()
            dialog.destroy()
            return

    #Metodo para mostrar los resultados de una busqueda
    #recibe como parametros button,que es un objeto de la clase
    #widget,en especifico el boton que mando a crear esta ventana
    def BuscarCambios(self,button):
        columna_buscada = tupla.get_indiceColumna(campo_entry.get_text())
        indice = 0
        tupla.vaciar_listaBusqueda()
        for e in tupla.get_elementos():
            if e[columna_buscada] == entry.get_text():
                tupla.insertar_en_listaBusqueda(tupla.get_indiceElementos(indice))
            indice += 1
        if tupla.longitud_listaBusqueda() > 0:
            win = TablaBusqueda.TablaBusqueda(tupla)
            win.connect("delete-event",gtk.main_quit)
            win.show_all()
            gtk.main()
        else:
            dialog = gtk.MessageDialog(self, 0, gtk.MessageType.ERROR,
                gtk.ButtonsType.CANCEL, "Error")
            dialog.format_secondary_text(
                "No se ha encontrado el valor")
            dialog.run()
            dialog.destroy()
