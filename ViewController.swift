//
//  ViewController.swift
//  KNImageButton
//
//  Created by Nguyen Khoi Nguyen on 12/21/16.
//  Copyright © 2016 CANGroup. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let customButton = KNImageButton(frame: CGRect(x: 10, y: 100, width: 365, height: 80))
//        customButton.backgroundColor = UIColor.blue
        customButton.cornerRadius = 10
        customButton.borderColor = UIColor.black
        customButton.borderWidth = 1
        customButton.title = "This is description for function."
        customButton.image = #imageLiteral(resourceName: "ic_Like")
        customButton.addTarget(target: self, action: #selector(button_Tapped), for: .touchUpInside)
        
        self.view.addSubview(customButton)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func button_Tapped(){
        print("Touch custom button")
    }

}

