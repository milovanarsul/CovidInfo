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
    
    lazy var videoLayer: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.isHidden = true
        return activityIndicator
    }()
    
    func setup(){
        view.backgroundColor = .white
        view.addSubview(videoLayer)
        
        let videoLayerConstraints = Constraints(childView: videoLayer, parentView: view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.65, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 30)
        ])
        videoLayerConstraints.addConstraints()
        
        videoLayer.addSubview(activityIndicator)
        xyConstraints(childView: activityIndicator, parentView: videoLayer)
    }
    
    private var label = UILabel()
    private var animationView: AnimationView!
    private var labelTopConstraint: NSLayoutConstraint!

    var captureSession = AVCaptureSession()
    
    override func viewDidLoad(){
        delegates.enrollCertifficate = self
        setup()
        initalSetup()
        QRCodeReader(parentViewController: self, videoLayer: videoLayer, captureSession: captureSession)
    }
}

extension EnrollCertifficateViewController {
    func initalSetup(){
        label.initialize(text: "Pozitioneaza codul QR in interior", color: .black, font: boldFont(size: 17), alignment: .center, lines: 0)
        self.view.addSubview(label)
        
        let labelConstraints = Constraints(childView: label, parentView: view, constraints: [Constraint(constraintType: .horizontal, multiplier: 1, constant: 0)])
        labelConstraints.addConstraints()
        labelTopConstraint = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: videoLayer, attribute: .bottom, multiplier: 1, constant: 80)
        NSLayoutConstraint.activate([labelTopConstraint])
    }
    
    func captureProcessing(metaDataObject: AVMetadataMachineReadableCodeObject){
        label.removeFromSuperview()
        self.videoLayer.addBlur(style: .light)
        self.videoLayer.bringSubviewToFront(activityIndicator)
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let qrCode: UIImage = generateQRCode(stringToEncode: metaDataObject.stringValue!)!
        localStorageManager.save(image: qrCode, key: "QRCode"){ completion in
            if completion{
                DispatchQueue.main.async {
                    defaults.set(true, forKey: "certifficateEnrolled")
                    self.videoLayer.removeFromSuperview()
                    self.mainCaptureSuccess()
                }
            }
        }
    }
    
    func mainCaptureSuccess(){
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
            if self.presentingViewController is MainViewController {
                delegates.main.dimissModal(completion: {() in
                    delegates.main.certifficateModal()
                })
                delegates.main.updateCertifficateButton()
            } else {
                delegates.onboarding.dismissModal(completion: {})
                delegates.onboardingPVC.nextPage?()
            }
        })
    }
}

extension EnrollCertifficateViewController: AVCaptureMetadataOutputObjectsDelegate, EnrollCertifficateDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        let metaDataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metaDataObject.type == AVMetadataObject.ObjectType.qr {
            if metaDataObject.stringValue != nil {
                captureSession.stopRunning()
                captureProcessing(metaDataObject: metaDataObject)
            }
        }
    }
    
    func stopCapture() {
        captureSession.stopRunning()
    }
}
