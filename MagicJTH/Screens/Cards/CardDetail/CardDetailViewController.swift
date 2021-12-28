//
//  CardDetailViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

class CardDetailViewController: NiblessViewController {
    
    // MARK: - Propiedades
    
    private let viewModel: CardDetailViewModel
    
    // MARK: - Constructor
    
    init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    // MARK: - Métodos
    
    override func loadView() {
        view = CardDetailView()
    }
    
}
