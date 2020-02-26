//
//  ViewController.swift
//  ModuSubway
//
//  Created by 나미콘 on 2020/02/25.
//  Copyright © 2020 나미콘. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
//    var scrollView: UIScrollView!
//    var imageView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imageView: UIImageView!
    
    
    var pinchGesture = UIPinchGestureRecognizer()
    
    // 지하철 역 버튼 생성
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
        
        // 스크롤뷰 생성
//        let frameSize = view.bounds.size
//        scrollView = UIScrollView(frame: CGRect(origin: CGPoint.zero, size: frameSize))
//
//        let image = UIImage(named: "img_subway.png")
//        imageView = UIImageView(image: image)
        scrollView.contentSize = imageView.bounds.size
        
        // view에 뿌려주기
//        scrollView.addSubview(imageView)
//        view.addSubview(scrollView)
        
        // zoom scale
        scrollView.maximumZoomScale = 2.0
        scrollView.minimumZoomScale = 0.7
        
        scrollView.delegate = self
        
        // 더블탭 만들기
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(tapToZoom))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.numberOfTouchesRequired = 1
        
        
        // TODO : 벼튼 생성하고 위치 넣기
        // 탭했을 때 좌표 print
        
        
        
        // 이미지뷰 인터렉션 허용
        imageView.isUserInteractionEnabled = true
        scrollView.addGestureRecognizer(doubleTap)
        
    }

    @objc func tapToZoom() {
        
        // 더블탭 간단하게 구현
        if scrollView.zoomScale == CGFloat(0.7) {
            scrollView.setZoomScale(2.0, animated: true)
        } else {
            scrollView.setZoomScale(0.7, animated: true)
        }
    }
    
    // pinch gesture 줌인, 줌아웃
    @objc func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    // view가 나타나면 offset 이동
    override func viewDidAppear(_ animated: Bool) {
////        let xPoint = self.view.frame.size.width/2
////        let yPoint = self.view.frame.size.height/2
        
        // zoom scale 설정
        scrollView.setZoomScale(1.0, animated: true)
        // offset 임의대로 때려박음
        scrollView.setContentOffset(CGPoint(x: 450, y: 200), animated: true)
    }

}

