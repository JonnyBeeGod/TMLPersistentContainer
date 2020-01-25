//
//  File.swift
//  
//
//  Created by Jonas Reichert on 25.01.20.
//

import Foundation
import CoreData

extension Sequence where Iterator.Element == Bundle {
    
    /// this looks through all bundles of the sequence and returns all `NSManagedObjectModel` with the supplied `name`
    /// - Parameters:
    ///   - name: The name of the managed object model to use with the container.
    ///           This name is used as the default name for the first persistent store.
    func managedObjectModels(with name: String) -> [NSManagedObjectModel] {
        return self.compactMap { (bundle) -> URL? in
            bundle.url(forResource: name, withExtension: "momd")
        }.compactMap { (url) -> NSManagedObjectModel? in
            NSManagedObjectModel(contentsOf: url)
        }
    }
}
