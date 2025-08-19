//
//  SecondViewController.swift
//  TestTask_87429
//
//  Created by Tanya G. on 18.08.2025.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    //вызов сообщения по нажатию на кнопку "Приветствие"
    @IBAction func showGreating() {
        alert(message: "Привет, \(name!)", style: .alert)
    }
    
    //создаю модальное окно с сообщением, для вызова по нажатию на кнопку "Приветствие"
    func alert(message: String, style: UIAlertController.Style) {
      
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "закрыть", style: .default)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }

}
