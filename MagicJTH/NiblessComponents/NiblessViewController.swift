//
//  NiblessViewController.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit

class NiblessViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable,
        message: "No se soporta cargar este view controller desde un nib en favor del constructor con inyección de dependencias."
    )
    required init?(coder: NSCoder) {
        fatalError("No se soporta cargar este view controller desde un nib en favor del constructor con inyección de dependencias.")
    }
    
}
