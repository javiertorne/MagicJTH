//
//  MainViewModel.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Combine

class MainContainerViewModel {
    
    // MARK: - Propiedades
    
    @Published var navigation: MainNavigation = .welcome
    
}

extension MainContainerViewModel: Navigator {
    
    func navigateToCardsList() {
        navigation = .cardsList
    }
    
    func navigateToCardDetail(_ card: Card) {
        navigation = .cardDetail(card)
    }
    
}
