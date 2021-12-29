//
//  WelcomeViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

class WelcomeViewController: NiblessViewController {
    
    // MARK: - Propiedades
    
    private let viewModel: WelcomeViewModel
    
    // MARK: - Constructor
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    // MARK: - Métodos
    
    override func loadView() {
        view = WelcomeView(viewModel: viewModel)
    }
    
}
