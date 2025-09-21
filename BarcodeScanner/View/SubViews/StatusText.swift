//
//  StatusText.swift
//  BarcodeScanner
//
//  Created by Purnasindhu-749 on 21/09/25.
//

import Foundation
import SwiftUI

struct StatusText : View {
    var titleText : String
    var titleColor : any ShapeStyle
    var body: some View {
        Text(titleText)
            .bold()
            .font(.largeTitle)
            .foregroundStyle(titleColor)
            .padding()
    }
}

struct StatusTextPreviewProvider : PreviewProvider {
    static var previews: some View {
        StatusText(titleText: "Scanned", titleColor: .red)
    }
}

