//
//  ContentView.swift
//  BarcodeScanner
//
//  Created by Purnasindhu-749 on 21/09/25.
//

import SwiftUI

struct AlertItem : Identifiable{
    let id = UUID()
    let title : String
    let message : String
    let dismissButton : Alert.Button
}

struct AlertContext {
    static let invalidDeviceInput = AlertItem(title: "Invalid Device Input",
                                              message: "Something went wrong with inout try again ",
                                              dismissButton: .default(Text("Ok")))
    static let invalidScannedValue = AlertItem(title: "Invalid Scanned Value ",
                                              message: "Something went wrong with scanned value ",
                                              dismissButton: .default(Text("Ok")))

}

struct BarcodeScannerView: View {
    @State private var scannedCode = ""
    @State private var alertItem : AlertItem?
    
    var body: some View {
        NavigationStack{
            VStack {
                ScannerView(scannedCode: $scannedCode,alertItem: $alertItem)
                ///.infinity try its best to fill the screen
                    .frame(maxWidth: .infinity,maxHeight:300)
                Spacer().frame(height: 60)
                Label("Scanned Barcode", systemImage: "barcode.viewfinder")
                    .font(.title)
                
                Text(scannedCode.isEmpty ? "Not yet Scanned" : scannedCode)
                    .bold()
                    .font(.largeTitle)
                    .foregroundStyle(scannedCode.isEmpty ? .green : .red)
                    .padding()
                //                Button {
                //                    isShowingAlert = true
                //                } label: {
                //                    Text("Tap Me")
                //                }
                
            }
            .navigationTitle("Barcode Scanner")
            .padding()
            //            .alert(isPresented: $isShowingAlert, content: {
            //                            Alert(title: Text("Test Alert"),message: Text("Test Alert Msg"),dismissButton: .default((Text("Ok"))))
            .alert(item: $alertItem) { alertItem in
                Alert(title: Text(alertItem.title), message: Text(alertItem.message), dismissButton: alertItem.dismissButton)
            }
        }
    }
}

#Preview {
    BarcodeScannerView()
}
