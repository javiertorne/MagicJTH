//
//  CardsListViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine
import Dispatch
import UIKit.UIBarButtonItem

class CardsListViewController: NiblessViewController {
    
    // MARK: - Propiedades
    
    private let viewModel: CardsListViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init(viewModel: CardsListViewModel) {
        self.viewModel = viewModel
        
        super.init()
    }
    
    // MARK: - Ciclo de vida
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        observeErrorMessages()
        observeState()
        viewModel.fetchAllCards()
    }
    
    // MARK: - Métodos
    
    override func loadView() {
        view = CardsListView(viewModel: viewModel)
    }
    
    private func setupNavigationBar() {
        title = "cards_list.title.text".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.clockwise.circle.fill"), style: .plain, target: viewModel, action: #selector(viewModel.sync))
    }
    
    private func observeErrorMessages() {
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                if let errorMessage = errorMessage {
                    self?.present(errorMessage: errorMessage) {
                        self?.viewModel.resetErrorMessage()
                    }
                }
            }
            .store(in: &subscriptions)
    }
    
    private func observeState() {
        viewModel.$screenState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let strongSelf = self else { return }
                switch state {
                case .none:
                    print("🟢 ESTADO NULO")
                case .reading:
                    print("🟢 ESTADO LEYENDO")
                    print("🔴 MUESTRO CARGANDO")
                case .read:
                    print("🟢 ESTADO LEIDO")
                case .syncing:
                    print("🟢 ESTADO SINCRONIZANDO")
                    print("🔴 MUESTRO CARGANDO")
                case .synchronized:
                    print("🟢 ESTADO SINCRONIZADO")
                case .refreshing:
                    print("🟢 ESTADO REFRESCANDO")
                case .refreshed:
                    print("🟢 ESTADO REFRESCADO")
                }
                if state == .read {
                    strongSelf.viewModel.sync()
                }
            }
            .store(in: &subscriptions)
    }
    
}
