//
//  CardsListView.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import UIKit
import Combine

class CardsListView: ViewForViewController {
    
    // MARK: - Propiedades
    
    private var hierarchyNotReady = true
    private let viewModel: CardsListViewModel
    private let cardsCellId = "cardsCellId"
    private var subscriptions = Set<AnyCancellable>()
    
    // MARK: - Views
    
    let cardsCollectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Constructor
    
    init(frame: CGRect = .zero, viewModel: CardsListViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
    }
    
    // MARK: - Métodos
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        
        guard hierarchyNotReady else {
            return
        }
        
        constructHierarchy()
        anchorViews()
        setupPeopleCollectionView()
        observeCards()
        
        hierarchyNotReady = false
    }
    
    func styleView() {
        cardsCollectionView.backgroundColor = .systemBackground
    }
    
    func constructHierarchy() {
        addSubview(cardsCollectionView)
    }
    
    func anchorViews() {
        NSLayoutConstraint.activate([
            cardsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            cardsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func setupPeopleCollectionView() {
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        cardsCollectionView.register(CardCell.self, forCellWithReuseIdentifier: cardsCellId)
    }
    
    private func observeCards() {
        viewModel.$cards
            .receive(on: DispatchQueue.main)
            .sink { [weak self] people in
                self?.cardsCollectionView.reloadData()
            }.store(in: &subscriptions)
    }
    
}

extension CardsListView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardsCellId, for: indexPath) as! CardCell
        cell.card = viewModel.cards[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.goToDetail(index: indexPath.item)
        print("pulsado \(indexPath.item)")
    }
    
}
