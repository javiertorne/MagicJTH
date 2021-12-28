//
//  NiblessNavigationController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit

class NiblessNavigationController: UINavigationController {
    
    // MARK: - Constructor
    
    init(viewController: UIViewController) {
        super.init(rootViewController: viewController)
    }
    
    // MARK: - Methods
    
    @available(*, unavailable, message: "Cargar este controlador de vistas desde un nib no se soporta en favor de un constructor con inyección de dependencias.")
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    @available(*, unavailable, message: "Cargar este controlador de vistas desde un nib no se soporta en favor de un constructor con inyección de dependencias.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cargar este controlador de vistas desde un nib no se soporta en favor de un constructor con inyección de dependencias.")
    }
    
}
