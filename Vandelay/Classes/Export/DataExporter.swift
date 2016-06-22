//
//  DataExporter.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-06-01.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This protocol is implemented by all Vandelay exporters
 that can be used to export NSData. Use a data exporter
 when your data cannot be serialized in other ways, e.g.
 if an object contains NSData properties that result in
 nil when serialized to e.g. JSON (images, for intance).
 
 */

import Foundation

public protocol DataExporter: class, Exporter {
    
    func exportData(data: NSData, completion: ((result: ExportResult) -> ()))
}