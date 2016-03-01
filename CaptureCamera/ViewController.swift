//
//  ViewController.swift
//  CaptureCamera
//
//  Created by DboyLiao on 3/1/16.
//  Copyright © 2016 dboyliao. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var textMessge: UITextView!
    
    var session:AVCaptureSession? {
        let session = AVCaptureSession()
        if session.canSetSessionPreset(AVCaptureSessionPresetPhoto) {
            print("Photo!")
            session.sessionPreset = AVCaptureSessionPresetPhoto
        } else if session.canSetSessionPreset(AVCaptureSessionPresetMedium){
            print("Medium")
            session.sessionPreset = AVCaptureSessionPresetMedium
        } else if session.canSetSessionPreset(AVCaptureSessionPresetLow){
            print("Low")
            session.sessionPreset = AVCaptureSessionPresetLow
        } else {
            return nil
        }
        
        return session
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textMessge.hidden = true
        
        // 1. initiate session
        if let session = self.session{
            
            // 2. get device
            guard let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) else {
                print("No default video device available.")
                return
            }
            
            // 3. construct device input (failable)
            do {
                let deviceInput = try AVCaptureDeviceInput(device:device)
                
                if session.canAddInput(deviceInput) {
                    session.addInput(deviceInput)
                } else {
                    print("can not add input!")
                    return
                }
                
                // 4. setup layer for the capture view.
                let previewLayer = AVCaptureVideoPreviewLayer(session: session)
                previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                previewLayer.frame = captureView.frame
                
                // 5. add preview layer to super view's layer.
                let rootLayer = self.view.layer
                rootLayer.masksToBounds = false
                rootLayer.insertSublayer(previewLayer, atIndex:0)
                
                // 6. set output view
                let stillImageOutput = AVCaptureStillImageOutput()
                stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
                
                // 7. add it to session
                if session.canAddOutput(stillImageOutput){
                    session.addOutput(stillImageOutput)
                } else {
                    print("can not add output!")
                    return
                }
                session.startRunning()
            } catch {
                print("Initiate device input fail.")
            }
        } else {
            print("viewWillAppear")
            textMessge.hidden = false
        }
    }


}

