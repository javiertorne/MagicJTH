//
//  CardDetailView.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

class CardDetailView: ViewForViewController {
    
    // MARK: - Propiedades
    
    private var hierarchyNotReady = true
    private let viewModel: CardDetailViewModel
    
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
        backgroundColor = .yellow
    }
    
    func constructHierarchy() {
        
    }
    
    func anchorViews() {
        
    }
    
}
