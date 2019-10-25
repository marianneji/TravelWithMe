//
//  ViewController.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var weatherConditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func currentLocationPressed(_ sender: UIButton) {
    }

    @IBAction func searchPressed(_ sender: UIButton) {
    }
}

