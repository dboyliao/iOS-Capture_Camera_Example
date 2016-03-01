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

## References

- [Custom Camera View & Taking Photos](https://www.youtube.com/watch?v=Xv1FfqVy-KM)
- [Understanding AV Foundation](https://www.youtube.com/watch?v=mCiZW2xW4Ks)
