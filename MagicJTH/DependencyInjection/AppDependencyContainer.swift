//
//  AppDependencyContainer.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

/// Contenedor principal de inyección de dependencias.
class AppDependencyContainer {
    
    // MARK: - Métodos
    
    // MARK: Main
    
    /// Creación del view controller que actúa como contenedor principal de vistas.
    func makeMainContainerViewController() -> MainContainerViewController {
        let mainContainerViewModel = makeMainContainerViewModel()
        return MainContainerViewController(viewModel: mainContainerViewModel)
    }
    
    /// Creación de un view model para el view controller que actúa como contenedor principal de vistas.
    private func makeMainContainerViewModel() -> MainContainerViewModel {
        MainContainerViewModel()
    }
    
}
