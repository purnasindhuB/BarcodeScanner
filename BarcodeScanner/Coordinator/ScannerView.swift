//
//  ScannerView.swift
//  BarcodeScanner
//
//  Created by Purnasindhu-749 on 21/09/25.
//

import SwiftUI

struct ScannerView: UIViewControllerRepresentable {
    @Binding var scannedCode  : String
    @Binding var alertItem : AlertItem?
    
    func makeUIViewController(context: Context) -> ScannerVC {
        ScannerVC(scannerDelegate: context.coordinator)
    }
    
    func updateUIViewController(_ uiViewController: ScannerVC, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(scannerView : self)
    }
    
        final class Coordinator : NSObject, ScannerVcDelegate {
            private let scannerView : ScannerView
            
            init (scannerView: ScannerView) {
                self.scannerView = scannerView
            }
            
            func didFind(barcode: String) {
                scannerView.scannedCode = barcode
            }
            
            func didSurface(error: CameraError) {
                switch error {
                case .invalidDeviceInput:
                    scannerView.alertItem = AlertContext.invalidDeviceInput
                case .invalidScannedValue :
                    scannerView.alertItem = AlertContext.invalidScannedValue
                }
            }
    }
}
   

