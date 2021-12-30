//
//  NetworkMonitor.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 28/12/21.
//

import Network

class NetworkMonitor {
    
    // MARK: - Propiedades
    
    static let shared = NetworkMonitor()
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    private(set) var isConnected = false
    
    // MARK: - Constructor
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    // MARK: - Métodos
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
}
