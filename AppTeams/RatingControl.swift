//
//  RatingControl.swift
//  AppTeams
//
//  Created by Memo Figueredo on 6/25/19.
//  Copyright © 2019 DeTodoUnPoquito. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //Mark: propiedades
    private var cambioBotones = [UIButton]()
    var rating = 0{
        didSet{
            actualizarEstadoBotonSeleccionado()
        }
    }
    
    //tamaño de las tamaño estrellas
    @IBInspectable  var tamañoEstella: CGSize = CGSize(width: 44.0, height: 44.0){
        
        didSet{
           crearBoton()
        }
    }
    //cuantas estrellas hay
    @IBInspectable var contadorEstrellas: Int = 5{
        
        didSet{
            crearBoton()
        }
    }
    
    
    //MARK: accion Boton
    @objc func presionarBoton(boton: UIButton){
        print("boton presionado 👍🏾")
        guard let index = cambioBotones.firstIndex(of: boton)else{
            fatalError("El boton, \(boton), no se encuentra en el arreglo cambioBotones: \(cambioBotones)")
        }
        
        //calcular el cabio al selecionar el boton
        let seleccionBoton = index + 1
        
        
        if seleccionBoton == rating {
            rating = 0
        }else{
            rating = seleccionBoton
        }
    }
    
    
    //init frame: inicializa la vista init coder: cargar esa vista

    //MARK: Inicialización
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        crearBoton()
    }
    
    required init(coder: NSCoder) {
        
        super.init(coder: coder)
        crearBoton()
    }
    
    //MARK: metodos Privados
    
    private func crearBoton(){
        
        //limpiar botones antiguos del guion grafico
        for boton in cambioBotones {
            removeArrangedSubview(boton)
            boton.removeFromSuperview()
        }
        
        cambioBotones.removeAll()
        
        //cargar imagenes del boton
        let bundle = Bundle(for: type(of: self))
        let estrellaLlena = UIImage(named: "estrenallena", in: bundle, compatibleWith: self.traitCollection)
        let estrellaVacia = UIImage(named: "estrenaVacia", in: bundle, compatibleWith: self.traitCollection)
        let estrellaResaltada = UIImage(named: "estrenaResaltadora", in: bundle, compatibleWith: self.traitCollection)
        
        
        
        
        
        for index in 0..<contadorEstrellas {
        //crear boton
        let boton = UIButton()
        
        //cargar las imagenes en el mainStoryBoard
        boton.setImage(estrellaVacia, for: .normal)
        boton.setImage(estrellaLlena, for: .selected)
        boton.setImage(estrellaResaltada, for: .highlighted)
        boton.setImage(estrellaResaltada, for: [.highlighted, .selected])
        
        //añadimos constrains
        boton.translatesAutoresizingMaskIntoConstraints = false
        boton.heightAnchor.constraint(equalToConstant: tamañoEstella.height).isActive = true
        boton.widthAnchor.constraint(equalToConstant: tamañoEstella.width).isActive = true
        
        //Label de accesibilidad
        boton.accessibilityLabel = "la calificación \(index + 1 ) en el valor de estrella"
        
        //Accion del Boton
        boton.addTarget(self, action: #selector(RatingControl.presionarBoton(boton:)), for: .touchUpInside)
        
        //añadir el boton en la stak view
        addArrangedSubview(boton)
            
            //cargar botones
            cambioBotones.append(boton)
        }
        
        actualizarEstadoBotonSeleccionado()
    }
    
    private func actualizarEstadoBotonSeleccionado(){
        
        for (index, boton) in cambioBotones.enumerated(){
            boton.isSelected = index < rating
            
            let PistaString: String?
            
            if rating == index + 1 {
                PistaString = "se reinicio la calificación"
            } else {
                PistaString = nil
            }
            
            //establecer condiciones cuando no se escogio una estrlla,cuando se escoge una estrella y cuando se escoge un conjuntos
            let valorString: String
            
            switch (rating){
            case 0:
                valorString = "No se ha escogido ninguna calificación"
            case 1:
                valorString = " 1 estrella escogida"
            default:
                valorString = "\(rating) estrellas escogidas"
            }
            
            //genera una pista añ usuario a travez de voice over
            boton.accessibilityHint = PistaString
            //genera valores para los mensajes o casos en caso de no haber escogido una calificaicón, escogido una estrlla, un conjunto de estrellas 
            boton.accessibilityValue = valorString
        }
        
    }
    
}
