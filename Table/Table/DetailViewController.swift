//
//  DetailViewController.swift
//  Table
//
//  Created by 안수경 on 2022/01/15.
//

import UIKit

class DetailViewController: UIViewController {
    var receiveItem = ""

    @IBOutlet var lblItem: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblItem.text = receiveItem
    }
    
    //main에서 변수를 받기 위한 함수
    func receiveItem(_ item: String){
        receiveItem = item
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
