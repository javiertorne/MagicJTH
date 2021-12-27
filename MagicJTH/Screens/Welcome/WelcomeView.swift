//
//  WelcomeView.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit

/// Vista de la pantalla de bienvenida
class WelcomeView: ViewForViewController {
    
    // MARK: - Propiedades
    
    private var hierarchyNotReady = true
    
    // MARK: - Vistas
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameSurnameLabel, emailLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        //stack.spacing = Measurement.halfMargin
        return stack
    }()
    
    private let nameSurnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Javier Torné Hernández"
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "javiertorne88@gmail.com"
        return label
    }()
    
    // MARK: - Métodos
    
    override func didMoveToWindow() {
        super.didMoveToWindow()

        guard hierarchyNotReady else {
            return
        }

        styleView()
        constructHierachy()
        anchorViews()

        hierarchyNotReady = false
    }
    
    func styleView() {
        backgroundColor = .systemBackground
    }
    
    func constructHierachy() {
        addSubview(stackView)
    }
    
    func anchorViews() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}
