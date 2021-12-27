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
    private let welcomeViewController: WelcomeViewController
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Constructor
    
    init(
        viewModel: MainContainerViewModel,
        welcomeViewController: WelcomeViewController
    ) {
        self.viewModel = viewModel
        self.welcomeViewController = welcomeViewController
        
        super.init()
    }
    
    // MARK: - Métodos
    
    override func viewDidLoad() {
        super.viewDidLoad()

        observeViewModel()
    }
    
    func observeViewModel() {
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
        }
    }
    
    func presentWelcome() {
        addFullScreen(childViewController: welcomeViewController)
    }
    
}
