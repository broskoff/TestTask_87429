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
        showAlert(message: "Привет, \(name!)")
    }
}


//MARK: -Расширение класса SecondViewController
extension SecondViewController {
    //создаю модальное окно с сообщением, для вызова по нажатию на кнопку "Приветствие"
    private func showAlert(message: String) {
      
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "закрыть", style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
}
