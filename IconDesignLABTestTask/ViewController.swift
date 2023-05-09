//
//  ViewController.swift
//  IconDesignLABTestTask
//
//  Created by Anton Honcharenko on 09.05.2023.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet private weak var folderInfoContainer: NSStackView!
    @IBOutlet private weak var folderIconImageView: NSImageView!
    @IBOutlet private weak var folderPathLabel: NSTextField!
    @IBOutlet private weak var paintRedButton: NSButton!
    
    private var folderPath: String = "" {
        didSet {
            paintRedButton.isEnabled = !folderPath.isEmpty
            folderInfoContainer.isHidden = folderPath.isEmpty
            folderPathLabel.stringValue = folderPath
        }
    }
    
    private var colorIsChanged: Bool = false {
        didSet {
            folderPathLabel.stringValue = colorIsChanged ? "Folder color changed" : folderPath
            folderPathLabel.textColor = colorIsChanged ? .systemGreen : .labelColor
            paintRedButton.isHidden = colorIsChanged
            folderIconImageView.image = colorIsChanged ? folderIconImageView.image?.withTintColor(.red) : folderIconImageView.image?.withTintColor(.systemTeal)
        }
    }
    
    private func getFilePath() {
        colorIsChanged = false
        guard let window = view.window else {
            showError()
            return }

        let panel = NSOpenPanel()
        panel.canChooseFiles = false
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = false

        panel.beginSheetModal(for: window) { (result) in
            if result.rawValue == 1 {
                guard let folderURL = panel.urls.first else {
                    self.showError()
                    return
                }
                self.folderPath = folderURL.path
            }
        }
    }
    
    private func showError() {
        let alert = NSAlert()
        alert.messageText = "Some error"
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    private func painRed() {
        let workspace = NSWorkspace.shared
        let image = NSImage(named: NSImage.folderName)!
        let redColor = NSColor.red
        image.size = NSMakeSize(128, 128)
        image.lockFocus()
        redColor.set()
        __NSRectFillUsingOperation(NSMakeRect(0, 0, 128, 128), NSCompositingOperation.sourceAtop)
        image.unlockFocus()
        workspace.setIcon(image, forFile: folderPath, options: [])
        workspace.noteFileSystemChanged(folderPath)
        colorIsChanged = true
    }
        
    @IBAction func selectFolderButtonDidPres(_ sender: Any) {
        getFilePath()
    }
    
    @IBAction func paintRedColorButtonDidPres(_ sender: Any) {
        painRed()
    }
}

