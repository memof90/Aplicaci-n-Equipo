//
//  ViewController.swift
//  AppTeams
//
//  Created by Memo Figueredo on 6/5/19.
//  Copyright © 2019 DeTodoUnPoquito. All rights reserved.
//
import os.log
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    //MARK: CONECTORES
    
    @IBOutlet weak var nombreEquipo: UILabel!
    
    @IBOutlet weak var nombreTextField: UITextField!
    
    @IBOutlet weak var fotoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    
    @IBOutlet weak var guardarBoton: UIBarButtonItem!
    
    //pasa la data si el usuario le dio guardar
    var Equipo: InformacionUsuario?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //maneja la entrada del usurio del campo de texto atravez del uitextFieldDelegate
        nombreTextField.delegate = self
        
        //permite actulizar la vista if esta es editada de Equipo
        if let equipo = Equipo {
            
            navigationItem.title = equipo.nombre
            nombreTextField.text = equipo.nombre
            fotoImageView.image = equipo.foto
            ratingControl.rating = equipo.rating
        }
        
        
        
        
        
        actualizarEstadoBoton()
    }
    
    //MARK: Uitextfileddelegate protocolos
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //devuelve la primera repuesta del usuario atraves de enter
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        //genera una información en el campo de texto para generar un comportamiento e este
        /*
        //esto permite que el usuario puede ingresar el etxto que desee
        nombreEquipo.text = textField.text
 */
        actualizarEstadoBoton()
        //le genera titulo a la navegación ingresada por el usaurio
        navigationItem.title = textField.text
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        //desabilitar el boton en caso de que el usario no ingrese información
        guardarBoton.isEnabled = false
    }
    
   
    //MARK: metodos Privado
    
    private func actualizarEstadoBoton(){
        
        //habilat el botn guardar en caso de que le usario ingrese el nombre del equipo
        let texto = nombreTextField.text ?? ""
        guardarBoton.isEnabled = !texto.isEmpty
    }
    

    //MARK: ACCIONES
    
    @IBAction func infoDark(_ sender: UIButton) {
       nombreEquipo.text = "indique el nombre del equipo"
        
    }
    
    @IBAction func selectorImagen(_ sender: UITapGestureRecognizer) {
        
        //oculta el teclado
        nombreTextField.resignFirstResponder()
        
        // permite que el usuario pueda seleccionar la foto de la libreria de imagnes del dispositivo
        let imagePickerController = UIImagePickerController()
        
        //sellecciona la imagen de la biblioteca no tomas
        imagePickerController.sourceType = .photoLibrary
        
        //recibe la notificación cuando el usario elegi la imagen
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
       
    }
    
    
    //MARK: Navegación
    
    //accion boton cancelar
    
    
    @IBAction func cancelarBoton(_ sender: UIBarButtonItem) {
        
        // emitir el comprtamiento al boton agreagr
        let presentarElModoAñadir = presentingViewController is UINavigationController
        
        //el usuario pueda cancelar esas accion agregar
        if presentarElModoAñadir {
        //descarta la escena del modal de agregar y devuelve la vsita a la tabla 
        dismiss(animated: true, completion: nil)
        
            //se cree un nuevo control de navegación y me ejecute la accion agregar y guardar una vista en la tabla
        } else if let cancelarNavegationControler = navigationController {
            cancelarNavegationControler.popViewController(animated: true)
        } else {
            fatalError("la tabla equipos no pgenero un nuevo control de navegación")
        }
    }
    
    //Este metodo configura el viewController para guardar la data justo despues de ser presionado el boton save
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        //configura el destino del view controller cuando es presionado el boton guardar
        guard let botonGuardar = sender as? UIBarButtonItem, botonGuardar === guardarBoton  else {
            os_log("el boton guardar no ha sido presionado, cancele la acción", log: OSLog.default, type: .debug)
            
            return
        }
        
        let nombre = nombreTextField.text ?? ""
        let foto = fotoImageView.image
        let rating = ratingControl.rating
        
        //pasa los datos una vez es presionado el boton, guarda la data
        Equipo = InformacionUsuario(nombre: nombre, foto: foto, rating: rating)
    }
    
    
    
    //MARK: uIIMAGEPICKERCONTROLLERDELEGATE METODOS
    
    //este permite que el usario cancele el escoger una foto
    internal func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
        //permite que el usario cancele la escogida de la foto
        dismiss(animated: true, completion: nil)
    }
    
    
    //limpiar la data de la foto que no se escogio
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
         //selecionar una foto origanl y esta no esta me presenta error
        guard let seleccionImgen = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Hay un error al seleccionar la imagen original\(info)")
        }
        
        //alamacena la condicion del guarga en la foto
        fotoImageView.image = seleccionImgen
        
        dismiss(animated: true, completion: nil)
    }

}

