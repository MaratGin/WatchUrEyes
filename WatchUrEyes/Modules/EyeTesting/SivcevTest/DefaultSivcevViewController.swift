//
//  DefaultSivcevViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 11.11.2023.
//

import UIKit
import Foundation
import SwiftUI
import Speech
import AVFoundation

class DefaultSivcevViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    private var userGuess = ""
    private var recognizedString = ""
    private var currentRow = 1
    private var currentIndex = 0
    
    private var errorCapV1V2 = 0
    private var errorCapV3V6 = 0
    private var errorCapV6V12 = 0
    
    private var leftEyeResultRow = 5
    private var rightEyeResultRow = 5

    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.frame.size = SizeAsset.row1Size
        iv.backgroundColor = .blue
        return iv
    }()
    
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .heavy)
        label.text = "Chats AI"
        return label
    }()
    
    lazy var hostingController: UIHostingController = {
        var timerView = TimerView(defaultTimeRemaining: 5, radius: 50)
        timerView.background(Color.white)
        timerView.onTimerFinish =  { [weak self] in
            self?.setupEyeTimerFinish()
        }
        let hostingController = UIHostingController(rootView: timerView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    /*
    lazy var hostingController2: UIHostingController = {
        var timerView = TimerView(defaultTimeRemaining: 5, radius: 50)
        timerView.background(Color.white)
        timerView.onTimerFinish =  { [weak self] in
            self?.setupEyeTimerFinish2()
        }
        let hostingController = UIHostingController(rootView: timerView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
     */
    
    var currentLetterImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 248, weight: .heavy)
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLeftEye()
        print("VIEW DID LOAD")
    }
    /*
    func setupRightEye() {
        print("RIGHT 1")
        nameLabel.text = "Закройте правый глаз"
        view.addSubview(nameLabel)
        // Добавляем UIHostingController как дочерний контроллер
        addChild(hostingController2)
        view.addSubview(hostingController2.view)
        print("RIGHT 2")


        
        hostingController2.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        print("RIGHT 4")

        NSLayoutConstraint.activate([
            hostingController2.view.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            hostingController2.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController2.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController2.view.heightAnchor.constraint(equalToConstant: 300)
        ])
        print("RIGHT 5")

    }
     */
    
    
    func setupLeftEye() {
        nameLabel.text = "Закройте левый глаз"
        view.addSubview(nameLabel)
        
        
        // Добавляем UIHostingController как дочерний контроллер
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
    
    func setupEyeTimerFinish() {
        hostingController.view.isHidden = true
        hostingController.removeFromParent()
        startTest()
    }
    /*
    func setupEyeTimerFinish2() {
        hostingController2.view.isHidden = true
        hostingController2.removeFromParent()
        startTest2()
    }
     */
    
    func getRow() -> [(String, UIImage)] {
        var row = [("И", UIImage(named: "e")!)]
        
        switch currentRow {
        case 1:
            row = TextAsset.row1
        case 2:
            row = TextAsset.row2
        case 3:
            row = TextAsset.row3
        case 4:
            row = TextAsset.row4
        case 5:
            row = TextAsset.row5
        case 6:
            row = TextAsset.row6
        case 7:
            row = TextAsset.row7
        case 8:
            row = TextAsset.row8
        case 9:
            row = TextAsset.row9
        case 10:
            row = TextAsset.row10
        case 11:
            row = TextAsset.row11
        case 12:
            row = TextAsset.row12
        default:
            row = TextAsset.row1
        }
        return row
    }
    
    func getLetterSize(row: Int) -> CGSize {
        switch row {
        case 1:
            return SizeAsset.row1Size
        case 2:
            return SizeAsset.row2Size
        case 3:
            return SizeAsset.row3Size
        case 4:
            return SizeAsset.row4Size
        case 5:
            return SizeAsset.row5Size
        case 6:
            return SizeAsset.row6size
        case 7:
            return SizeAsset.row7Size
        case 8:
            return SizeAsset.row8Size
        case 9:
            return SizeAsset.row9Size
        case 10:
            return SizeAsset.row10Size
        case 11:
            return SizeAsset.row11Size
        case 12:
            return SizeAsset.row12Size
        default:
            return SizeAsset.row10Size
        }
    }
    /*
    func startTest2() {
        print("&&&")
        nameLabel.removeFromSuperview()
//        view.backgroundColor = .red
        view.addSubview(currentLetterImageView)
//        currentLetterImageView.backgroundColor = .yellow
        var size = getLetterSize(row: currentRow)
        NSLayoutConstraint.activate([
//            currentLetterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            currentLetterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentLetterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            currentLetterImageView.widthAnchor.constraint(equalToConstant: size.width),
            currentLetterImageView.heightAnchor.constraint(equalToConstant: size.height)
        ])
        
        
        var row = getRow()
        
        currentLetterImageView.image = row[currentIndex].1
//        currentLetterLabel.text = row[currentIndex].first
        
        print("&&&")

        speechRecognizer2?.delegate = self

              SFSpeechRecognizer.requestAuthorization { authStatus in
                  // Проверка статуса авторизации и выполнение необходимых действий
                  if authStatus == .authorized {
                      do {
                          try self.startRecording2()
                      } catch {
                          print("Ошибка при начале записи: \(error)")
                      }
                  }
              }
        print("&&&")

    }
     */
    
    func startTest() {
        print("&&&")
        nameLabel.removeFromSuperview()
//        view.backgroundColor = .red
        view.addSubview(currentLetterImageView)
//        currentLetterImageView.backgroundColor = .yellow
        var size = getLetterSize(row: currentRow)
        NSLayoutConstraint.activate([
//            currentLetterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            currentLetterImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentLetterImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            currentLetterImageView.widthAnchor.constraint(equalToConstant: size.width),
//            currentLetterImageView.heightAnchor.constraint(equalToConstant: size.height)
        ])
        
        
        var row = getRow()
        
        currentLetterImageView.image = row[currentIndex].1
//        currentLetterLabel.text = row[currentIndex].first
        
        print("&&&")

        speechRecognizer?.delegate = self

              SFSpeechRecognizer.requestAuthorization { authStatus in
                  // Проверка статуса авторизации и выполнение необходимых действий
                  if authStatus == .authorized {
                      do {
                          try self.startRecording()
                      } catch {
                          print("Ошибка при начале записи: \(error)")
                      }
                  }
              }
        print("&&&")

    }
    
    func moveNextLetter() {
        var row = getRow()
        
        currentLetterImageView.image = row[currentIndex].1
    }
    
    func startRecording() throws {
        print("DEBUG")
            if let recognitionTask = recognitionTask {
                recognitionTask.cancel()
                self.recognitionTask = nil
            }

            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .default, options: [])

            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
            let inputNode = audioEngine.inputNode
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create recognition request") }
        print("DEBUG")

            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                var isFinal = false

                if let result = result {
                    print("DEBUG REsULT \(result.bestTranscription.formattedString)")

                    
                    // Ваш код для обработки распознанного текста
                    print(result.bestTranscription.formattedString)
                    isFinal = result.isFinal
                    var string = ""
                    
                    if self.currentRow == 1 && self.currentIndex == 0 {
                        self.userGuess = result.bestTranscription.formattedString
                        self.checkIfCorrectGuess()
                    } else {
                        string = result.bestTranscription.formattedString
//                        self.recognizedString += result.bestTranscription.formattedString
                        if let range = string.range(of: self.recognizedString) {
                            string.removeSubrange(range)
                            print("SUBSTRING \(string)")
                        }
                        self.recognizedString += result.bestTranscription.formattedString
                        self.userGuess = string
                        self.checkIfCorrectGuess()
                    }
                   
                    
                    
                }
                

                if error != nil || isFinal {
                    print("DEBUG ERROR \(isFinal) \(error?.localizedDescription)")

                    self.audioEngine.stop()
                    inputNode.removeTap(onBus: 0)

                    self.recognitionRequest = nil
                    self.recognitionTask = nil
                }
            }

            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.recognitionRequest?.append(buffer)
            }

            audioEngine.prepare()
            try audioEngine.start()
        }
    
    /*
    func startRecording2() throws {
        print("DEBUG")
            if let recognitionTask = recognitionTask2 {
                recognitionTask.cancel()
                self.recognitionTask2 = nil
            }

            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .default, options: [])

            recognitionRequest2 = SFSpeechAudioBufferRecognitionRequest()
    
            let inputNode = audioEngine.inputNode
            guard let recognitionRequest = recognitionRequest2 else { fatalError("Unable to create recognition request") }
        print("DEBUG")

            recognitionTask2 = speechRecognizer2?.recognitionTask(with: recognitionRequest) { result, error in
                var isFinal = false

                if let result = result {
                    print("DEBUG REsULT")

                    
                    // Ваш код для обработки распознанного текста
                    print(result.bestTranscription.formattedString)
                    isFinal = result.isFinal
                    var string = ""
                    self.recognizedString += result.bestTranscription.formattedString
                    
                    string = result.bestTranscription.formattedString
                    
                    if let range = string.range(of: self.recognizedString) {
                        string.removeSubrange(range)
                    }
                    self.userGuess = string
                    self.checkIfCorrectGuess()
                    self.moveNextLetter()
                }
                

                if error != nil || isFinal {
                    print("DEBUG ERROR \(isFinal) \(error?.localizedDescription)")

                    self.audioEngine2.stop()
                    inputNode.removeTap(onBus: 0)

                    self.recognitionRequest2 = nil
                    self.recognitionTask2 = nil
                }
            }

            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                self.recognitionRequest2?.append(buffer)
            }

            audioEngine2.prepare()
            try audioEngine2.start()
        }
     */
    
    func updateImageSize() {
        switch currentRow {
        case 1:
            currentLetterImageView.frame.size = SizeAsset.row1Size
            
        case 2:
            currentLetterImageView.frame.size = SizeAsset.row2Size
            
        case 3:
            currentLetterImageView.frame.size = SizeAsset.row3Size
            
        case 4:
            currentLetterImageView.frame.size = SizeAsset.row4Size
            
        case 5:
            currentLetterImageView.frame.size = SizeAsset.row5Size
            
        case 6:
            currentLetterImageView.frame.size = SizeAsset.row6size
            
        case 7:
            currentLetterImageView.frame.size = SizeAsset.row7Size
            
        case 8:
            currentLetterImageView.frame.size = SizeAsset.row8Size
            
        case 9:
            currentLetterImageView.frame.size = SizeAsset.row9Size
            
        case 10:
            currentLetterImageView.frame.size = SizeAsset.row10Size
            
        case 11:
            currentLetterImageView.frame.size = SizeAsset.row11Size
            
        case 12:
            currentLetterImageView.frame.size = SizeAsset.row12Size
        default:
            currentLetterImageView.frame.size = SizeAsset.row12Size
        }
    }
    
    func checkIfCorrectGuess() -> Bool {
        var symbolIndex = 1
        var row = getRow()
        var symbol = ""
      
        symbol = row[currentIndex].0

        
        let regexPattern = "\\b[\(symbol.lowercased())\(symbol.uppercased())]\\b"
        print("CHECK \(symbol) guess:  \(userGuess)")

        if let range = userGuess.range(of: regexPattern, options: .regularExpression) {
            if currentIndex == row.count - 1 {
                currentIndex = 0
                if currentRow == 12 {
                    print("END LEFT CHECK")
                    endLeftCheck()
                    return true
                } else {
                    currentRow += 1
                    updateImageSize()
                    moveNextLetter()
                    print("SIZE \(currentLetterImageView.frame.width)")
                    return true
                }
            } else {
                currentIndex += 1
                moveNextLetter()
                return true
            }
            print("ОТВЕТ \(range.lowerBound)")

            return true
        } else {
            print("ОТВЕТ  НЕВЕРНО")
            if currentRow >= 1 && currentRow <= 2 {
                errorCapV1V2 += 1
                
                if currentIndex == row.count - 1 {
                    currentIndex = 0
                    currentRow += 1
//                    updateImageSize()
//                    currentLetterImageView.image = row[currentIndex].1
                } else {
                    currentIndex += 1
                }
                endLeftCheck()
                return false
            }
            
            if currentRow >= 3 && currentRow <= 6 {
                errorCapV3V6 += 1
                if errorCapV3V6 == 2 {
                    print("END LEFT CHECK")
                    endLeftCheck()
                    return false
                }
            }
            
            if currentRow >= 7 {
                errorCapV6V12 += 1
                if errorCapV6V12 == 3 {
                    print("END LEFT CHECK")
                    endLeftCheck()
                    return false
                }
            }
            return false
        }
    }
    
    func endLeftCheck() {
        currentLetterImageView.removeFromSuperview()
        hostingController.removeFromParent()
        leftEyeResultRow = currentRow
        currentRow = 1
        currentIndex = 0
        errorCapV1V2 = 0
        errorCapV3V6 = 0
        errorCapV6V12 = 0
        userGuess = ""
        recognizedString = ""
//        speechRecognizer.st
        stopRecording()

//        setupRightEye()
        endRightCheck()
    }
    func stopRecording() {
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
            recognitionRequest?.endAudio()
            recognitionTask?.cancel()
            recognitionRequest = nil
            recognitionTask = nil
        }
    
    func endRightCheck() {
        rightEyeResultRow = currentRow
        let resultViewController = SivcevResultViewController()
        resultViewController.userDistance = 5.0
        resultViewController.userLeftRow = leftEyeResultRow
        resultViewController.userRightRow = rightEyeResultRow
        self.navigationController?.pushViewController(resultViewController, animated: true)
    }
}
