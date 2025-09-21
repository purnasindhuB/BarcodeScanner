# Barcode Scanner App 

A simple **iOS barcode scanner** app built with **SwiftUI**, **UIKit**, and **AVFoundation**, following the **MVVM architecture**. The app scans **EAN-8** and **EAN-13 barcodes** and displays them in a clean SwiftUI interface.

---

## Features

- Scan barcodes using device camera.
- Live camera preview with `AVCaptureVideoPreviewLayer`.
- Shows scanned code and alerts for errors:
  - Invalid camera input
  - Invalid scanned value
- MVVM architecture:
  - **Model**: `CameraError`, `AlertItem`
  - **View**: `BarcodeScannerView`, `StatusText`
  - **ViewModel/Coordinator**: Bridges UIKit `ScannerVC` with SwiftUI.

---

## Usage

1. Clone the repo and open in Xcode.  
2. Run on a **real device** (camera required).  
3. Point the camera at a barcode to scan.  
4. View scanned code or alerts in the UI.

---

## License

MIT License.  

---

**Developer:** Purnasindhu B.  
GitHub: [https://github.com/purnasindhuB](https://github.com/purnasindhuB)
