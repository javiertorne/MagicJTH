//
//  CardsListViewModelPerformanceTests.swift
//  MagicJTHPerformanceTests
//
//  Created by Javier Torné Hernández on 30/12/21.
//

import XCTest
@testable import MagicJTH

class CardsListViewModelPerformanceTests: XCTestCase {
    
    // MARK: - Propiedades
    
    var sut: CardsListViewModel!
    var cardsRepository: CardsRepository!
    var navigator: MainContainerViewModel!
    
    // MARK: - Ciclo de vida
    
    override func setUp() {
        cardsRepository = FakeCardsRepositoryImpl()
        navigator = MainContainerViewModel()
        
        sut = CardsListViewModel(
            cardsRepository: cardsRepository,
            navigator: navigator
        )
        
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        navigator = nil
    }
    
    // MARK: - Tests
    
    /// Test que mide el rendimiento de crear un view model de listado de cartas.
    func testCardsListViewModel_init_measurePerformance() {
        measure {
            _ = CardsListViewModel(
                cardsRepository: cardsRepository,
                navigator: navigator
            )
        }
    }
    
    /// Test que mide el rendimiento de obtener todas las cartas.
    func testCardsListViewModel_fetchAllCards_measurePerformance() {
        measure {
            sut.fetchAllCards()
        }
    }
    
    /// Test que mide el rendimiento de forzar sincronización.
    func testCardsListViewModel_forceSync_measurePerformance() {
        measure {
            sut.forceSync()
        }
    }
    
    /// Test que mide el rendimiento de la sincronización no forzada.
    func testCardsListViewModel_sync_measurePerformance() {
        measure {
            sut.sync()
        }
    }
    
    /// Test que mide el rendimiento de pulsar sobre una carta.
    func testCardsListViewModel_cardTapped_measurePerformance() {
        // When
        sut.fetchAllCards()
        
        // Measure
        measure {
            sut.cardTapped(at: 0)
        }
    }
    
    /// Test que mide el rendimiento de obtener un mensaje de error.
    func testCardsListViewModel_getErrorMessage_measurePerformance() {
        measure {
            _ = sut.getErrorMessage(error: CustomError.unknown)
        }
    }
    
    /// Test que mide el rendimiento de resetear el mensaje de error.
    func testCardsListViewModel_resetErrorMessage_measurePerformance() {
        measure {
            sut.resetErrorMessage()
        }
    }
    
}
