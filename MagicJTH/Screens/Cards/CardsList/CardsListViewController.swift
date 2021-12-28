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
        
        setupNavigationBar()
        viewModel.fetchAllCards()
        viewModel.sync()
    }
    
    // MARK: - Métodos
    
    override func loadView() {
        view = CardsListView(viewModel: viewModel)
    }
    
    private func setupNavigationBar() {
        title = "cards_list.title.text".localized()
    }
    
}
