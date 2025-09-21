//
//  Alert.swift
//  BarcodeScanner
//
//  Created by Purnasindhu-749 on 21/09/25.
//

import Foundation
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

