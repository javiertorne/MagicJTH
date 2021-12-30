//
//  MagicJTHUITests.swift
//  MagicJTHUITests
//
//  Created by Javier Torné Hernández on 26/12/21.
//

import XCTest

class WelcomeUITests: XCTestCase {
    
    // MARK: - Propiedades
    
    var app: XCUIApplication!
    
    // MARK: - Ciclo de vida
    
    override func setUp() {
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        app = nil
    }
    
    // MARK: - Tests
    
    /// Test que prueba que cuando se crea, están todos los elementos.
    func testWelcomeView_whenInit_allElementsExists() {
        XCTAssertTrue(app.staticTexts["nameSurnameLabel"].exists, "Debería estar el label con el nombre.")
        XCTAssertTrue(app.staticTexts["emailLabel"].exists, "Debería estar el label con el email.")
        XCTAssertTrue(app.staticTexts["dateLabel"].exists, "Debería estar el label con la fecha.")
        XCTAssertTrue(app.buttons["accessButton"].exists, "Debería estar el botón para acceder.")
    }
    
    /// Test que prueba que cuando se pulsa el botón de acceder, se muestra la pantalla de lista de cartas
    func testWelcomeView_whenAccessButtonTapped_showCardsListView() {
        app.buttons["accessButton"].tap()
        XCTAssertTrue(app.navigationBars["Cartas"].exists, "Debería mostrarse la pantalla de listado de cartas.")
    }
    
}
