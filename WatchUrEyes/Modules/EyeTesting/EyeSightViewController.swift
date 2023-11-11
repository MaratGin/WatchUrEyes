//
//  ViewController.swift
//  WatchUrEyes
//
//  Created by Marat Giniyatov on 21.03.2023.
//

import UIKit
import Speech
import SceneKit
import ARKit


class EyeSightViewController: UIViewController {

    var sceneView: ARSCNView = {
        var scene = ARSCNView()
        return scene
    }()
    
    var transparentView: UIView = {
        let view = UIView()
        return view
    }()
    
    var hand = SCNNode()
    
    
    var faceNode = SCNNode()
    var leftEye = SCNNode()
    var rightEye = SCNNode()

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(sceneView)

        //1. Задаём конфигурацию для Face Tracking'а
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.delegate = self
        sceneView.showsStatistics = true
        
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        sceneView.contraintARSCNToSuperView()


        setupEyeNode()
    }

    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated) }

    // MARK: - Eye Node Setup
    
    /// Creates To SCNSpheres To Loosely Represent The Eyes
    ///
    func setupEyeNode(){
        let eyeGeometry2 = SCNSphere(radius: 0.005)
//        eyeGeometry2.materials.first?.diffuse

        //1. Создание сферы, которая будет крепиться к ноде глаза
        let eyeGeometry = SCNSphere(radius: 0.005)
        
        eyeGeometry.materials.first?.diffuse.contents = UIColor.blue
        eyeGeometry.materials.first?.transparency = 1

        //2. Создаём ноду, к которой прикрепим сферу
        let node = SCNNode()
        node.geometry = eyeGeometry
        node.eulerAngles.x = -.pi
        node.position.z = 0.1

        //3. Создаём ноды соответственно для левого и правого глаза
        leftEye = node.clone()
        rightEye = node.clone()
    }
}

// MARK: - SCNVector3 Extensions

extension SCNVector3 {

    ///Получение длины вектора
    func length() -> Float { return sqrtf(x * x + y * y + z * z) }

    ///Вычитание  двух SCNVector3's
    static func - (l: SCNVector3, r: SCNVector3) -> SCNVector3 { return SCNVector3Make(l.x - r.x, l.y - r.y, l.z - r.z) }
}

// MARK: - ARSCNViewDelegate

extension EyeSightViewController: ARSCNViewDelegate{

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {

        //Добавляем ноду лица и ноды глаз
        faceNode = node
        faceNode.addChildNode(leftEye)
        faceNode.addChildNode(rightEye)
        faceNode.transform = node.transform

        //Считаем расстояние от глаз до камеры
        trackDistance()
    }

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {

        faceNode.transform = node.transform

        //ARFaceAnchor сам находит лицо в кадре, проверяем, есть ли оно
        guard let faceAnchor = anchor as? ARFaceAnchor else { return }


        //Подгоняем матрицы нахождения позиции глаз полученных с камеры к нодам глаз
        leftEye.simdTransform = faceAnchor.leftEyeTransform
        rightEye.simdTransform = faceAnchor.rightEyeTransform

        // Расстояние от глаз до камеры
        trackDistance()
    }


    // Расстояние от глаз до камеры
    func trackDistance(){

        DispatchQueue.main.async {

            // Получаем значения координат каждого глаза относительно общих координат мира и вычитаем координаты камеры относительно мира, чтобы получить вектор от камеры до глаза
            let leftEyeDistanceFromCamera = self.leftEye.worldPosition - SCNVector3Zero
            let rightEyeDistanceFromCamera = self.rightEye.worldPosition - SCNVector3Zero

            // Считаем среднее значение, полученное из длин каждого вектора
            let averageDistance = (leftEyeDistanceFromCamera.length() + rightEyeDistanceFromCamera.length()) / 2
            
            // Подгоняем под сантиметры
            let averageDistanceCM = (Int(round(averageDistance * 100)))
            if averageDistanceCM >= 220 {
                print("Approximate Distance Of Face From Camera = \(averageDistanceCM)")

            }
        }
    }
}

extension ARSCNView {

    // Констрейнты для сцены
    func contraintARSCNToSuperView() {
        self.translatesAutoresizingMaskIntoConstraints = false

        if let superView = self.superview {
            self.topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
            self.leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
            self.trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
            self.bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
        }
    }
}
