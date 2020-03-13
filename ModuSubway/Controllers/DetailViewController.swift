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
    
    // 위도, 경도
    var latitude: CLLocationDistance?
    var longitude: CLLocationDistance?
    
    // 출발역, 도착역 label
    var startLabel = ""
    var endLabel = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // label 테두리 drawing
        startStationLabel.layer.borderWidth = 5
        startStationLabel.layer.borderColor = UIColor.lightGray.cgColor
        startStationLabel.layer.backgroundColor = UIColor.white.cgColor
        startStationLabel.textColor = UIColor.black
        startStationLabel.layer.cornerRadius = 0.5 * startStationLabel.bounds.width
        
        endStationLabel.layer.borderWidth = 5
        endStationLabel.layer.borderColor = UIColor.lightGray.cgColor
        endStationLabel.layer.backgroundColor = UIColor.white.cgColor
        endStationLabel.textColor = UIColor.black
        endStationLabel.layer.cornerRadius = 0.5 * endStationLabel.bounds.width
        
        // 출발역, 도착역 정보 받아와서 표시
        startStationLabel.text = startLabel
        endStationLabel.text = endLabel

    }
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        // appDelegate
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        // 타이머가 nil이 아니면(있으면) 알림
        guard appDelegate.timer == nil else {
            // alert
            let popAlert = UIAlertController(title: "알림", message: "현재 운행중입니다!\n운행 취소하시려면 출발버튼 하단 취소버튼을 눌러주세요^^", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            popAlert.addAction(okAction)
            present(popAlert, animated: true, completion: nil)
            return
        }
        // 타이머 시작
        appDelegate.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        
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
        
        // 닫기
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        
        // 타이머 해제
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.timer?.invalidate()
        appDelegate.timer = nil
        
        // 닫기
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func timerCallback() {
        print(latitude!, longitude!)
    }
    
}
