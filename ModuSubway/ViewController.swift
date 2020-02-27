//
//  ViewController.swift
//  ModuSubway
//
//  Created by 나미콘 on 2020/02/25.
//  Copyright © 2020 나미콘. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
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
    // 경강선
    // 서해선
    
    // 버튼 클릭 횟수
    var clickBtn = 0
    
    // 출발, 도착역 설정
    var startStation = ""
    var arrivalStation = ""
    
    // 스타트역의 tag 값을 가져온다
    var getStartStationTag = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // imageView와 scrollView 사이즈 맞춤. 이거 안하면 확대/축소 안됨.
        scrollView.contentSize = imageView.bounds.size
        
        // zoom scale
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.8
        
        scrollView.delegate = self
        
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
        
        seolleungBtn.frame = CGRect(x: 725, y: 616, width: 23, height: 23)
        seolleungBtn.backgroundColor = UIColor.red
        seolleungBtn.alpha = 0.5
        
        suwonBtn.frame = CGRect(x: 464, y: 792, width: 23, height: 23)
        suwonBtn.backgroundColor = UIColor.red
        suwonBtn.alpha = 0.5
        
        // TODO : 버튼 imageView에 추가 //
        imageView.addSubview(wangsimniBtn)
        imageView.addSubview(seoulForestBtn)
        imageView.addSubview(seolleungBtn)
        imageView.addSubview(suwonBtn)
        
        // TODO : 버튼 기능 연결 //
        wangsimniBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        seoulForestBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        seolleungBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        suwonBtn.addTarget(self, action: #selector(btnAction(_:)), for: .touchUpInside)
        
        // TODO : 역 이름 설정. alert에 text 넘기기 위한 용도 //
        wangsimniBtn.titleLabel?.text = "왕십리"
        seoulForestBtn.titleLabel?.text = "서울숲"
        seolleungBtn.titleLabel?.text = "선릉"
        suwonBtn.titleLabel?.text = "수원"
        
    }
    
    // TODO : 역 버튼 기능
    @objc func btnAction(_ sender: UIButton) {
        print("버튼 눌림")
        
        let popAlert = UIAlertController(title: "출발역은", message: "\(sender.titleLabel!.text!) 입니다", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        popAlert.addAction(okAction)
        self.present(popAlert, animated: true, completion: nil)
    }
    
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
    
    // view가 나타나면 offset 이동
    override func viewDidAppear(_ animated: Bool) {
        // zoom scale 설정
        scrollView.setZoomScale(1.0, animated: true)
        // offset 임의대로 때려박음
        scrollView.setContentOffset(CGPoint(x: 450, y: 200), animated: true)
    }

}

