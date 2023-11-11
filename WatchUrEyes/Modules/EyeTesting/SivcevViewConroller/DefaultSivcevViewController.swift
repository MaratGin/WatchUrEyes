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
    private var currentRow = 0
    private var currentIndex = 0
    
    private var errorCapV1V2 = 0
    private var errorCapV3V6 = 0
    private var errorCapV6V12 = 0
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ru-RU")) // Выберите нужную локаль
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    
    fileprivate let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .blue
        return iv
    }()
    
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 100, weight: .heavy)
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
    
    var currentLetterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 248, weight: .heavy)
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLeftEye()
    }
    
    
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
    
    func startTest() {
        nameLabel.removeFromSuperview()
        view.backgroundColor = .red
        view.addSubview(currentLetterLabel)
        currentLetterLabel.backgroundColor = .yellow
        NSLayoutConstraint.activate([
            currentLetterLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            currentLetterLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            currentLetterLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            currentLetterLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        var row = [""]
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
        
        currentLetterLabel.text = row[currentIndex]
        
        
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
    }
    
    func moveNextLetter() {
        var row = [""]
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
        
        currentLetterLabel.text = row[currentIndex]
    }
    
    func startRecording() throws {
            if let recognitionTask = recognitionTask {
                recognitionTask.cancel()
                self.recognitionTask = nil
            }

            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.record, mode: .default, options: [])

            recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
            let inputNode = audioEngine.inputNode
            guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create recognition request") }

            recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { result, error in
                var isFinal = false

                if let result = result {
                    // Ваш код для обработки распознанного текста
                    print(result.bestTranscription.formattedString)
                    isFinal = result.isFinal
                    var string = ""
                    string = result.bestTranscription.formattedString
                    
                    if let range = string.range(of: self.recognizedString) {
                        string.removeSubrange(range)
                    }
                    self.userGuess = string
                    self.checkIfCorrectGuess()
                    self.moveNextLetter()
                }
                

                if error != nil || isFinal {
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
    
    func checkIfCorrectGuess() -> Bool {
        var symbolIndex = 1
        var row = [""]
        var symbol = ""
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
        symbol = row[currentIndex]

        
        let regexPattern = "\\[\(symbol.lowercased())\(symbol.uppercased())]\\b"

        if let range = userGuess.range(of: regexPattern, options: .regularExpression) {
            if currentIndex == row.count - 1 {
                currentIndex = 0
                if currentRow == 12 {
                    endCheck()
                } else {
                    currentRow += 1
                }
            } else {
                currentIndex += 1
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
                    currentLetterLabel.text = row[currentIndex]
                } else {
                    currentIndex += 1
                }
                endCheck()
            }
            
            if currentRow >= 3 && currentRow <= 6 {
                errorCapV3V6 += 1
                endCheck()
            }
            
            if currentRow >= 7 {
                errorCapV6V12 += 1
                if errorCapV6V12 == 2 {
                    endCheck()
                }
            }
            return false
        }
    }
    
    func endCheck() {
        
    }
    
}
