//
//  ViewController+Import.swift
//  VandelayExample
//
//  Created by Daniel Saidi on 2018-09-16.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import UIKit
import Vandelay
// import VandelayDropbox
// import VandelayQr

extension ViewController {
    
    func importPhotoAlbum() {
        let title = "Import photo album"
        let message = "How do you want to import this data?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(importPhotoAlbumAction(for: FileImporter(fileName: photoFile), title: "From a local file"))
        alert.addAction(importPhotoAlbumAction(for: UrlImporter(url: photoUrl), title: "From a local file URL"))
        alert.addAction(importWithEmailImporterAction(title: "From an e-mail attachment"))
        // alert.addAction(importPhotoAlbumAction(for: QrCodeImporter(fromViewController: self), title: "By scanning a QR code"))
        // alert.addAction(importPhotoAlbumAction(for: DropboxImporter(fromViewController: self, fileName: photoFile), title: "From a Dropbox file"))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func importPhotoAlbum(with importer: DataImporter) {
        importer.importData { [weak self] result in
            self?.alertImportResult(result)
            guard let data = result.data else { return }
            let photos = try? JSONDecoder().decode([Photo].self, from: data)
            self?.photoRepository.add(photos ?? [])
            self?.reloadData()
        }
    }
    
    func importTodoList() {
        let title = "Import todo list"
        let message = "How do you want to import this data?"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(importTodoListAction(for: PasteboardImporter(), title: "From the pasteboard"))
        alert.addAction(importTodoListAction(for: FileImporter(fileName: photoFile), title: "From a local file"))
        alert.addAction(importTodoListAction(for: UrlImporter(url: photoUrl), title: "From a local file URL"))
        alert.addAction(importWithEmailImporterAction(title: "From an e-mail attachment"))
        // alert.addAction(importTodoListAction(for: QrCodeImporter(fromViewController: self), title: "By scanning a QR code"))
        // alert.addAction(importTodoListAction(for: DropboxImporter(fromViewController: self, fileName: photoFile), title: "From a Dropbox file"))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func importTodoList(with importer: StringImporter) {
        importer.importString { [weak self] result in
            self?.alertImportResult(result)
            guard let string = result.string else { return }
            guard let data = string.data(using: .utf8) else { return }
            let items = try? JSONDecoder().decode([TodoItem].self, from: data)
            self?.todoItemRepository.add(items ?? [])
            self?.reloadData()
        }
    }
}

// MARK: - Import functions

private extension ViewController {
    
    func importPhotoAlbumAction(for importer: DataImporter, title: String) -> UIAlertAction {
        let action = { [weak self] importer in self?.importPhotoAlbum(with: importer)}
        return UIAlertAction(title: title, style: .default) { _ in action(importer) }
    }
    
    func importTodoListAction(for importer: StringImporter, title: String) -> UIAlertAction {
        let action = { [weak self] importer in self?.importTodoList(with: importer)}
        return UIAlertAction(title: title, style: .default) { _ in action(importer) }
    }
    
    func importWithEmailImporterAction(title: String) -> UIAlertAction {
        UIAlertAction(title: title, style: .default) { _ in
            self.alert(title: "Import external file", message: "You can try this by exporting data from this app to an e-mail, then tap the attached .vdl file and share it back to this app.")
        }
    }
}
