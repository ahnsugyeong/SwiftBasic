//
//  ViewController.swift
//  Map
//
//  Created by 안수경 on 2022/01/13.
//

import UIKit
import MapKit


class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var lblLocationInfo1: UILabel!
    @IBOutlet var lblLocationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblLocationInfo1.text = ""
        lblLocationInfo2.text = ""
        
        locationManager.delegate = self
        
        //정확도를 최고로 설정
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        //위치 데이터를 추적하기 위해 사용자에게 승인을 요청
        locationManager.requestWhenInUseAuthorization()
        
        //위치 업데이트를 시작
        locationManager.startUpdatingLocation()
        
        //위치 보기 값을 true로 설정
        myMap.showsUserLocation = true
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double) -> CLLocationCoordinate2D {
        //매개변수: 위도값, 경도값
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        //매개변수: 범위 값
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        
        return pLocation
    }

    //핀 설치!!
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span :Double, title strTitle: String, subtitle strSubtitle:String){
        let annotation = MKPointAnnotation()
        annotation.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotation.title = strTitle
        annotation.subtitle = strSubtitle
        myMap.addAnnotation(annotation)
        
    }
    
    
    //위치가 업데이트되었을 때 지도에 위치를 나타내기 위한 함수
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //마지막 위치 값 찾아내기
        let pLocation = locations.last
        
        //마지막 위치의 위도와 경도 값으로 함수 호출.
        //delta -> 지도의 크기. 값이 작을수록 확대되는 효과
        //0.01 -> 1의 값보다 지도를 100배 확대.
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
            (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address:String = country!
            if pm!.locality != nil{
                address += " "
                address += pm!.locality!
            }
            if pm!.thoroughfare != nil{
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.lblLocationInfo1.text = "현재 위치"
            self.lblLocationInfo2.text = address
            
        })
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            // 현재 위치 표시
            self.lblLocationInfo1.text = ""
            self.lblLocationInfo2.text = ""
            locationManager.startUpdatingLocation()
            
        } else if sender.selectedSegmentIndex == 1{
            // 세종대학교 표시
            setAnnotation(latitudeValue: 37.55278817724639, longitudeValue: 127.0736997203731, delta: 0.01, title: "세종대학교", subtitle: "서울특별시 광진구 능동로 209")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "세종대학교"
            
        } else if sender.selectedSegmentIndex == 2{
            // 서울집 표시
            setAnnotation(latitudeValue: 37.5381077356665, longitudeValue: 127.06880175413697, delta: 0.01, title: "서울집", subtitle: "서울특별시 광진구 자양동 3-7")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "서울집"
        } else if sender.selectedSegmentIndex == 3{
            // 광주집 표시
            setAnnotation(latitudeValue: 35.142924307184146, longitudeValue: 126.85470036865856, delta: 0.01, title: "광주집", subtitle: "광주광역시 서구 금호운천길83")
            self.lblLocationInfo1.text = "보고 계신 위치"
            self.lblLocationInfo2.text = "광주집"
        }
    }
    
}

