//
//  ViewController.swift
//  SimpleNetworkExample
//
//  Created by Andrew Reed on 04/01/2017.
//  Copyright © 2017 Andrew Reed. All rights reserved.
//

import UIKit
import SwiftTemplateFramework

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private var choices = [[String: Any]]()
    private var question = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.contentInset = UIEdgeInsets(top: CGFloat(20), left: CGFloat(0), bottom: CGFloat(0), right: CGFloat(0))
        // Do any additional setup after loading the view, typically from a nib.
        QuestionService.getQuestions(onSuccess: { questions in
            if let path = questions?["path"] as? [[String: Any]] {
                print("Questions \(path)")
                if let choices = path[0]["choices"] as? [[String: Any]] {
                    self.choices = choices
                }
            }
            self.tableView.reloadData()
        }, onFailure: { error in
            print("Error message: \(error.message) code: \(error.httpStatusCode)")
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return choices.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let choice = choices[indexPath.row]
        if let name = choice["choice"] as? String {
            cell.textLabel?.text = name
        }
        if let votes = choice["votes"] as? NSNumber {
            cell.detailTextLabel?.text = votes.stringValue
        }
        return cell
    }
}
