//
//  CardCell.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    // MARK: - Propiedades
    
    private var hierarchyNotReady = true
    
    var card: Card? {
        didSet {
            populateData()
        }
    }
    
    // MARK: - Views
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    

    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, typeLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = Measurement.halfMargin
        return stackView
    }()
    
    // MARK: - Métodos
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard hierarchyNotReady else {
            return
        }
        
        backgroundColor = .tertiarySystemBackground
        constructHierarchy()
        anchorViews()
        populateData()
        
        hierarchyNotReady = false
    }
    
    private func constructHierarchy() {
        contentView.addSubview(mainStackView)
    }
    
    private func anchorViews() {
        anchorMainStackView()
    }
    
    private func anchorMainStackView() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Measurement.halfMargin),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Measurement.halfMargin),
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Measurement.margin),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Measurement.margin)
        ])
    }
    
    func populateData() {
        nameLabel.text = card?.name
        typeLabel.text = card?.type
    }
    
}
