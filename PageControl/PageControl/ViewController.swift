//
//  ViewController.swift
//  PageControl
//
//  Created by 안수경 on 2022/01/14.
//

import UIKit


// group으로 묶었지만 파일명을 사용할 수 있다.!!!???
var images = ["cat_1.jpg", "cat_2.jpg", "cat_3.jpg", "cat_4.jpg", "cat_5.jpg", "cat_6.jpg", "cat_7.jpg", "cat_8.jpg", "cat_9.jpg"]

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.green
        pageControl.currentPageIndicatorTintColor = UIColor.red
        
        imgView.image = UIImage(named: images[0])
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    
}

