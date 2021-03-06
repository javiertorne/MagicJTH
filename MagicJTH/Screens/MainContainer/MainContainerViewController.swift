//
//  MainViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine
import Dispatch

class MainContainerViewController: NiblessNavigationController {
    
    // MARK: - Propiedades
    
    private let viewModel: MainContainerViewModel
    private var subscriptions = Set<AnyCancellable>()
    
    // View controllers hijos
    private let welcomeViewController: WelcomeViewController
    private var cardsListViewController: CardsListViewController?
    private var cardDetailViewController: CardDetailViewController?
    
    // Factorías
    private let makeCardsListViewController: () -> CardsListViewController
    private let makeCardDetailViewController: (CardDTO) -> CardDetailViewController
    
    // MARK: - Constructor
    
    init(
        viewModel: MainContainerViewModel,
        welcomeViewController: WelcomeViewController,
        cardsListViewControllerFactory: @escaping () -> CardsListViewController,
        cardDetailViewControllerFactory: @escaping (CardDTO) -> CardDetailViewController
    ) {
        self.viewModel = viewModel
        self.welcomeViewController = welcomeViewController
        makeCardsListViewController = cardsListViewControllerFactory
        makeCardDetailViewController = cardDetailViewControllerFactory
        
        super.init()
    }
    
    // MARK: - Métodos
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        observeNavigation()
    }
    
    private func setupNavigationBar() {
        navigationBar.prefersLargeTitles = true
        navigationBar.tintColor = .label
    }
    
    private func observeNavigation() {
        viewModel.$navigation
            .receive(on: DispatchQueue.main)
            .sink { [weak self] screen in
                self?.present(screen)
            }
            .store(in: &subscriptions)
    }
    
    private func present(_ screen: MainNavigation) {
        switch screen {
        case .welcome:
            presentWelcome()
        case .cardsList:
            presentCardsList()
        case .cardDetail(let card):
            presentCardDetail(card)
        }
    }
    
    private func presentWelcome() {
        addFullScreen(childViewController: welcomeViewController)
    }
    
    private func presentCardsList() {
        remove(childViewController: welcomeViewController)
        
        cardsListViewController = makeCardsListViewController()
        
        if cardsListViewController != nil {
            pushViewController(cardsListViewController!, animated: false)
        }
    }
    
    private func presentCardDetail(_ card: CardDTO) {
        cardDetailViewController = makeCardDetailViewController(card)
        
        if cardDetailViewController != nil {
            pushViewController(cardDetailViewController!, animated: true)
        }
    }
    
}
