//
//  ComicsViewModelUnitTest.swift
//  KoloTests
//
//  Created by Intugine on 16/04/22.
//

import Foundation
import SwiftyJSON
@testable import Kolo
import XCTest

class ComicsViewModelUnitTest: XCTestCase {
    var sut: ComicsViewModel!
    
    override func setUp() {
        sut = ComicsViewModel()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func testGetCellCount_noData_count() {
        //Arrange
        sut.comicsData = ComicsDataModel()
        
        //Act
        let result = sut.getCellCount()
        
        //Assert
        XCTAssertEqual(result, 0)
    }
    
    func testGetImage_wrongIndex_count() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getCellCount()
        
        //Assert
        XCTAssertEqual(result, 1)
    }
    
    func testGetImage_noData_emptyString() {
        //Arrange
        sut.comicsData = ComicsDataModel()
        
        //Act
        let result = sut.getImage(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetImage_wrongIndex_emptyString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getImage(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetImage_correctIndex_imageString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getImage(index: 0)
        
        //Assert
        XCTAssertEqual(result, "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_fantastic.jpg")
    }
    
    func testGetName_noData_emptyString() {
        //Arrange
        sut.comicsData = ComicsDataModel()
        
        //Act
        let result = sut.getTitle(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetName_wrongIndex_emptyString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getTitle(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetName_correctIndex_imageString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getTitle(index: 0)
        
        //Assert
        XCTAssertEqual(result, "Marvel Previews (2017)")
    }
    
    func testGetDescription_noData_emptyString() {
        //Arrange
        sut.comicsData = ComicsDataModel()
        
        //Act
        let result = sut.getDescription(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetDescription_wrongIndex_emptyString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getDescription(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetDescription_correctIndex_imageString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getDescription(index: 0)
        
        //Assert
        XCTAssertEqual(result, "Read More")
    }
    
    func testGetUrlnoData_emptyString() {
        //Arrange
        sut.comicsData = ComicsDataModel()
        
        //Act
        let result = sut.getUrl(index: 0)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGeturl_wrongIndex_emptyString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getUrl(index: 1)
        
        //Assert
        XCTAssertEqual(result, "")
    }
    
    func testGetUrl_correctIndex_imageString() {
        //Arrange
        guard let comicData = try? JSON(data: ComicViewModelDummyData().comicData) else {return}
        sut.comicsData = ComicsDataModel(json: comicData)
        
        //Act
        let result = sut.getUrl(index: 0)
        
        //Assert
        XCTAssertEqual(result, "http://marvel.com/comics/issue/82967/marvel_previews_2017?utm_campaign=apiRef&utm_source=dd9416431c8b03ff80d64353bb7d1e40")
    }
}
