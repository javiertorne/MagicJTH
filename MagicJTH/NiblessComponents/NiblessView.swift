//
//  NiblessView.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit

class NiblessView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable,
        message: "No se soporta cargar esta vista desde un nib en favor del constructor con inyección de dependencias."
    )
    required init?(coder: NSCoder) {
        fatalError("No se soporta cargar esta vista desde un nib en favor del constructor con inyección de dependencias.")
    }

}

protocol ViewForViewControllerProtocol {
    func styleView()
    func constructHierachy()
    func anchorViews()
}

typealias ViewForViewController = NiblessView & ViewForViewControllerProtocol
