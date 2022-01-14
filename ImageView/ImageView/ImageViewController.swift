//
//  ViewController.swift
//  ImageView
//
//  Created by 안수경 on 2022/01/09.
//

import UIKit

class ImageViewController: UIViewController {
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    // ? : 옵셔널(Optionals) -> 어떤 값이 존재하지 않는다는 것을 나타낼 때 사용. (nil)
    // 옵셔널 변수에 값이 할당되면 -> '옵셔널에 래핑(wrapped)되었다'
    // !를 사용하여 강제 언래핑(force unwrapping)하여 값에 접근
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        // 내가 만든 뷰를 불러왔을 때 호출되는 함수.
        // 뷰가 불려진 후 실행하고자 하는 기능이 필요할 때 이 안에 코드를 입력.
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgOn = UIImage(named: "lamp_on.png")
        imgOff = UIImage(named: "lamp_off.png")
        
        imgView.image = imgOn
    }

    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale:CGFloat = 2.0
        var newWidth:CGFloat, newHeight:CGFloat
        
        if(isZoom){     // true
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            btnResize.setTitle("확대", for: .normal)
        }
        else {      //false
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            btnResize.setTitle("축소", for: .normal)
        }
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
    }
    
    @IBAction func switchImageOnOff(_ sender: UISwitch) {
        if (sender.isOn){
            imgView.image = imgOn
        }
        else {
            imgView.image = imgOff
        }
        
    }
    
}

