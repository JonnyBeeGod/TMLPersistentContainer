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
    let bundle1 = MockBundle(mockedURL: nil)
    let bundle2 = MockBundle(mockedURL: URL())
}

class MockBundle: BundleProtocol {
    var mockedURL: URL?
    
    init(mockedURL: URL?) {
        self.mockedURL = mockedURL
    }
    
    func url(forResource name: String?, withExtension ext: String?) -> URL? {
        return url
    }
}
