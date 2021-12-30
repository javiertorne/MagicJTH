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
    
    private let cardsCollectionView: UICollectionView = {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.hidesWhenStopped = true
        activityIndicator.accessibilityIdentifier = "activityIndicatorView"
        return activityIndicator
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
        
        styleView()
        constructHierarchy()
        anchorViews()
        observeScreenState()
        setupCardsCollectionView()
        observeCards()
        
        hierarchyNotReady = false
    }
    
    func styleView() {
        backgroundColor = .systemBackground
        cardsCollectionView.backgroundColor = .systemBackground
    }
    
    func constructHierarchy() {
        addSubview(cardsCollectionView)
        addSubview(activityIndicatorView)
    }
    
    func anchorViews() {
        anchorCollectionView()
        anchorActivityIndicator()
    }
    
    private func anchorCollectionView() {
        NSLayoutConstraint.activate([
            cardsCollectionView.topAnchor.constraint(equalTo: topAnchor),
            cardsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cardsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func anchorActivityIndicator() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setupCardsCollectionView() {
        cardsCollectionView.delegate = self
        cardsCollectionView.dataSource = self
        cardsCollectionView.register(CardCell.self, forCellWithReuseIdentifier: cardsCellId)
    }
    
    private func observeCards() {
        viewModel.$cards
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.cardsCollectionView.reloadData()
            }.store(in: &subscriptions)
    }
    
    private func observeScreenState() {
        viewModel.$screenState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .notSyncing:
                    self?.hideActivityIndicator()
                case .syncing:
                    self?.viewModel.cards.count == 0 ? self?.showActivityIndicator() : self?.hideActivityIndicator()
                case .forceSyncing:
                    self?.showActivityIndicator()
                }
            }
            .store(in: &subscriptions)
    }
    
    private func hideActivityIndicator() {
        activityIndicatorView.stopAnimating()
        cardsCollectionView.isHidden = false
    }
    
    private func showActivityIndicator() {
        activityIndicatorView.startAnimating()
        cardsCollectionView.isHidden = true
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
        viewModel.cardTapped(at: indexPath.item)
    }
    
}
