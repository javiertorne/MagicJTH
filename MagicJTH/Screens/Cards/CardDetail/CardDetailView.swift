//
//  CardDetailView.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import UIKit
import SDWebImage

class CardDetailView: ViewForViewController {
    
    // MARK: - Propiedades
    
    private var hierarchyNotReady = true
    private let viewModel: CardDetailViewModel
    
    // MARK: - Vistas
    
    private var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [name, imageView, text])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = Measurement.margin
        return stack
    }()
    
    private lazy var name: UILabel = {
        let label = UILabel()
        label.text = viewModel.card.name
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let image = UIImageView()
        if let imageUrl = viewModel.card.imageURL {
            image.contentMode = .scaleAspectFit
            image.sd_setImage(with: URL(string: imageUrl))
        }
        return image
    }()
    
    private lazy var text: UILabel = {
        let label = UILabel()
        label.text = viewModel.card.text
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Constructor
    
    init(viewModel: CardDetailViewModel) {
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
        addSubview(scrollView)
        scrollView.addSubview(stackView)
    }
    
    func anchorViews() {
        anchorScrollView()
        anchorStackView()
    }
    
    private func anchorScrollView() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    private func anchorStackView() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Measurement.margin),
            stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Measurement.margin)
        ])
    }
    
}
