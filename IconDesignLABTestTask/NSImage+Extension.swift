//
//  NSImage+Extension.swift
//  IconDesignLABTestTask
//
//  Created by Anton Honcharenko on 09.05.2023.
//

import Cocoa

extension NSImage {
    func withTintColor(_ color: NSColor) -> NSImage {
        let image = self.copy() as! NSImage
        image.lockFocus()
        color.set()
        let imageRect = NSRect(origin: NSZeroPoint, size: image.size)
        imageRect.fill(using: .sourceAtop)
        image.unlockFocus()
        return image
    }
}
