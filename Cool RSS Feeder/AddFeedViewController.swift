//
//  AddFeedViewController.swift
//  Cool RSS Feeder
//
//  Created by Andrei Palonski on 01.12.16.
//  Copyright © 2016 Andrei Palonski. All rights reserved.
//

import UIKit

class AddFeedViewController: UIViewController {
  
  @IBOutlet weak var adressTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  
  @IBAction func saveButtonPressed(_ sender: Any) {
    let name = nameTextField.text!
    let adress = adressTextField.text!
    
    if (name.characters.count < 4) {
      showAlert(title: "Error", alert: "Please enter a name longer han 4 character")
    }
    
    if (adress.characters.count < 6) {
      showAlert(title: "Error", alert: "Please enter an adress longer han 6 character")
    }
    
    do {
      let feed = try FeedDataHelper.insert(item: Feed(id: 0, name: name, adress: adress )!)
      print(feed)
      nameTextField.text = ""
      adressTextField.text = ""
      navigationController?.popViewController(animated: true)
    } catch _ {}
    
  }
  
  func showAlert(title: String, alert: String) {
    let alertController = UIAlertController(title: title, message: alert, preferredStyle: .alert)
    let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    alertController.addAction(okAction)
    self.present(alertController, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
}
