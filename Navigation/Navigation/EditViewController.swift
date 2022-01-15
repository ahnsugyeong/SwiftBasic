//
//  EditViewController.swift
//  Navigation
//
//  Created by 안수경 on 2022/01/15.
//

import UIKit

//프로토콜이란? 특정 개체가 갖추어야 할 기능이나 속성에 대한 설계도.
//실질적으로 아무런 내용이 없지만, 단순한 선언 형태만을 갖는다.
//실질적인 내용은 이 프로토콜을 이용하는 객체에서 정의한다.
//추상클래스랑 비슷한 개념인가?

protocol EditDelegate{
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool)
}

class EditViewController: UIViewController {
    var textWayValue: String = ""
    var textMessage:String = ""
    var delegate : EditDelegate?
    var isOn = false
    var isZoom = false
    
    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var swIsOn: UISwitch!
    @IBOutlet var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swIsOn.isOn = isOn
        
        if isZoom{
            btnZoom.setTitle("축소", for: .normal)
        }
        else{
            btnZoom.setTitle("확대", for: .normal)
        }
       
    }
    
    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil{
            //메인화면의 didMessageEditDone함수 실행.
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
        
        //메인화면으로 화면 전환
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn{
            isOn = true
        }
        else{
            isOn = false
        }
    }
    
    //초기: false("확대")
    @IBAction func btnImageZoom(_ sender: UIButton) {
        if isZoom{
            btnZoom.setTitle("확대", for: .normal)
            isZoom = false
        }
        else{
            //현재 상태가 false(축소된 상태)인데 클릭을 하면
            btnZoom.setTitle("축소", for: .normal)
            isZoom = true
        }
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
