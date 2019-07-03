//
//  TablaEquipos.swift
//  AppTeams
//
//  Created by Memo Figueredo on 6/27/19.
//  Copyright © 2019 DeTodoUnPoquito. All rights reserved.
//

import UIKit
import os.log

class TablaEquipos: UITableViewController {
    
    //MARK: propiedades
    var datosEquipo = [InformacionUsuario]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //permite colocar un boton de editar en nuetsra tabla equipos
        navigationItem.leftBarButtonItem = editButtonItem
        
        let guardarEquipos = cargarEquipoLista()
        
        if guardarEquipos?.count ?? 0 > 0 {
            datosEquipo = guardarEquipos ?? [InformacionUsuario] ()
        } else {
            cargarDatosUsuario()
        }

        
            }
    
    
    //Mark: Actions
    @IBAction func unWindToListaEquipo(sender: UIStoryboardSegue){
        
        if let dataViewController = sender.source as? ViewController, let equipo = dataViewController.Equipo {
            
            
            if let selecionIndexPath = tableView.indexPathForSelectedRow{
                
                //actualiza un euqipo existente
                datosEquipo[selecionIndexPath.row] = equipo
                tableView.reloadRows(at: [selecionIndexPath], with: .none)
            
            } else {
                
            //añadir nuevo Equipo
            let nuevoIndexPath = IndexPath(row: datosEquipo.count, section: 0)
            
            //esto agregra un nuevo equipo a el modelo de datos
            datosEquipo.append(equipo)
            
            //agrega los datos a la tabla de manera dinamica
            tableView.insertRows(at: [nuevoIndexPath], with: .automatic)
            
            }
            
            //guardar equipo
            GuardarEquipo()
        }
    }
    
    
    
    //MARK: Metodos Privados
    func cargarDatosUsuario(){
        
        //cargar imagenes
        let foto1 = UIImage(named: "barcelona")
        let foto2 = UIImage(named: "real")
        let foto3 = UIImage(named: "valencia")
        
        
        guard let equipo1 = InformacionUsuario(nombre: "Barcelona f.c", foto: foto1, rating: 4) else {
            
            fatalError("no se puede mostrar la imagen 1")
        }
        
        guard let equipo2 = InformacionUsuario(nombre: "Real Madrid", foto: foto2, rating: 5) else {
            
            fatalError("No se puede mostrar la imagen 2")
        }
        
        guard let equipo3 = InformacionUsuario(nombre: "Valecia F.c", foto: foto3, rating: 3)  else {
            
            fatalError("No se puede Mostrar la imagen 3")
        }
        
        datosEquipo += [equipo1, equipo2, equipo3]
        
    }
    
    //Guardar Equipo
    func obtenerDirectoriosArchivos()-> URL{
        let DirectorioArchivos = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return DirectorioArchivos[0]
    }
    
    private func GuardarEquipo(){
        let archivosUrl = obtenerDirectoriosArchivos().appendingPathComponent("datosEquipo")
        
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: datosEquipo, requiringSecureCoding: false)
              try data.write(to: archivosUrl)
            os_log("El equipo ha sido gurdado con exito", log: OSLog.default, type: .debug)
        } catch{
             os_log("El equipo no ha sido gurdado con exito", log: OSLog.default, type: .debug)
        }
    }
    
    //cargar lista de queipos guardados
    private func cargarEquipoLista() -> [InformacionUsuario]?{
        let archivosUrl = obtenerDirectoriosArchivos().appendingPathComponent("datosEquipo")
        if let nsData = NSData(contentsOf: archivosUrl){
            do {
                let data = Data(referencing: nsData)
                
                if let  cargarEquipos = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Array<InformacionUsuario> {
                    return cargarEquipos
                }
                
            } catch {
                print("no se pudo leer el archivo")
                return nil
            }
                    
                }
        
        return nil
    }
    
    
    // MARK: - Table view data source
    
    //muestra las secciones de la tabla

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    //configura las celdas para mostrar una fila
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datosEquipo.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //identificador de la celda
        
        let identificadorCelda = "CeldaEquipo"
        
        
        //se le inscruto un identificador
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identificadorCelda, for: indexPath) as? CeldaEquipo else {
            
            fatalError(" no se puede cargar los datos de las celda provenientes de la Celda Equipos")
        }
        
        
        //Carga la data en la tableView
        
      let equipo = datosEquipo[indexPath.row]
        
        cell.nombreEquipo.text = equipo.nombre
        cell.fotoImagenEquipo.image = equipo.foto
        cell.ratingControl.rating = equipo.rating
        
        
        

        // Configure the cell...

        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            datosEquipo.remove(at: indexPath.row)
            GuardarEquipo()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch (segue.identifier ?? "") {
        
            //Avisa en consola que se agrego un nuevo item
        case "addItem":
            os_log("Añadir Nuevo equipo", log: OSLog.default, type: .debug)
            
            //almacenar la vista crear equipo en la constante equipoDetailViewcontroller
        case "ShowDetail":
            guard let equipoDetailViewController = segue.destination as? ViewController else {
                fatalError("no se encontro el destino: \(segue.destination)")
            }
            
            //permite añadir o coincidir la celda con la imagen de la tabl
            guard let seleccionCeldaEquipo = sender as? CeldaEquipo else {
                fatalError("no se ejecuto la accion del sender: \(String(describing: sender))")
            }
            
            //almacena en el arreglo la foto, imagen, calificación para que coinicda con la celda y la imgen de la tabla
            guard let indexPath = tableView.indexPath(for: seleccionCeldaEquipo) else {
                fatalError("la tabla no muestra o no coincide con la informacion de la celda")
            }
            
            //pasa la data al arreglo datos equipo
            let seleccionEquipo = datosEquipo[indexPath.row]
            //muestra la data para que conicida con la imagen de la tabla y la primera vista de la app
            equipoDetailViewController.Equipo = seleccionEquipo
            
            
        default:
            fatalError("no se pudo identificar el segue; \(String(describing: segue.identifier))")
            
        }
        
    }
    

}
