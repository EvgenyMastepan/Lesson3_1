//
//  ViewController.swift
//  Lesson3_1
//
//  Created by Evgeny Mastepan on 25.12.2024.
//

import UIKit

class ViewController: UIViewController {
    private let netvorkLayer = NetworkLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .green
        
        netvorkLayer.sendRequest()
       
    }


}

