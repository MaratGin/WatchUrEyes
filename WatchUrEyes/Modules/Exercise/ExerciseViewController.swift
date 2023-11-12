//
//  ExerciseViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 12.11.2023.
//

import UIKit
import AVFoundation
import AVKit
import SwiftUI

class ExerciseViewController: UIViewController {

    var data = VideoAssets.relaxExercises
    var currentVideo = 0
    var exercise: ExerciseMethod = .relax
    var video = VideoAssets.relaxExercises[0].video
    var player = AVPlayerViewController()
    var exerciseDescription: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    lazy var hostingController: UIHostingController = {
        var timerView = TimerView(defaultTimeRemaining: 5, radius: 60)
        timerView.background(Color.white)
        timerView.onTimerFinish =  { [weak self] in
            self?.timerFinished()
        }
        let hostingController = UIHostingController(rootView: timerView)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        return hostingController
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        currentVideo = 0
        switch exercise {
        case .relax:
            data = VideoAssets.relaxExercises
        case .bliz:
            data = VideoAssets.blizExercises
        case .daln:
            data = VideoAssets.dalnExercises
        }
        player.player = video

    }
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DIDLOAD")
        view.backgroundColor = .white
        switch exercise {
        case .relax:
            data = VideoAssets.relaxExercises
        case .bliz:
            data = VideoAssets.blizExercises
        case .daln:
            data = VideoAssets.dalnExercises
        }
        
//        guard let path = Bundle.main.path(forResource: "daln3", ofType: "mp4") else {
//            print("error")
//            return
//        }
//
//        let videoURL = NSURL(fileURLWithPath: path)
//        let playerr = AVPlayer(url: videoURL as URL)
//        player.player = playerr
//
        
//       var initPalyer =  AVPlayer.init(playerItem: AVPlayerItem.init(url: URL(fileURLWithPath: "/Users/maratik/Desktop/SwiftProjects/WatchUrEyes/RPReplay_Final1654509953.MP4" )))
//        player.player = initPalyer
        
        
        player.player = video
        view.addSubview(exerciseDescription)
        view.addSubview(exerciseDescription)
        view.addSubview(player.view)
        player.view.backgroundColor = .clear

        
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            exerciseDescription.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            exerciseDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            exerciseDescription.widthAnchor.constraint(equalToConstant: view.frame.width),
            exerciseDescription.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        player.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            player.view.topAnchor.constraint(equalTo: exerciseDescription.topAnchor, constant: 20),
            player.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            player.view.heightAnchor.constraint(equalToConstant: 300),
            player.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0)

        ])
        
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: player.view.bottomAnchor, constant: 20),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.heightAnchor.constraint(equalToConstant: 200)
        ])
        
//        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying),
//                                                          name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
//                                               object: player.player)
        
        // Do any additional setup after loading the view.
        player.player?.play()

    }
    override func viewWillDisappear(_ animated: Bool) {
        player.player?.pause()
        currentVideo = 0
    }
    
    func timerFinished() {
        currentVideo += 1
        if currentVideo != data.count - 1 {
            player.player = data[currentVideo].video
            exerciseDescription.text = data[currentVideo].description
            player.player?.play()
        } else {
            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    @objc func playerDidFinishPlaying() {
        player.player?.seek(to: .zero)
        player.player?.play()
    }
    
    
    func createBlizExercise() {
        
    }
    
    func createRelaxExercise() {
        
        
    }
    
    func createDalnExercise() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
