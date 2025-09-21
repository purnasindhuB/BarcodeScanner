//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Purnasindhu-749 on 21/09/25.
//

import SwiftUI

struct BarcodeScannerView: View {
    @StateObject var viewModel = BarcodeScannerViewModel()
    
    var body: some View {
        NavigationStack{
            VStack {
                ScannerView(scannedCode: $viewModel.scannedCode,alertItem: $viewModel.alertItem)
                ///.infinity try its best to fill the screen
                    .frame(maxWidth: .infinity,maxHeight:300)
                Spacer().frame(height: 60)
                
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                StatusText(titleText: viewModel.statusText, titleColor: viewModel.statusTextColor)
            }
            .navigationTitle("Barcode Scanner")
            .padding()
            .alert(item: $viewModel.alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
        }
    }
}

#Preview {
    BarcodeScannerView()
}
