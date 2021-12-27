//
//  AppDependencyContainer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

/// Contenedor principal de inyección de dependencias.
class AppDependencyContainer {
    
    // MARK: - Propiedades
    
    private let sharedMainViewModel: MainContainerViewModel
    
    // MARK: - Constructor
    
    init() {
        func makeMainContainerViewModel() -> MainContainerViewModel {
            MainContainerViewModel()
        }
        
        sharedMainViewModel = makeMainContainerViewModel()
    }
    
    // MARK: - Métodos
    
    // MARK: Main
    
    /// Creación del view controller que actúa como contenedor principal de vistas.
    func makeMainContainerViewController() -> MainContainerViewController {
        let mainContainerViewModel = sharedMainViewModel
        let welcomeViewController = makeWelcomeViewController()
        let cardsListViewControllerFactory = {
            self.makeCardsListViewController()
        }
        
        return MainContainerViewController(
            viewModel: mainContainerViewModel,
            welcomeViewController: welcomeViewController,
            cardsListViewControllerFactory: cardsListViewControllerFactory
        )
    }
    
    // MARK: Welcome
    
    private func makeWelcomeViewController() -> WelcomeViewController {
        let viewModel = makeWelcomeViewModel()
        return WelcomeViewController(viewModel: viewModel)
    }
    
    private func makeWelcomeViewModel() -> WelcomeViewModel {
        WelcomeViewModel(navigator: sharedMainViewModel)
    }
    
    // MARK: - Cards list
    
    private func makeCardsListViewController() -> CardsListViewController {
        let viewModel = makeCardsListViewModel()
        return CardsListViewController(viewModel: viewModel)
    }
    
    private func makeCardsListViewModel() -> CardsListViewModel {
        CardsListViewModel()
    }
    
}
