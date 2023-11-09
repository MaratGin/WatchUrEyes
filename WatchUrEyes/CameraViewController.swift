//
//  File.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 29.09.2023.
//

import Foundation
import UIKit
import AVFoundation
import Vision

class CameraViewController: UIViewController {

    private var cameraView: CameraView = CameraView()
    
    private let videoDataOutputQueue = DispatchQueue(label: "CameraFeedDataOutput", qos: .userInteractive)
    private var cameraFeedSession: AVCaptureSession?
    private var handPoseRequest = VNDetectHumanHandPoseRequest()
    
    private let drawPath = UIBezierPath()
    private var evidenceBuffer = [HandGestureProcessor.PointsPair]()
    private var lastDrawPoint: CGPoint?
    private var isFirstSegment = true
    private var lastObservationTimestamp = Date()
    
    private var gestureProcessor = HandGestureProcessor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Можно задетектировать только 1 руку.
        handPoseRequest.maximumHandCount = 1
        // Add state change handler to hand gesture processor. / Добавляем обработчик состояний для жеста реки
        gestureProcessor.didChangeStateClosure = { [weak self] state in
            self?.handleGestureStateChange(state: state)
        }
        // Устанавливаем, что на дабл клик стирается доска.
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        recognizer.numberOfTouchesRequired = 1
        recognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(recognizer)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        do {
            if cameraFeedSession == nil {
                cameraView.previewLayer.videoGravity = .resizeAspectFill
                try setupAVSession()
                cameraView.previewLayer.session = cameraFeedSession
            }
            cameraFeedSession?.startRunning()
        } catch {
            AppError.display(error, inViewController: self)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        cameraFeedSession?.stopRunning()
        super.viewWillDisappear(animated)
    }
    
    func setupAVSession() throws {
        // Select a front facing camera, make an input.
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            throw AppError.captureSessionSetup(reason: "Could not find a front facing camera.")
        }
        
        guard let deviceInput = try? AVCaptureDeviceInput(device: videoDevice) else {
            throw AppError.captureSessionSetup(reason: "Could not create video device input.")
        }
        
        let session = AVCaptureSession()
        session.beginConfiguration()
        session.sessionPreset = AVCaptureSession.Preset.high
        
        // Add a video input.
        guard session.canAddInput(deviceInput) else {
            throw AppError.captureSessionSetup(reason: "Could not add video device input to the session")
        }
        session.addInput(deviceInput)
        
        let dataOutput = AVCaptureVideoDataOutput()
        if session.canAddOutput(dataOutput) {
            session.addOutput(dataOutput)
            // Add a video data output.
            dataOutput.alwaysDiscardsLateVideoFrames = true
            dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            dataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            throw AppError.captureSessionSetup(reason: "Could not add video data output to the session")
        }
        session.commitConfiguration()
        cameraFeedSession = session
}
    
    func processPoints(thumbTip: CGPoint?, indexTip: CGPoint?, middleTip: CGPoint?, ringTip: CGPoint?, pinkyTip: CGPoint?) {
        // Check that we have both points.
        guard let thumbPoint = thumbTip, let indexPoint = indexTip,
              let middlePoint = middleTip, let ringPoint = ringTip,
              let pinkyPoint = pinkyTip else {
            // If there were no observations for more than 2 seconds reset gesture processor.
            if Date().timeIntervalSince(lastObservationTimestamp) > 2 {
                gestureProcessor.reset()
            }
            cameraView.showPoints([], color: .clear)
            return
        }
        
        // Convert points from AVFoundation coordinates to UIKit coordinates.
        let previewLayer = cameraView.previewLayer
        
        let thumbPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: thumbPoint)
        let indexPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: indexPoint)
        let middlePointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: middlePoint)
        let ringPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: ringPoint)
        let pinkyPointConverted = previewLayer.layerPointConverted(fromCaptureDevicePoint: pinkyPoint)



        
        // Process new points
        gestureProcessor.processPointsPair((thumbPointConverted, indexPointConverted, middlePointConverted, ringPointConverted, pinkyPointConverted ))
    }
    
    private func handleGestureStateChange(state: HandGestureProcessor.State) {
        let pointsPair = gestureProcessor.lastProcessedPointsPair
//        var tipsColor: UIColor
        print("Found hand")
        cameraView.showPoints([pointsPair.thumbTip, pointsPair.indexTip, pointsPair.middleTip, pointsPair.ringTip, pointsPair.pinkyTip], color: .red)
    }
    
    
    @IBAction func handleGesture(_ gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else {
            return
        }
        evidenceBuffer.removeAll()
        drawPath.removeAllPoints()
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    public func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        var thumbTip: CGPoint?
        var indexTip: CGPoint?
        var middleTip: CGPoint?
        var ringTip: CGPoint?
        var pinkyTip: CGPoint?

        
        
        defer {
            DispatchQueue.main.sync {
                self.processPoints(thumbTip: thumbTip, indexTip: indexTip, middleTip: middleTip, ringTip: ringTip, pinkyTip: pinkyTip)
            }
        }

        let handler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up, options: [:])
        do {
            // Perform VNDetectHumanHandPoseRequest
            try handler.perform([handPoseRequest])
            // Continue only when a hand was detected in the frame.
            // Since we set the maximumHandCount property of the request to 1, there will be at most one observation.
            guard let observation = handPoseRequest.results?.first else {
                return
            }
            // Get points for thumb and index finger. Точки Большого и указательного пальца
            let thumbPoints = try observation.recognizedPoints(.thumb)
            let indexFingerPoints = try observation.recognizedPoints(.indexFinger)
            let middleFingerPoints = try observation.recognizedPoints(.middleFinger)
            let ringFingerPoints = try observation.recognizedPoints(.ringFinger)
            let pinkyFingerPoints = try observation.recognizedPoints(.littleFinger)
            
            
            // Look for tip points.
            guard let thumbTipPoint = thumbPoints[.thumbTip],
                    let indexTipPoint = indexFingerPoints[.indexTip],
                    let middleTipPoint = middleFingerPoints[.middleTip],
                    let ringTipPoint = ringFingerPoints[.ringTip],
                    let pinkyTipPoint = pinkyFingerPoints[.littleTip]
            else {
                return
            }
            // Ignore low confidence points.
            guard thumbTipPoint.confidence > 0.3 && indexTipPoint.confidence > 0.3
                    && middleTipPoint.confidence > 0.3 && ringTipPoint.confidence > 0.3
                    && pinkyTipPoint.confidence > 0.3
            else {
                return
            }
            // Convert points from Vision coordinates to AVFoundation coordinates.
            thumbTip = CGPoint(x: thumbTipPoint.location.x, y: 1 - thumbTipPoint.location.y)
            indexTip = CGPoint(x: indexTipPoint.location.x, y: 1 - indexTipPoint.location.y)
            middleTip = CGPoint(x: middleTipPoint.location.x, y: 1 - middleTipPoint.location.y)
            ringTip = CGPoint(x: ringTipPoint.location.x, y: 1 - ringTipPoint.location.y)
            pinkyTip = CGPoint(x: pinkyTipPoint.location.x, y: 1 - pinkyTipPoint.location.y)
        } catch {
            cameraFeedSession?.stopRunning()
            let error = AppError.visionError(error: error)
            DispatchQueue.main.async {
                error.displayInViewController(self)
            }
        }
    }
}


