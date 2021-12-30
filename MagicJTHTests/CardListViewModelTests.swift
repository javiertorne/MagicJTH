//
//  CardListViewModelTests.swift
//  MagicJTHTests
//
//  Created by Javier Torné Hernández on 26/12/21.
//

import XCTest
@testable import MagicJTH

class CardListViewModelTests: XCTestCase {
    
    // MARK: - Propiedades
    
    var sut: CardsListViewModel!
    var navigator: MainContainerViewModel!
    
    // MARK: - Ciclo de vida
    
    override func setUp() {
        let cardsRepository = FakeCardsRepositoryImpl()
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
    
    /// Test que prueba que cuando se crea, se inyecta una dependencia de CardsRepository.
    func testCardsListViewModel_whenInit_cardsRepositoryIsInjected() {
        XCTAssertNotNil(sut.cardsRepository, "El repositorio de cartas no puede ser nulo cuando se crea CardsListViewModel.")
    }
    
    /// Test que prueba que cuando se crea, se inyecta una dependencia de Navigator.
    func testCardsListViewModel_whenInit_navigatorIsInjected() {
        XCTAssertNotNil(sut.navigator, "El navigator no puede ser nulo cuando se crea CardsListViewModel.")
    }
    
    /// Test que prueba que cuando se crea, el listado de cartas está vacío.
    func testCardsListViewModel_whenInit_cardsArrayIsEmpty() {
        XCTAssertEqual(sut.cards.count, 0, "El array de cartas tiene que estar vacío cuando se crea CardsListViewModel.")
    }
    
    /// Test que prueba que cuando se crea, el estado de la pantalla es notSyncing.
    func testCardsListViewModel_whenInit_screenStateIsNotSyncing() {
        XCTAssertEqual(sut.screenState, .notSyncing, "El estado de la pantalla tiene que ser No Sincronizando cuando se crea CardsListViewModel.")
    }
    
    /// Test que prueba que cuando se crea, el set de suscripciones de Combine está vacío.
    func testCardsListViewModel_whenInit_combineSubscriptionSetIsEmpty() {
        XCTAssertEqual(sut.subscriptions.count, 0, "El set de suscripciones de Combine tiene que estar vacío cuando se crea CardsListViewModel.")
    }
    
    /// Test que prueba que cuando se crea, el mensaje de error está nulo.
    func testCardsListViewModel_whenInit_errorMessageIsNil() {
        XCTAssertNil(sut.errorMessage, "El mensaje de error tiene que ser nulo cuando se crea CardsListViewModel.")
    }
    
    /// Test que prueba que cuando se llama a obtener todas las cartas, el publisher de cartas emite un nuevo valor si todo está bien.
    func testCardsListViewModel_whenFetchAllCards_cardsAreReturned() {
        // When
        sut.fetchAllCards()
        
        // Then
        XCTAssertFalse(sut.cards.isEmpty, "No se han obtenido cartas al llamar a fetchAllCards")
    }
    
    /// Test que prueba que cuando se llama a obtener todas las cartas, el publisher de mensaje de error emite un nuevo valor si hay error.
    func testCardsListViewModel_whenFetchAllCards_errorMessageSettedWhenFail() {
        // Given
        let fakeErrorsCardsRepositoryImpl = FakeErrorsCardsRepositoryImpl()
        sut = CardsListViewModel(
            cardsRepository: fakeErrorsCardsRepositoryImpl,
            navigator: navigator
        )
        
        // When
        sut.fetchAllCards()
        
        // Then
        XCTAssertNotNil(sut.errorMessage, "No se ha generado un mensaje de error al llamar a fetchAllCards cuando da fallo.")
    }
    
    /// Test que prueba que cuando se llama a obtener todas las cartas, la llamada al repositorio solo se hace una vez.
    func testCardsListViewModel_whenFetchAllCards_cardRepositoryMethodIsCalledOnce() {
        // When
        sut.fetchAllCards()
        
        // Then
        let repository = (sut.cardsRepository as! FakeCardsRepositoryImpl)
        XCTAssertEqual(repository.readTimesCalled, 1, "No se llama a la función exactamente una vez.")
    }
    
    // Más tests para cada función del view model...
    
}
