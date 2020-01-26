//
//  TestSequence+Extension.swift
//  
//
//  Created by Jonas Reichert on 25.01.20.
//

import Foundation
import XCTest
@testable import TMLPersistentContainer

class TestSequenceExtension: XCTestCase {
    
    func testManagedObjectModelsWithNameEmpty() {
        XCTAssertEqual([Bundle]().managedObjectModels(with: ModelName.TestModel_Simple_1.rawValue), [])
    }
    
    func testManagedObjectModelsWithNameNoMomds() {
        let bundle = MockBundle(mockedURLs: [:])
        XCTAssertEqual([bundle].managedObjectModels(with: ModelName.TestModel_Simple_1.rawValue), [])
    }
    
    func testManagedObjectModelsWithNameNoMomdsWithName() {
        let name = "NoMomdLikeThat.momd"
        let bundle = MockBundle(mockedURLs: [name: URL(string: name)!])
        XCTAssertEqual([bundle].managedObjectModels(with: name), [])
    }
    
    func testManagedObjectModelsWithNameExtensionEdgeCase() {
        let name = "momd.notAMomd"
        let bundle = MockBundle(mockedURLs: [name: URL(string: name)!])
        XCTAssertEqual([bundle].managedObjectModels(with: ModelName.TestModel_Simple_1.rawValue), [])
    }
    
    func testManagedObjectModelsWithNameHappy() {
        let bundle = MockBundle(mockedURLs: [ModelName.TestModel_Simple_1.rawValue: url(for: ModelName.TestModel_Simple_1.rawValue)!])
        let bundle2 = MockBundle(mockedURLs: [ModelName.TestModel_MultiConfig_1.rawValue: url(for: ModelName.TestModel_MultiConfig_1.rawValue)!])
        let result = [bundle, bundle2].managedObjectModels(with: ModelName.TestModel_Simple_1.rawValue)
        XCTAssertEqual(result, [loadManagedObjectModel(ModelName.TestModel_Simple_1)])
    }
    
    func testManagedObjectModelsWithNameHappy2() {
        let bundle = MockBundle(mockedURLs: [ModelName.TestModel_Simple_1.rawValue: url(for: ModelName.TestModel_Simple_1.rawValue)!])
        let bundle2 = MockBundle(mockedURLs: [ModelName.TestModel_MultiConfig_1.rawValue: url(for: ModelName.TestModel_MultiConfig_1.rawValue)!])
        
        let result = [bundle, bundle2].managedObjectModels(with: ModelName.TestModel_MultiConfig_1.rawValue)
        XCTAssertEqual(result, [loadManagedObjectModel(ModelName.TestModel_MultiConfig_1)])
    }
}

struct MockBundle: BundleProtocol, Equatable {
    var mockedURLs = [String: URL]()
    
    init(mockedURLs: [String: URL]) {
        self.mockedURLs = mockedURLs
    }
    
    func url(forResource name: String?, withExtension ext: String?) -> URL? {
        guard let name = name else {
            return nil
        }
        
        return mockedURLs[name]
    }
}
