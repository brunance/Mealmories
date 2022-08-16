//
//  ViewController.swift
//  Challenge04LGBB
//
//  Created by Bruno França do Prado on 15/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    let spb = SegmentedProgressBar(numberOfSegments: 7, duration:100000000)
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        spb.frame = CGRect(x: 15, y: 50, width: view.frame.width - 30, height: 6)
        view.addSubview(spb)
        
        spb.startAnimation()
        spb.skip()
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    

}

