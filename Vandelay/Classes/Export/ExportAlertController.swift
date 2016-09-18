//
//  DataExportAlertController.swift
//  Vandelay
//
//  Created by Daniel Saidi on 2016-08-30.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 This alert controller can be used to present the user
 with options for exporting data.
 
 Add one or several exporters with addDataExporter and
 addStringExporter functions, then set the delegate to
 detect when the user selects an exporter.
 
 */

import UIKit


public protocol ExportAlertControllerDelegate: class {
    func alert(_ alert: ExportAlertController, didPickDataExporter exporter: DataExporter)
    func alert(_ alert: ExportAlertController, didPickStringExporter exporter: StringExporter)
}


public class ExportAlertController: UIAlertController {
    
    weak public var delegate: ExportAlertControllerDelegate?
    
    
    public func addDataExporter(exporter: DataExporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .default) { action in
            self.delegate?.alert(self, didPickDataExporter: exporter)
        }
        addAction(action)
    }
    
    public func addStringExporter(exporter: StringExporter, withTitle title: String) {
        let action = UIAlertAction(title: title, style: .default) { action in
            self.delegate?.alert(self, didPickStringExporter: exporter)
        }
        addAction(action)
    }
}