//
//  ViewController.swift
//  ImageViewer
//
//  Created by 안수경 on 2022/01/09.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageViewer: UIImageView!
    var index:Int = 1
    var indexString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indexString = "cat_"+String(index)+".jpg"
        imageViewer.image = UIImage(named: indexString!)
    }

    @IBAction func prevButton(_ sender: UIButton) {
        index-=1;
        if(index == 0) {
            index = 9;
        }
        indexString = "cat_"+String(index)+".jpg"
        imageViewer.image = UIImage(named: indexString!)
        
    }
    
    @IBAction func nextButton(_ sender: UIButton) {
        index+=1;
        if(index == 10) {
            index = 1;
        }
        indexString = "cat_"+String(index)+".jpg"
        imageViewer.image = UIImage(named: indexString!)
    }
}

