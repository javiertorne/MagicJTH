//
//  WelcomeView.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

/// Vista de la pantalla de bienvenida
class WelcomeView: ViewForViewController {
    
    // MARK: - Propiedades
    
    private var hierarchyNotReady = true
    
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
        backgroundColor = .brown
    }
    
    func constructHierachy() {
        
    }
    
    func anchorViews() {
        
    }
    
}
