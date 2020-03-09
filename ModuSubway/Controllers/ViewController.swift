//
//  ViewController.swift
//  ModuSubway
//
//  Created by 나미콘 on 2020/02/25.
//  Copyright © 2020 나미콘. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UIScrollViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var currentLocationButton: UIButton!
    
    // location manager
    var locationManager: CLLocationManager!
    
    // timer. 위치 5초마다 갱신 용도
    var sTimer: Timer?
    
    // pinch 제스처 객체 생성
    var pinchGesture = UIPinchGestureRecognizer()
    
    // TODO : 지하철 역 버튼 생성
    // 1호선
    // 2호선
    // 3호선
    // 4호선
    // 5호선
    // 6호선
    // 7호선
    // 8호선
    // 9호선
    // 인천 1호선
    // 인천 2호선
    // 인천국제공항철도
    // 용인경전철
    // 신분당선
    // 의정부경전철
    // 우이신설선
    // 김포도시철도
    // 경의.중앙선
    // 경춘선
    // 경강선
    // 서해선
    // 분당선
    let wangsimniBtn = UIButton()           // 왕십리
    let seoulForestBtn = UIButton()         // 서울숲
    let apgujeongRodeoBtn = UIButton()      // 압구정 로데오
    let gangnamGuOfficeBtn = UIButton()     // 강남구청
    let seonjeongneungBtn = UIButton()      // 선정릉
    let seolleungBtn = UIButton()           // 선릉
    let hantiBtn = UIButton()               // 한티
    let dogokBtn = UIButton()               // 도곡
    let guryongBtn = UIButton()             // 구룡
    let gaepodongBtn = UIButton()           // 개포동
    let daemosanBtn = UIButton()            // 대모산입구
    let suseoBtn = UIButton()               // 수서
    let bokjeongBtn = UIButton()               // 복정
    let gachonUnivBtn = UIButton()          // 가천대
    let taepyeongBtn = UIButton()           // 태평
    let moranBtn = UIButton()               // 모란
    let yatapBtn = UIButton()               // 야탑
    let imaeBtn = UIButton()                // 이매
    let seohyeonBtn = UIButton()            // 서현
    let sunaeBtn = UIButton()               // 수내
    let jeongjaBtn = UIButton()             // 정자
    let migeumBtn = UIButton()              // 미금
    let oriBtn = UIButton()                 // 오리
    let jukjeonBtn = UIButton()             // 죽전
    let bojeongBtn = UIButton()             // 보정
    let guseoungBtn = UIButton()            // 구성
    let singalBtn = UIButton()              // 신갈
    let giheungBtn = UIButton()             // 기흥
    let sanggalBtn = UIButton()             // 상갈
    let cheongmyeongBtn = UIButton()        // 청명
    let yeongtongBtn = UIButton()           // 영통
    let mangpoBtn = UIButton()              // 망포
    let maetanGwonseonBtn = UIButton()      // 메탄권선
    let suwonCityHallBtn = UIButton()       // 수원시청
    let maegyoBtn = UIButton()              // 매교
    let suwonBtn = UIButton()               // 수원
    
    // 버튼 클릭 횟수
    var clickBtn = 0
    
    // 출발, 도착역 설정
    var startStation = ""
    var endStation = ""
    
    // 스타트역의 tag 값을 가져온다
    var getStartStationTag = 0
    
    // 위도, 경도
    var latitude: CLLocationDistance?
    var longitude: CLLocationDistance?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imageView와 scrollView 사이즈 맞춤. 이거 안하면 확대/축소 안됨.
        scrollView.contentSize = imageView.bounds.size
        
        // zoom scale
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.8
        
        scrollView.delegate = self
        
        // zoom scale 설정
        scrollView.setZoomScale(1.5, animated: true)
        // offset 센터로 이동
        scrollView.setContentOffset(CGPoint(x: 900, y: 600), animated: true)
        
        // current location button 둥글게
        currentLocationButton.layer.cornerRadius = 0.5 * currentLocationButton.bounds.size.width

        
        // 더블탭 만들기
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapToZoom))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        
        // 이미지뷰 인터렉션 허용
        imageView.isUserInteractionEnabled = true
        scrollView.addGestureRecognizer(doubleTap)
        
        
        // TODO : 버튼 위치, 색상 //
        wangsimniBtn.frame = CGRect(x: 777, y: 366, width: 23, height: 23)
        wangsimniBtn.backgroundColor = UIColor.red
        wangsimniBtn.alpha = 0.5
        
        seoulForestBtn.frame = CGRect(x: 768, y: 460, width: 23, height: 23)
        seoulForestBtn.backgroundColor = UIColor.red
        seoulForestBtn.alpha = 0.5
        
        apgujeongRodeoBtn.frame = CGRect(x: 744, y: 520, width: 23, height: 23)
        apgujeongRodeoBtn.backgroundColor = .red
        apgujeongRodeoBtn.alpha = 0.5
        
        gangnamGuOfficeBtn.frame = CGRect(x: 739, y: 544, width: 23, height: 23)
        gangnamGuOfficeBtn.backgroundColor = .red
        gangnamGuOfficeBtn.alpha = 0.5
        
        seonjeongneungBtn.frame = CGRect(x: 738, y: 587, width: 23, height: 23)
        seonjeongneungBtn.backgroundColor = .red
        seonjeongneungBtn.alpha = 0.5
        
        seolleungBtn.frame = CGRect(x: 725, y: 616, width: 23, height: 23)
        seolleungBtn.backgroundColor = UIColor.red
        seolleungBtn.alpha = 0.5
        
        hantiBtn.frame = CGRect(x: 725, y: 639, width: 23, height: 23)
        hantiBtn.backgroundColor = UIColor.red
        hantiBtn.alpha = 0.5
        
        dogokBtn.frame = CGRect(x: 725, y: 662, width: 23, height: 23)
        dogokBtn.backgroundColor = UIColor.red
        dogokBtn.alpha = 0.5
        
        guryongBtn.frame = CGRect(x: 725, y: 687, width: 23, height: 23)
        guryongBtn.backgroundColor = UIColor.red
        guryongBtn.alpha = 0.5
        
        gaepodongBtn.frame = CGRect(x: 737, y: 708, width: 23, height: 23)
        gaepodongBtn.backgroundColor = UIColor.red
        gaepodongBtn.alpha = 0.5
        
        daemosanBtn.frame = CGRect(x: 780, y: 707, width: 23, height: 23)
        daemosanBtn.backgroundColor = UIColor.red
        daemosanBtn.alpha = 0.5
        
        suseoBtn.frame = CGRect(x: 824, y: 707, width: 23, height: 23)
        suseoBtn.backgroundColor = UIColor.red
        suseoBtn.alpha = 0.5
        
        bokjeongBtn.frame = CGRect(x: 859, y: 707, width: 23, height: 23)
        bokjeongBtn.backgroundColor = UIColor.red
        bokjeongBtn.alpha = 0.5
        
        gachonUnivBtn.frame = CGRect(x: 887, y: 749, width: 23, height: 23)
        gachonUnivBtn.backgroundColor = UIColor.red
        gachonUnivBtn.alpha = 0.5
        
        taepyeongBtn.frame = CGRect(x: 926, y: 748, width: 23, height: 23)
        taepyeongBtn.backgroundColor = UIColor.red
        taepyeongBtn.alpha = 0.5
        
        moranBtn.frame = CGRect(x: 962, y: 748, width: 23, height: 23)
        moranBtn.backgroundColor = UIColor.red
        moranBtn.alpha = 0.5
        
        yatapBtn.frame = CGRect(x: 988, y: 748, width: 20, height: 20)
        yatapBtn.backgroundColor = UIColor.red
        yatapBtn.alpha = 0.5
        
        imaeBtn.frame = CGRect(x: 988, y: 768, width: 20, height: 20)
        imaeBtn.backgroundColor = UIColor.red
        imaeBtn.alpha = 0.5
        
        seohyeonBtn.frame = CGRect(x: 988, y: 788, width: 20, height: 20)
        seohyeonBtn.backgroundColor = UIColor.red
        seohyeonBtn.alpha = 0.5
        
        sunaeBtn.frame = CGRect(x: 988, y: 808, width: 20, height: 20)
        sunaeBtn.backgroundColor = UIColor.red
        sunaeBtn.alpha = 0.5
        
        jeongjaBtn.frame = CGRect(x: 965, y: 802, width: 23, height: 23)
        jeongjaBtn.backgroundColor = UIColor.red
        jeongjaBtn.alpha = 0.5
        
        migeumBtn.frame = CGRect(x: 940, y: 802, width: 23, height: 23)
        migeumBtn.backgroundColor = UIColor.red
        migeumBtn.alpha = 0.5
        
        oriBtn.frame = CGRect(x: 913, y: 802, width: 23, height: 23)
        oriBtn.backgroundColor = UIColor.red
        oriBtn.alpha = 0.5
        
        jukjeonBtn.frame = CGRect(x: 886, y: 802, width: 23, height: 23)
        jukjeonBtn.backgroundColor = UIColor.red
        jukjeonBtn.alpha = 0.5
        
        bojeongBtn.frame = CGRect(x: 858, y: 803, width: 23, height: 23)
        bojeongBtn.backgroundColor = UIColor.red
        bojeongBtn.alpha = 0.5
        
        guseoungBtn.frame = CGRect(x: 836, y: 777, width: 23, height: 23)
        guseoungBtn.backgroundColor = UIColor.red
        guseoungBtn.alpha = 0.5
        
        singalBtn.frame = CGRect(x: 804, y: 762, width: 23, height: 23)
        singalBtn.backgroundColor = UIColor.red
        singalBtn.alpha = 0.5
        
        giheungBtn.frame = CGRect(x: 758, y: 763, width: 23, height: 23)
        giheungBtn.backgroundColor = UIColor.red
        giheungBtn.alpha = 0.5
        
        sanggalBtn.frame = CGRect(x: 718, y: 763, width: 23, height: 23)
        sanggalBtn.backgroundColor = UIColor.red
        sanggalBtn.alpha = 0.5
        
        cheongmyeongBtn.frame = CGRect(x: 679, y: 763, width: 23, height: 23)
        cheongmyeongBtn.backgroundColor = UIColor.red
        cheongmyeongBtn.alpha = 0.5
        
        yeongtongBtn.frame = CGRect(x: 640, y: 763, width: 23, height: 23)
        yeongtongBtn.backgroundColor = UIColor.red
        yeongtongBtn.alpha = 0.5
        
        mangpoBtn.frame = CGRect(x: 607, y: 763, width: 23, height: 23)
        mangpoBtn.backgroundColor = UIColor.red
        mangpoBtn.alpha = 0.5
        
        maetanGwonseonBtn.frame = CGRect(x: 569, y: 763, width: 23, height: 23)
        maetanGwonseonBtn.backgroundColor = UIColor.red
        maetanGwonseonBtn.alpha = 0.5
        
        suwonCityHallBtn.frame = CGRect(x: 530, y: 763, width: 23, height: 23)
        suwonCityHallBtn.backgroundColor = UIColor.red
        suwonCityHallBtn.alpha = 0.5
        
        maegyoBtn.frame = CGRect(x: 492, y: 763, width: 23, height: 23)
        maegyoBtn.backgroundColor = UIColor.red
        maegyoBtn.alpha = 0.5
        
        suwonBtn.frame = CGRect(x: 464, y: 792, width: 23, height: 23)
        suwonBtn.backgroundColor = UIColor.red
        suwonBtn.alpha = 0.5
        
        // TODO : 버튼 imageView에 추가 //
        imageView.addSubview(wangsimniBtn)
        imageView.addSubview(seoulForestBtn)
        imageView.addSubview(apgujeongRodeoBtn)
        imageView.addSubview(gangnamGuOfficeBtn)
        imageView.addSubview(seonjeongneungBtn)
        imageView.addSubview(seolleungBtn)
        imageView.addSubview(hantiBtn)
        imageView.addSubview(dogokBtn)
        imageView.addSubview(guryongBtn)
        imageView.addSubview(gaepodongBtn)
        imageView.addSubview(daemosanBtn)
        imageView.addSubview(suseoBtn)
        imageView.addSubview(bokjeongBtn)
        imageView.addSubview(gachonUnivBtn)
        imageView.addSubview(taepyeongBtn)
        imageView.addSubview(moranBtn)
        imageView.addSubview(yatapBtn)
        imageView.addSubview(imaeBtn)
        imageView.addSubview(seohyeonBtn)
        imageView.addSubview(sunaeBtn)
        imageView.addSubview(jeongjaBtn)
        imageView.addSubview(migeumBtn)
        imageView.addSubview(oriBtn)
        imageView.addSubview(jukjeonBtn)
        imageView.addSubview(bojeongBtn)
        imageView.addSubview(guseoungBtn)
        imageView.addSubview(singalBtn)
        imageView.addSubview(giheungBtn)
        imageView.addSubview(sanggalBtn)
        imageView.addSubview(cheongmyeongBtn)
        imageView.addSubview(yeongtongBtn)
        imageView.addSubview(mangpoBtn)
        imageView.addSubview(maetanGwonseonBtn)
        imageView.addSubview(suwonCityHallBtn)
        imageView.addSubview(maegyoBtn)
        imageView.addSubview(suwonBtn)
        
        // TODO : 버튼 기능 연결 //
        wangsimniBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        seoulForestBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        apgujeongRodeoBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        gangnamGuOfficeBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        seonjeongneungBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        seolleungBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        hantiBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        dogokBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        guryongBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        gaepodongBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        daemosanBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        suseoBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        bokjeongBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        gachonUnivBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        taepyeongBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        moranBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        yatapBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        imaeBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        seohyeonBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        sunaeBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        jeongjaBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        migeumBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        oriBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        jukjeonBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        bojeongBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        guseoungBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        singalBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        giheungBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        sanggalBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        cheongmyeongBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        yeongtongBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        mangpoBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        maetanGwonseonBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        suwonCityHallBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        maegyoBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        suwonBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        
        // TODO : 역 이름 설정. alert에 text 넘기기 위한 용도 //
        wangsimniBtn.titleLabel?.text = "왕십리"
        seoulForestBtn.titleLabel?.text = "서울숲"
        apgujeongRodeoBtn.titleLabel?.text = "압구정로데오"
        gangnamGuOfficeBtn.titleLabel?.text = "강남구청"
        seonjeongneungBtn.titleLabel?.text = "선정릉"
        seolleungBtn.titleLabel?.text = "선릉"
        hantiBtn.titleLabel?.text = "한티"
        dogokBtn.titleLabel?.text = "도곡"
        guryongBtn.titleLabel?.text = "구룡"
        gaepodongBtn.titleLabel?.text = "개포동"
        daemosanBtn.titleLabel?.text = "대모산입구"
        suseoBtn.titleLabel?.text = "수서"
        bokjeongBtn.titleLabel?.text = "복정"
        gachonUnivBtn.titleLabel?.text = "가천대"
        taepyeongBtn.titleLabel?.text = "태평"
        moranBtn.titleLabel?.text = "모란"
        yatapBtn.titleLabel?.text = "야탑"
        imaeBtn.titleLabel?.text = "이매"
        seohyeonBtn.titleLabel?.text = "서현"
        sunaeBtn.titleLabel?.text = "수내"
        jeongjaBtn.titleLabel?.text = "정자"
        migeumBtn.titleLabel?.text = "미금"
        oriBtn.titleLabel?.text = "오리"
        jukjeonBtn.titleLabel?.text = "죽전"
        bojeongBtn.titleLabel?.text = "보정"
        guseoungBtn.titleLabel?.text = "구성"
        singalBtn.titleLabel?.text = "신갈"
        giheungBtn.titleLabel?.text = "기흥"
        sanggalBtn.titleLabel?.text = "상갈"
        cheongmyeongBtn.titleLabel?.text = "청명"
        yeongtongBtn.titleLabel?.text = "영통"
        mangpoBtn.titleLabel?.text = "망포"
        maetanGwonseonBtn.titleLabel?.text = "메탄권선"
        suwonCityHallBtn.titleLabel?.text = "수원시청"
        maegyoBtn.titleLabel?.text = "매교"
        suwonBtn.titleLabel?.text = "수원"
        
    }
    
    // TODO : 역 버튼 기능
    @objc func btnAction(_ sender: UIButton) {
        
        if clickBtn == 0 {
            // startStation에 출발역 넣기
            startStation = String(sender.titleLabel!.text!)
            
            // start alert
            let popAlert = UIAlertController(title: "출발역은", message: "\(sender.titleLabel!.text!) 입니다", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                // ok 버튼 누르면 clickBtn 카운트 +1
                self.clickBtn += 1
            }
            let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
            
            popAlert.addAction(cancelAction)
            popAlert.addAction(okAction)        // ok 버튼을 우측으로 나오게
            present(popAlert, animated: true, completion: nil)
            
            // TODO : 버튼 백그라운드 색상 변경
        } else {
            // arrivalStation에 도착역 넣기
            endStation = String(sender.titleLabel!.text!)
            
            // 출발역과 도착역이 다르면 alert 띄우기
            if startStation == endStation {
                
            } else {
                // arrival alert
                let popAlert = UIAlertController(title: "도착역은", message: "\(sender.titleLabel!.text!) 입니다", preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "확인", style: .default) { (action) in
                    // clickBtn 카운트 초기화
                    self.clickBtn = 0
                    
                    // detail 화면 modal
                    self.performSegue(withIdentifier: "goToDetail", sender: self)
                    
                }
                let cancelAction = UIAlertAction(title: "취소", style: .destructive, handler: nil)
                
                popAlert.addAction(cancelAction)
                popAlert.addAction(okAction)
                present(popAlert, animated: true, completion: nil)
                
                // TODO : 버튼 백그라운드 색상 변경
                
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetail" {
            let destinationVC = segue.destination as! DetailViewController
            destinationVC.startLabel = startStation
            destinationVC.endLabel = endStation
        }
    }
    
    // current button 누르면
    @IBAction func currentButtonPressed(_ sender: UIButton) {
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
        
        let gpsAlert = UIAlertController(title: "현재 위치", message: "위도: \(latitude!)\n경도: \(longitude!)", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        gpsAlert.addAction(okAction)
        present(gpsAlert, animated: true, completion: nil)
    }
    
    // 더블탭 줌인, 줌아웃
    @objc func tapToZoom() {
        // 더블탭 간단하게 구현
        if scrollView.zoomScale == CGFloat(0.8) {
            scrollView.setZoomScale(2.0, animated: true)
        } else {
            scrollView.setZoomScale(0.8, animated: true)
        }
    }
    
    // pinch gesture 줌인, 줌아웃
    @objc func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    //앱의 위치 추적 허가 상태가 변경되면 이 메서드를 호출해서 알려준다.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            print("항상 허용!")
        }
    }
    
}

