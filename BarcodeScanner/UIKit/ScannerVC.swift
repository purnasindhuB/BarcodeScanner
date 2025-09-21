//
//  ScannerVC.swift
//  BarcodeScanner
//
//  Created by Purnasindhu-749 on 21/09/25.
//

///Camera → Input → Session → Output(s) + PreviewLayer
import AVFoundation
import UIKit
enum CameraError : String {
    case invalidDeviceInput = "Something went wrong"
    case invalidScannedValue = "The value scanned is not valid"
}
protocol ScannerVcDelegate : AnyObject {
    func didFind(barcode:String)
    func didSurface(error : CameraError)
}

final class ScannerVC : UIViewController {
    ///Manages flow of data fron input devices connects inputs (camera/mic) to outputs (video/photo/metadata).
    let captureSession = AVCaptureSession()
    ///Animation layer that displays video from camera inside view
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    weak var scannerDelegate : ScannerVcDelegate?
    init(scannerDelegate:ScannerVcDelegate) {
        super.init(nibName: nil, bundle: nil)
        self.scannerDelegate = scannerDelegate
    }
    
    required init?(coder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setupCaptureSession()
    }
    
    override func viewDidLayoutSubviews() {
        guard let previewLayer = previewLayer else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.layer.bounds
    }
    
    private func setupCaptureSession() {
        ///gets the device camera
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        let videoInput : AVCaptureDeviceInput
        ///wraps into AVCaptureDeviceInput
        do{
            try videoInput = AVCaptureDeviceInput(device: videoCaptureDevice)
        }catch {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        if captureSession.canAddInput(videoInput) {
            captureSession.addInput(videoInput)
        }else {
            scannerDelegate?.didSurface(error: .invalidDeviceInput)
            return
        }
        
        ///can detect barcodes,QRCodes
        let metaDataOutput = AVCaptureMetadataOutput()
        
        if captureSession.canAddOutput(metaDataOutput) {
            captureSession.addOutput(metaDataOutput)
            ///so whenever a barcode is detected, your delegate method is called
            metaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metaDataOutput.metadataObjectTypes = [.ean8,.ean13]
        } else { 
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        captureSession.startRunning()
    }
}
extension ScannerVC : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        guard let machineReadableObject = object as? AVMetadataMachineReadableCodeObject else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        guard let barcode = machineReadableObject.stringValue else {
            scannerDelegate?.didSurface(error: .invalidScannedValue)
            return
        }
        captureSession.stopRunning()
        scannerDelegate?.didFind(barcode: barcode)
    }
    
}
