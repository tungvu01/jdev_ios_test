//
//  BaseViewController.swift
//  JDevTask
//
//  Created by Tung Vu on 02/12/21.
//  Copyright © 2020 news. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {
    
    
    var hud: MBProgressHUD = {
        let progress = MBProgressHUD()
        progress.mode = MBProgressHUDMode.indeterminate
        progress.label.text = ""
        progress.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return progress
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

