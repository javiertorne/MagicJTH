//
//  MainViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine
import Dispatch

/// View controller principal que sirve como contenedor para el resto de vistas.
/// También se encarga de la navegación entre pantallas.
class MainContainerViewController: NiblessViewController {
    
    // MARK: - Propiedades
    
    private let viewModel: MainContainerViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // View controllers hijos
    private let welcomeViewController: WelcomeViewController
    private var cardsListViewController: CardsListViewController?
    
    // Factorías
    private let makeCardsListViewController: () -> CardsListViewController
    
    // MARK: - Constructor
    
    init(
        viewModel: MainContainerViewModel,
        welcomeViewController: WelcomeViewController,
        cardsListViewControllerFactory: @escaping () -> CardsListViewController
    ) {
        self.viewModel = viewModel
        self.welcomeViewController = welcomeViewController
        makeCardsListViewController = cardsListViewControllerFactory
        
        super.init()
    }
    
    // MARK: - Métodos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeNavigation()
    }
    
    func observeNavigation() {
        viewModel.$navigation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] screen in
                self?.present(screen)
            }
            .store(in: &subscriptions)
    }
    
    func present(_ screen: MainNavigation) {
        switch screen {
        case .welcome:
            presentWelcome()
        case .cardsList:
            presentCardsList()
        }
    }
    
    func presentWelcome() {
        addFullScreen(childViewController: welcomeViewController)
    }
    
    func presentCardsList() {
        remove(childViewController: welcomeViewController)
        
        cardsListViewController = makeCardsListViewController()
        
        if cardsListViewController != nil {
            let navigationController = NiblessNavigationController(viewController: cardsListViewController!)
            addFullScreen(childViewController: navigationController)
        }
    }
    
}
