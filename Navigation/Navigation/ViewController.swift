//
//  ViewController.swift
//  Navigation
//
//  Created by 안수경 on 2022/01/15.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    
    let imgOn = UIImage(named: "lamp_on.png")
    let imgOff = UIImage(named: "lamp_off.png")
    
    var isOn = true
    var isZoom = false
    
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = imgOn
    }
    
    
    // 해당 세그웨이가 해당 뷰컨트롤러로 전환되기 직전에 호출되는 함수이며 데이터 전달을 위해 사용된다.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //세그웨이의 도착 컨트롤러.
        let editViewController = segue.destination as! EditViewController
        
        // 메인화면 -> 수정화면 넘어갈 때 문자열 전달
        
        if segue.identifier == "editButton"{
            // 버튼을 클릭한 경우
            editViewController.textWayValue = "segue: use button"
            
        } else if segue.identifier == "editBarButton"{
            // 바 버튼을 클릭한 경우
            editViewController.textWayValue = "segue: use Bar button"
        }
        
        
        //메인화면의 text를 수정화면의 textMessage변수로 전달.
        editViewController.textMessage = txMessage.text!
        
        //메인화면의 전구 on/off 상태를 수정화면의 isOn 변수로 넘겨줌
        editViewController.isOn = isOn
        
        //메인화면의 전구 zoom 상태를 수정화면의 isZoom 변수로 넘겨줌
        editViewController.isZoom = isZoom
        
        
        
        //수정화면의 delegate에 self(메인화면)를 넘겨줌
        editViewController.delegate = self
        
    }
    
    //수정화면에서 넘어온 text를 메인화면의 textfield에 적용
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }
    //수정화면에서 넘어온 on/off 상태를 메인화면의 image와 isOn 변수에 적용
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn{
            imgView.image = imgOn
            self.isOn = true
        }
        else{
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        let scale: CGFloat = 2.0
        var newWidth: CGFloat, newHeight: CGFloat
        
        if isZoom != self.isZoom {  //이미 확대됐는데 확대버튼 누르거나, 축소됐는데 축소버튼 누르는 경우 제외
            if isZoom {
                newWidth = imgView.frame.width*scale
                newHeight = imgView.frame.height*scale
                self.isZoom = true
            }
            else{
                newWidth = imgView.frame.width/scale
                newHeight = imgView.frame.height/scale
                self.isZoom = false
            }
            imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        }
    }
    
}

