//
//  NiblessNavigationController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit

class NiblessNavigationController: UINavigationController {
    
    // MARK: - Constructor
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Methods
    
    @available(*, unavailable, message: "Cargar este controlador de vistas desde un nib no se soporta en favor de un constructor con inyección de dependencias.")
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    @available(*, unavailable, message: "Cargar este controlador de vistas desde un nib no se soporta en favor de un constructor con inyección de dependencias.")
    required init?(coder aDecoder: NSCoder) {
        fatalError("Cargar este controlador de vistas desde un nib no se soporta en favor de un constructor con inyección de dependencias.")
    }
    
}
