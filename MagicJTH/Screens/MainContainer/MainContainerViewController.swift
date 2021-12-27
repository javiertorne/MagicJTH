//
//  MainViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

/// View controller principal que sirve como contenedor para el resto de vistas.
/// También se encarga de la navegación entre pantallas.
class MainContainerViewController: NiblessViewController {
    
    // MARK: - Propiedades
    
    private let viewModel: MainContainerViewModel
    
    // MARK: - Constructor
    
    init(viewModel: MainContainerViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
}
