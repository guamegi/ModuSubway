//
//  DetailViewController.swift
//  ModuSubway
//
//  Created by 나미콘 on 2020/03/10.
//  Copyright © 2020 나미콘. All rights reserved.
//

import UIKit
import CoreLocation

class DetailViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var startStationLabel: UILabel!
    @IBOutlet weak var endStationLabel: UILabel!
    
    var locationManager: CLLocationManager!
    var sTimer: Timer?
    
    // 위도, 경도
    var latitude: CLLocationDistance?
    var longitude: CLLocationDistance?
    
    var startLabel = ""
    var endLabel = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // label 테두리 
        startStationLabel.layer.borderWidth = 3
        startStationLabel.layer.borderColor = UIColor.red.cgColor
        startStationLabel.layer.cornerRadius = 0.5 * startStationLabel.bounds.width
        
        endStationLabel.layer.borderWidth = 3
        endStationLabel.layer.borderColor = UIColor.red.cgColor
        endStationLabel.layer.cornerRadius = 0.5 * endStationLabel.bounds.width
        
        startStationLabel.text = startLabel
        endStationLabel.text = endLabel

    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        // location test start// 출발,도착역 설정후 start 버튼 투르면 시작하게끔.
        locationManager = CLLocationManager()
        locationManager.delegate = self
        // 백그라운드 일때도 추적 권한 요청
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 업데이트
        locationManager.startUpdatingLocation()
        locationManager.allowsBackgroundLocationUpdates = true
        // 위도, 경도 가져오기
        let coor = locationManager.location?.coordinate
        latitude = coor?.latitude
        longitude = coor?.longitude
        
        print(latitude!, longitude!)
        
        sTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        // location test end //
        
        // 닫기
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // timer callback
    @objc func timerCallback() {
        print(latitude!, longitude!)
    }
    
}
