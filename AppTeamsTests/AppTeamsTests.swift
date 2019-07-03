//
//  AppTeamsTests.swift
//  AppTeamsTests
//
//  Created by Memo Figueredo on 6/5/19.
//  Copyright © 2019 DeTodoUnPoquito. All rights reserved.
//

import XCTest
@testable import AppTeams

class AppTeamsTests: XCTestCase {

    //MARK: equipo clase test
    func testInicializaciónSatisfactoria(){
       
        //cuando la calificación es cero
        let ceroCalificacionEquipo = InformacionUsuario.init(nombre: "cero", foto: nil, rating: 0)
        XCTAssertNotNil(ceroCalificacionEquipo)
        
      //cuando la calificación es positiva
        let cincoCalificacionSatisfactoria = InformacionUsuario.init(nombre: "positiva", foto: nil, rating: 5)
        XCTAssertNotNil(cincoCalificacionSatisfactoria)
    }
    
    func testInicializacionErronea(){
        
        //Cuando la calificación es negativa
        let calificaciónNegativa = InformacionUsuario.init(nombre: "Negativo", foto: nil, rating: -1)
        XCTAssertNil(calificaciónNegativa)
        
        //cuando la calificación es excedida
        let calificaciónExcedida = InformacionUsuario.init(nombre: "excedida", foto: nil, rating: 6)
        XCTAssertNil(calificaciónExcedida)
        
        //cuando no hay nombre
        let nombreVacio = InformacionUsuario.init(nombre: "", foto: nil, rating: 0)
        XCTAssertNil(nombreVacio)
    }
    
    

}
