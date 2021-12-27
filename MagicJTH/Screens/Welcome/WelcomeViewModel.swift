//
//  WelcomeViewModel.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Foundation

/// View model de la pantalla de bienvenida.
class WelcomeViewModel {
    
    // MARK: - Propiedades
    
    private let navigator: Navigator
    
    // MARK: - Constructor
    
    init(navigator: Navigator) {
        self.navigator = navigator
    }
    
    // MARK: - Métodos
    
    @objc func accessTapped() {
        navigator.navigateToCardsList()
    }
    
}
