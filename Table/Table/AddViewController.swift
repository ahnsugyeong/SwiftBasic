//
//  AddViewController.swift
//  Table
//
//  Created by 안수경 on 2022/01/15.
//

import UIKit

class AddViewController: UIViewController {
    @IBOutlet var tfAddItem: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
        items.append(tfAddItem.text!)
        //image에 clock 이미지 추가
        itemsImageFile.append("clock.png")
        tfAddItem.text = ""
        // tableView로 돌아가기
        _ = navigationController?.popViewController(animated: true)
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
