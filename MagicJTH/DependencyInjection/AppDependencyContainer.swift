//
//  AppDependencyContainer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

/// Contenedor principal de inyección de dependencias.
/// Desde aquí se crean todas las dependencias que necesita la app. Al ser una app de muestra muy pequeña, con tenerlas aquí es suficiente, pero si tuviésemos una app más grande se podría hacer un contenedor para cada funcionalidad.
/// Por ejemplo, podríamos tener un contenedor para el acceso y registro a la app, otro para el perfil de usuario, etc. Cada uno encargado de proporcionar las dependencias a las pantallas que maneje.
/// Las cosas que fuesen a ser comunes se pondrían en el contenedor principal, y formaríamos el árbol de contenedores con herencias.
class AppDependencyContainer {
    
    // MARK: - Propiedades
    
    private let sharedMainViewModel: MainContainerViewModel
    
    // Repositorios
    private let cardsRepository: CardsRepository
    
    // MARK: - Constructor
    
    init() {
        func makeMainContainerViewModel() -> MainContainerViewModel {
            MainContainerViewModel()
        }
        
        sharedMainViewModel = makeMainContainerViewModel()
        let repositoriesContainer = RepositoriesDependencyContainer()
        cardsRepository = repositoriesContainer.makeCardsRepository()
    }
    
    // MARK: - Métodos
    
    // MARK: Main
    
    func makeMainContainerViewController() -> MainContainerViewController {
        let mainContainerViewModel = sharedMainViewModel
        let welcomeViewController = makeWelcomeViewController()
        let cardsListViewControllerFactory = {
            self.makeCardsListViewController()
        }
        let cardDetailViewControllerFactory = { (card: CardDTO) in
            self.makeCardDetailViewController(card)
        }
        
        return MainContainerViewController(
            viewModel: mainContainerViewModel,
            welcomeViewController: welcomeViewController,
            cardsListViewControllerFactory: cardsListViewControllerFactory,
            cardDetailViewControllerFactory: cardDetailViewControllerFactory
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
    
    // MARK: Cards list
    
    private func makeCardsListViewController() -> CardsListViewController {
        let viewModel = makeCardsListViewModel()
        return CardsListViewController(viewModel: viewModel)
    }
    
    private func makeCardsListViewModel() -> CardsListViewModel {
        CardsListViewModel(
            cardsRepository: cardsRepository,
            navigator: sharedMainViewModel
        )
    }
    
    // MARK: Card detail
    
    private func makeCardDetailViewController(_ card: CardDTO) -> CardDetailViewController {
        let viewModel = makeCardDetailViewModel(card)
        return CardDetailViewController(viewModel: viewModel)
    }
    
    private func makeCardDetailViewModel(_ card: CardDTO) -> CardDetailViewModel {
        CardDetailViewModel(card: card)
    }
    
}
