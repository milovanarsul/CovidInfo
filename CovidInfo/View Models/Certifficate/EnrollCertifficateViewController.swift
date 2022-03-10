//
//  EnrollCertifficateViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.03.2022.
//

import UIKit
import AVFoundation
import Lottie

class EnrollCertifficateViewController: UIViewController{
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var label = UILabel()
    private var animationView: AnimationView!
    private var labelTopConstraint: NSLayoutConstraint!
    
    var captureSession = AVCaptureSession()
    
    override func viewDidLoad(){
        initalSetup()
        QRCodeReader(parentViewController: self, videoLayer: videoLayer, captureSession: captureSession)
        captureSession.startRunning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        //captureSession.stopRunning()
    }
}

extension EnrollCertifficateViewController {
    func initalSetup(){
        label.initialize(text: "Pozitioneaza codul QR in interior", color: .black, font: boldFont(size: 17), alignment: .center, lines: 0)
        self.view.addSubview(label)
        
        let labelConstraints = Constraints(childView: label, parentView: self.view, constraints: [Constraint(constraintType: .horizontal, multiplier: 1, constant: 0)])
        labelConstraints.addConstraints()
        labelTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: videoLayer, attribute: .bottom, multiplier: 1, constant: 60)
        NSLayoutConstraint.activate([labelTopConstraint])
    }
    
    func captureProcessing(metaDataObject: AVMetadataMachineReadableCodeObject){
        label.removeFromSuperview()
        self.videoLayer.addBlur(style: .light)
        self.videoLayer.bringSubviewToFront(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let qrCode: UIImage = generateQRCode(stringToEncode: metaDataObject.stringValue!)!
        localStorageManager.save(image: qrCode, key: "QRCode")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7){
            self.captureSuccess()
        }
    }
    
    func captureSuccess(){
        videoLayer.removeFromSuperview()
        animationView = AnimationView()
        self.view.addSubview(animationView)
        animationView.setup(animationName: "onboarding4.2", loopMode: .playOnce, animationSpeed: 0.5, container: animationView)
        
        let animationViewConstraints = Constraints(childView: animationView, parentView: self.view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.5, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.5, constant: 0)
        ])
        animationViewConstraints.addConstraints()
        animationView.play(completion: {(finished: Bool) in
            delegates.main.dimissModal(completion: {() in
                delegates.main.certifficateModal()
            })
            defaults.defaults.set(true, forKey: "isCertifficateEnrolled")
        })
    }
}

extension EnrollCertifficateViewController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let metaDataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metaDataObject.type == AVMetadataObject.ObjectType.qr {
            if metaDataObject.stringValue != nil {
                captureSession.stopRunning()
                captureProcessing(metaDataObject: metaDataObject)
            }
        }
    }
}
