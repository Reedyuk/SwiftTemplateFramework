//
//  ViewController.swift
//  SimpleNetworkExample
//
//  Created by Andrew Reed on 04/01/2017.
//  Copyright © 2017 Andrew Reed. All rights reserved.
//

import UIKit
import SwiftTemplateFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        QuestionService.getQuestions(onSuccess: { questions in
            print("Questions \(questions)")
        }, onFailure: { error in
            print("Error message: \(error.message) code: \(error.httpStatusCode)")
        })
    }

}

