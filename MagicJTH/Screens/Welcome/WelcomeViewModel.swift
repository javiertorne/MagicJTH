//
//  WelcomeViewModel.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Foundation

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
