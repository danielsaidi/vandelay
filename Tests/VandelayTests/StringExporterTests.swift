//
//  StringExporterTests.swift
//  VandelayTests
//
//  Created by Daniel Saidi on 2018-09-13.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import Quick
import Nimble
import Foundation
import Vandelay

class StringExporterTests: QuickSpec {
    
    override func spec() {
        
        var result: ExportResult!
        var exporter: MockDataExporter!
        
        beforeEach {
            result = ExportResult(method: .email, filePath: "foo")
            exporter = MockDataExporter(method: .email, result: result)
        }
        
        
        describe("exporting data for valid codable") {
            
            it("calls base function with data") {
                exporter.exportString(for: TestClass(), encoder: JSONEncoder()) { (_) in }
                let inv = exporter.invokations(of: exporter.export as (String, @escaping ExportCompletion) -> Void)
                expect(inv.count).to(equal(1))
                expect(inv[0].arguments.0).toNot(beNil())
            }
            
            it("completes with export result") {
                exporter.exportString(for: TestClass(), encoder: JSONEncoder()) { result in
                    expect(result.method).to(equal(exporter.exportResult.method))
                }
            }
        }
    }
}

private class TestClass: Codable {
    
    let name: String = "Foo"
}
