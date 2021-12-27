//
//  CardsListViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

class CardsListViewController: NiblessViewController {
    
    // MARK: - Propiedades
    
    private let viewModel: CardsListViewModel
    
    // MARK: - Constructor
    
    init(viewModel: CardsListViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    // MARK: - Ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .purple
    }
    
}
