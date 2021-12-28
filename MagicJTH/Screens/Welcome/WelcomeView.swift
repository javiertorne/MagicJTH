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
    private let viewModel: WelcomeViewModel
    
    // MARK: - Vistas
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [nameSurnameLabel, emailLabel, dateLabel, accessButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Measurement.margin
        stack.setCustomSpacing(Measurement.quadrupleMargin, after: dateLabel)
        return stack
    }()
    
    private let nameSurnameLabel: UILabel = {
        let label = UILabel()
        label.text = "Javier Torné Hernández"
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "javiertorne88@gmail.com"
        label.textAlignment = .center
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "welcome.date_label.text".localized()
        label.textAlignment = .center
        return label
    }()
    
    private lazy var accessButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "welcome.access_button.text".localized()
        button.configuration = config
        button.addTarget(viewModel, action: #selector(viewModel.accessTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Constructor
    
    init(viewModel: WelcomeViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
    }
    
    // MARK: - Métodos
    
    override func didMoveToWindow() {
        super.didMoveToWindow()

        guard hierarchyNotReady else {
            return
        }

        styleView()
        constructHierarchy()
        anchorViews()

        hierarchyNotReady = false
    }
    
    func styleView() {
        backgroundColor = .systemBackground
    }
    
    func constructHierarchy() {
        addSubview(stackView)
    }
    
    func anchorViews() {
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Measurement.margin),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Measurement.margin)
        ])
    }
    
}
