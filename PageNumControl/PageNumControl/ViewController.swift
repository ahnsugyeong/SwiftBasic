//
//  ViewController.swift
//  PageNumControl
//
//  Created by 안수경 on 2022/01/14.
//

import UIKit


class ViewController: UIViewController {
    @IBOutlet var lblNum: UILabel!
    
    @IBOutlet var pageControl: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        lblNum.text = "1"
        pageControl.currentPage = 0
        pageControl.numberOfPages = 10
        pageControl.currentPageIndicatorTintColor = UIColor.gray
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        
    }

    @IBAction func pageChange(_ sender: UIPageControl) {
        lblNum.text = String(pageControl.currentPage+1)
        
    }
    
}

