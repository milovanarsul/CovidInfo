//
//  EnrollCertifficateViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.03.2022.
//

import UIKit
import AVFoundation
class EnrollCertifficateViewController: UIViewController {

    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var scannerMetadataObj: AVMetadataMachineReadableCodeObject?
    var qrCodeFrameView: UIView?
    
    private let photoOutput = AVCapturePhotoOutput()
    private var isCapturing = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("Failed to get the camera device")
            return
        }
        
        do {
            let input =  try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            let captureMetaDataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetaDataOutput)
            
            captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = videoLayer.layer.bounds
            videoLayer.layer.addSublayer(videoPreviewLayer!)
    
            captureSession.addOutput(photoOutput)
            
        } catch { return }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        captureSession.startRunning()
    }
    
    
    func didFinishQRProcess(){
        captureSession.stopRunning()
        videoLayer.isHidden = true
        qrCodeImageView.isHidden = false
    }
    
}

extension EnrollCertifficateViewController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let metaDataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metaDataObject.type == AVMetadataObject.ObjectType.qr {
        }
        
        let photoSettings = AVCapturePhotoSettings()
        if !isCapturing {
            isCapturing = true
            photoOutput.capturePhoto(with: photoSettings, delegate: self)
        }
    }
}

extension EnrollCertifficateViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        isCapturing = false
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("Error while generating image from photo capture data.")
            return
        }
        
        guard let qrImage = UIImage(data: imageData) else {
            print("Unable to generate UIImage from image data.")
            return
        }
        
        qrCodeImageView.image = qrImage
        didFinishQRProcess()
    }
}
