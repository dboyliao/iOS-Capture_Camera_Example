## Capture Camera Using AVFoundation Framework

### The Basic

In `AVFoundation`, the basic steps for capturing camera input is as following:

1. Initiate a session.
    - setup the resolution
2. Get input device
    - Typically, it will be default video or audio device.
3. Get device input stream and add it to current session.
4. Setup preview layer
    -  It is a view where to show the captured video.
5. Add preview layer to the super view's layer.
    - Use `insertSublayer(layer:CALayer, atIndex:UInt32)` method.
6. Setup the output view
    - ex: `AVCaptureStillImageOutput`
    - set the `outputSettings` property to `[AVVideoCodecKey:AVVideoCodecJPEG]`
7. Add the output view to the session
8. Start the session by calling `startRunning` method.

**See `CaptureCamera.xcodeproj` for example code.**

### Snippet

```{swift}
let session = AVCaptureSession()

// Step 1.
// check if the session can add particular preset
if session.canSetSessionPreset(AVCaptureSessionPresetPhoto) {
    session.sessionPreset = AVCaptureSessionPresetPhoto
} else {
    // handle the error here...
}

// Step 2.
guard let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo) else {
    // handle the error here...
}
// Step 3.
do {
    let deviceInput = try AVCaptureDeviceInput(device:device)

    if session.canAddInput(deviceInput) {
        session.addInput(deviceInput)
    }

    // Step 4.
    let previewLayer = AVCaptureVideoPreviewLayer(session:session)
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    previewLayer.frame = self.view.frame // set to full screen.

    // Step 5.
    self.view.layer.insertSublayer(previewLayer, atIndex:0) // preset the preview layer.

    // Step 6.
    let stillImageOutput = AVCaptureStillImageOutput()
    stillImageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]

    // Step 7.
    if session.canAddOutput(stillImageOutput){
        session.addOutput(stillImageOutput)
    } else {
        // handle error here
    }

    // Step 8.
    session.startRunning()
} catch {
    // handle the error here...
}

```

## References

- [Custom Camera View & Taking Photos](https://www.youtube.com/watch?v=Xv1FfqVy-KM)
- [Understanding AV Foundation](https://www.youtube.com/watch?v=mCiZW2xW4Ks)
- [Access Front Camera](http://stackoverflow.com/questions/29155623/how-to-get-the-front-camera-in-swift)
