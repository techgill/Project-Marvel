//
//  CharactersViewModelUnitTest.swift
//  KoloTests
//
//  Created by Intugine on 16/04/22.
//

import XCTest
import SwiftyJSON
@testable import Kolo

class CharactersViewModelUnitTest: XCTestCase {
    var sut: CharactersViewModel!
    
    override func setUp() {
        sut = CharactersViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testGetCellCount_noData_count() {
        //Arrange
        sut.characterData = CharctersDataModel()
        
        //Act
        let result = sut.getCellCount()
        
        //Assert
        XCTAssertEqual(result, 0)
    }
    
    func testGetImage_wrongIndex_count() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getCellCount()
        
        //Assert
        XCTAssertEqual(result, 1)
    }
    
    func testGetImage_noData_emptyString() {
        //Arrange
        sut.characterData = CharctersDataModel()
        
        //Act
        let result = sut.getImage(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetImage_wrongIndex_emptyString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getImage(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetImage_correctIndex_imageString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getImage(index: 0)
        
        //Assert
        XCTAssertEqual(result, "http://i.annihil.us/u/prod/marvel/i/mg/c/e0/535fecbbb9784/standard_fantastic.jpg")
    }
    
    func testGetName_noData_emptyString() {
        //Arrange
        sut.characterData = CharctersDataModel()
        
        //Act
        let result = sut.getName(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetName_wrongIndex_emptyString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getName(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetName_correctIndex_imageString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getName(index: 0)
        
        //Assert
        XCTAssertEqual(result, "3-D Man")
    }
    
    func testGetDescription_noData_emptyString() {
        //Arrange
        sut.characterData = CharctersDataModel()
        
        //Act
        let result = sut.getDescription(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetDescription_wrongIndex_emptyString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getDescription(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetDescription_correctIndex_imageString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getDescription(index: 0)
        
        //Assert
        XCTAssertEqual(result, "Read More")
    }
    
    func testGetUrlnoData_emptyString() {
        //Arrange
        sut.characterData = CharctersDataModel()
        
        //Act
        let result = sut.getUrl(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGeturl_wrongIndex_emptyString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getUrl(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetUrl_correctIndex_imageString() {
        //Arrange
        guard let characterData = try? JSON(data: CharactersViewModelDummyData().characterData) else {return}
        sut.characterData = CharctersDataModel(json: characterData)
        
        //Act
        let result = sut.getUrl(index: 0)
        
        //Assert
        XCTAssertEqual(result, "http://marvel.com/characters/74/3-d_man?utm_campaign=apiRef&utm_source=dd9416431c8b03ff80d64353bb7d1e40")
    }
}
