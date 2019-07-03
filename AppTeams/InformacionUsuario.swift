//
//  InformacionUsuario.swift
//  AppTeams
//
//  Created by Memo Figueredo on 6/26/19.
//  Copyright © 2019 DeTodoUnPoquito. All rights reserved.
//

import Foundation
import UIKit
import os.log


//clases

class InformacionUsuario: NSObject, NSCoding {
    
    //propiedades
    var nombre: String
    var foto: UIImage?
    var rating: Int
    
    //MARK: tipos
    struct propiedadesClaves {
        static let nombre = "nombre"
        static let foto = "foto"
        static let rating = "rating"
    }
    
    //MARK: NSCODING
    
    //decodificar o archivar la información
    func encode(with aCoder: NSCoder) {
        aCoder.encode(nombre, forKey: propiedadesClaves.nombre)
        aCoder.encode(foto, forKey: propiedadesClaves.foto)
        aCoder.encode(rating, forKey: propiedadesClaves.rating)
    }
    
    //cargar a información de mi apliacion
    required convenience init?(coder aDecoder: NSCoder) {
        
        //ejecuta lA CONSTANTE NOMBRE en caso de ser guardado
        guard let nombre = aDecoder.decodeObject(forKey: propiedadesClaves.nombre) as? String else{
            os_log("el nombre del objeto de la calse InformacionUsuario no puede cargarse ", log: OSLog.default, type: .debug)
            
            return nil
        }
        
        //Alamcenar la foto para ser cargada en la apliación
        let foto = aDecoder.decodeObject(forKey: propiedadesClaves.foto) as? UIImage
        //alamcenar la calificación con un dato entero ara ser cargada
        let rating = aDecoder.decodeInteger(forKey: propiedadesClaves.rating)
        
        self.init(nombre: nombre, foto: foto, rating: rating)
    }
    
    //MARK:RUTA DE ARCHIVOS
    //Alamcena la información de mis archivos DirectorioArchivos
    static let DirectorioArchivos = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    //Geenera una nueva extension ara esos archivos InformacionUsuario.ARchivosUrl.path 
    static let ArchivosUrl = DirectorioArchivos.appendingPathComponent("datosEquipo")
    
 
    //inicializar del metodo
    init?( nombre: String, foto: UIImage?, rating: Int){
        
        self.nombre = nombre
        self.foto = foto
        self.rating = rating
        
        //En caso de que coloque una calificaicón negativa o un nombre vacio
        guard !nombre.isEmpty || rating < 0 else {
            return nil
        }
        
        //calificacion de 0 a 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
    }
    
}
