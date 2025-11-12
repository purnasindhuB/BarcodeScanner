//
//  BarcodeScannerViewModel.swift
//  BarcodeScanner
//
//  Created by Purnasindhu-749 on 21/09/25.
//

import Foundation
import SwiftUI

final class BarcodeScannerViewModel : ObservableObject {
    ///braodcast the changes
    @Published  var scannedCode = ""
    @Published  var alertItem : AlertItem?
    
    var statusText : String {
        scannedCode.isEmpty ? "Not yet scanned" : scannedCode
    }
    
    var statusTextColor : Color {
        scannedCode.isEmpty ? .red : .green
    }
}
