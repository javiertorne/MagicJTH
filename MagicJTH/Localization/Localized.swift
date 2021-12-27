//
//  Localized.swift
//  MagicJTH
//
//  Created by Javier Torné Hernández on 27/12/21.
//

import Foundation

extension String {
    
    /// Cargar el string localizado correspondiente a la key dada.
    /// - Parameters:
    ///   - bundle: Bundle principal.
    ///   - tableName: Nombre del fichero.
    /// - Returns: El valor asociado a la clave dada.
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
    
    /// Carga el string localizado correspondiente a la clave dada, con los parámetros dados.
    /// - Parameter arguments: Parámetros que debe tener el valor del string.
    /// - Returns: El valor asociado a la clave dada.
    func localized(with arguments: [CVarArg]) -> String {
        String(format: NSLocalizedString(self, comment: ""), arguments: arguments)
    }
    
}
