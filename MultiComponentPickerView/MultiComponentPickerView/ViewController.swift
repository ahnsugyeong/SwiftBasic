//
//  ViewController.swift
//  PickerView
//
//  Created by 안수경 on 2022/01/10.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    let MAX_ARRAY_NUM = 9
    let PICKER_VIEW_COLUMN = 2
    var imageArray = [UIImage?]()
    // ? 왜 붙이지?
    
    var imageFileName = [ "cat_1.jpg","cat_2.jpg","cat_3.jpg","cat_4.jpg","cat_5.jpg","cat_6.jpg","cat_7.jpg","cat_8.jpg","cat_9.jpg"]
    
    
    @IBOutlet var pickerImage1: UIPickerView!
    @IBOutlet var pickerImage2: UIPickerView!
    @IBOutlet var lblImageFileName: UILabel!
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        for i in 0 ..< MAX_ARRAY_NUM {
            let image = UIImage(named: imageFileName[i])
            imageArray.append(image)
        }
        
        lblImageFileName.text = imageFileName[0]
        imageView.image = imageArray[0]
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return PICKER_VIEW_COLUMN
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return imageFileName.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return imageFileName[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lblImageFileName.text = imageFileName[row]
        imageView.image = imageArray[row]
    }
}
