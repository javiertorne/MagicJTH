//
//  WelcomeView.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit

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
        label.text = "welcome.name_label.text".localized()
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        label.accessibilityIdentifier = "nameSurnameLabel"
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "welcome.email_label.text".localized()
        label.textAlignment = .center
        label.accessibilityIdentifier = "emailLabel"
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "welcome.date_label.text".localized()
        label.textAlignment = .center
        label.accessibilityIdentifier = "dateLabel"
        return label
    }()
    
    private lazy var accessButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "welcome.access_button.text".localized()
        config.baseBackgroundColor = .systemBrown
        button.configuration = config
        button.addTarget(viewModel, action: #selector(viewModel.accessTapped), for: .touchUpInside)
        button.accessibilityIdentifier = "accessButton"
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
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Measurement.margin),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Measurement.margin)
        ])
    }
    
}
