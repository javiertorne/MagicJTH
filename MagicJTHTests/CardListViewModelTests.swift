//
//  CardListViewModelTests.swift
//  MagicJTHTests
//
//  Created by Javier Torné Hernández on 26/12/21.
//

import XCTest
@testable import MagicJTH

class CardListViewModelTests: XCTestCase {
    
    /**
     ¿Qué quiero testear?
     
     1- Que cuando se crea, se inyecta una dependencia de CardsRepository.
     2- Que cuando se crea, se inyecta una dependencia de Navigator.
     3- Que cuando se crea, el listado de cartas está vacío.
     4- Que cuando se crea, el estado de la pantalla es notSyncing.
     5- Que cuando se crea, el set de suscripciones de Combine está vacío.
     6- Que cuando se crea, el mensaje de error está nulo.
     7- Que cuando se llama a obtener todas las cartas, el publisher de cartas emite un nuevo valor si todo está bien.
     8- Que cuando se llama a obtener todas las cartas, el publisher de mensaje de error emite un nuevo valor si hay error.
     9- Que cuando se llama a sincronizar, el publisher de mensaje de error emite un nuevo valor si hay error.
     10- Que cuando se llama a sincronizar, el publisher de cartas emite un nuevo valor si todo está bien.
     11- Que cuando se llama a sincronizar, el estado de la pantalla es syncing.
     12- Que cuando se llama a sincronizar de manera forzada, el estado de la pantalla es forceSyncing.
     13- Que cuando se llama a sincronizar, el estado de la pantalla vuelve a notSyncinc cuando acaba la operación.
     14- Que cuando se llama a obtener mensaje de error, se obtiene un error genérico si el error no es propio.
     15- Que cuando se llama a obtener mensaje de error, se obtiene un error de tipo no internet cuando no hay internet.
     16- Que cuando se llama a obtener mensaje de error, se obtiene un error de tipo desconocido cuando es desconocido.
     17- Que cuando se llama a obtener mensaje de error, se obtiene un error de tipo otros cuando es otros.
     18- Que cuando se llama a restaurar el mensaje de error, el mensaje de error es nulo.
     */
    
    // MARK: - Propiedades
    
    var sut: CardsListViewModel!
    let navigator = MainContainerViewModel()
    
    override func setUp() {
        let cardsRepository = FakeCardsRepositoryImpl()
        sut = CardsListViewModel(
            cardsRepository: cardsRepository,
            navigator: navigator
        )
        
        super.setUp()
    }
    
    /// 1- Test que prueba que cuando se crea, se inyecta una dependencia de CardsRepository.
    func testCardsListViewModel_whenInit_cardsRepositoryIsInjected() {
        XCTAssertNotNil(sut.cardsRepository, "El repositorio de cartas no puede ser nulo cuando se crea CardsListViewModel.")
    }
    
    /// 2- Test que prueba que cuando se crea, se inyecta una dependencia de Navigator.
    func testCardsListViewModel_whenInit_navigatorIsInjected() {
        XCTAssertNotNil(sut.navigator, "El navigator no puede ser nulo cuando se crea CardsListViewModel.")
    }
    
    /// 3- Test que prueba que cuando se crea, el listado de cartas está vacío.
    func testCardsListViewModel_whenInit_cardsArrayIsEmpty() {
        XCTAssertEqual(sut.cards.count, 0, "El array de cartas tiene que estar vacío cuando se crea CardsListViewModel.")
    }
    
    /// 4- Test que prueba que cuando se crea, el estado de la pantalla es notSyncing.
    func testCardsListViewModel_whenInit_screenStateIsNotSyncing() {
        XCTAssertEqual(sut.screenState, .notSyncing, "El estado de la pantalla tiene que ser No Sincronizando cuando se crea CardsListViewModel.")
    }
    
    /// 5- Test que prueba que cuando se crea, el set de suscripciones de Combine está vacío.
    func testCardsListViewModel_whenInit_combineSubscriptionSetIsEmpty() {
        XCTAssertEqual(sut.subscriptions.count, 0, "El set de suscripciones de Combine tiene que estar vacío cuando se crea CardsListViewModel.")
    }
    
    /// 6- Test que prueba que cuando se crea, el mensaje de error está nulo.
    func testCardsListViewModel_whenInit_errorMessageIsNil() {
        XCTAssertNil(sut.errorMessage, "El mensaje de error tiene que ser nulo cuando se crea CardsListViewModel.")
    }
    
    /// 7- Test que prueba que cuando se llama a obtener todas las cartas, el publisher de cartas emite un nuevo valor si todo está bien.
    func testCardsListViewModel_whenFetchAllCards_cardsAreReturned() {
        // When
        sut.fetchAllCards()
        
        // Then
        XCTAssertFalse(sut.cards.isEmpty, "No se han obtenido cartas al llamar a fetchAllCards")
    }
    
    /// 8- Test que prueba que cuando se llama a obtener todas las cartas, el publisher de mensaje de error emite un nuevo valor si hay error.
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
    
}
