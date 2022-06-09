//
//  QRCodeManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.03.2022.
//

import Foundation
import UIKit
import AVFoundation

func generateQRCode(stringToEncode: String) -> UIImage?{
    let data = stringToEncode.data(using: String.Encoding.ascii)
    guard let qrFilter = CIFilter(name: "CIQRCodeGenerator") else {return nil}
    qrFilter.setValue(data, forKey: "inputMessage")
    guard let qrImage = qrFilter.outputImage else { return nil}
    
    let transform = CGAffineTransform(scaleX: 10, y: 10)
    let scaledQRImage = qrImage.transformed(by: transform)
    
    let context = CIContext()
    guard let cgImage = context.createCGImage(scaledQRImage, from: scaledQRImage.extent) else {return nil}
    
    return UIImage(cgImage: cgImage)
}

func QRCodeReader(parentViewController: UIViewController, videoLayer: UIView, captureSession: AVCaptureSession){
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {return }
    
    do {
        let input = try AVCaptureDeviceInput(device: captureDevice)
        captureSession.addInput(input)
        
        let captureMetaDataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetaDataOutput)
        
        captureMetaDataOutput.setMetadataObjectsDelegate(parentViewController as? AVCaptureMetadataOutputObjectsDelegate, queue: DispatchQueue.main)
        captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoLayer.layer.addSublayer(videoPreviewLayer!)
        
        DispatchQueue.main.async {
            videoPreviewLayer?.frame = videoLayer.bounds
        }
        
        captureSession.startRunning()
    } catch {
        print(error)
        return
    }
}
