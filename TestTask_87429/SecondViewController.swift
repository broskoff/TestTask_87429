//
//  SecondViewController.swift
//  TestTask_87429
//
//  Created by Tanya G. on 18.08.2025.
//

import UIKit

class SecondViewController: UIViewController {
    
    var titleProduct: String!
    var priceProduct: Float!
    var arrayData: [String] = []
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var name: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        //возвращение данных сетевого запроса, которые будем передавать в таблицу на втором экране. Возможно это на втором экране и надо вызывать
        NetworkManager.shared.sendRequest() { [weak self] title, price in
            DispatchQueue.main.async {
                guard let self else { return }
                
                self.arrayData.append(title)
                self.arrayData.append(String(price))
                
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    //вызов сообщения по нажатию на кнопку "Приветствие"
    @IBAction func showGreating() {
        showAlert(message: "Привет, \(name!)")
    }
    
}


//MARK: -Расширение класса SecondViewController
extension SecondViewController {
    //создаю окно с сообщением, для вызова по нажатию на кнопку "Приветствие"
    private func showAlert(message: String) {
      
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "закрыть", style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
}

//MARK: -UITableViewDelegate, UITableViewDataSource
extension SecondViewController: UITableViewDelegate, UITableViewDataSource {
    
    //количество ячеек в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    //сама ячейка
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let model = arrayData[indexPath.row]
        var listConfiguration = cell.defaultContentConfiguration()
        var backgroundConfiguration = cell.backgroundConfiguration
        
        listConfiguration.text = "\(model)"
        listConfiguration.textProperties.numberOfLines = 0
        listConfiguration.textProperties.font = UIFont.systemFont(ofSize: 24)
        
        backgroundConfiguration?.cornerRadius = 8
        backgroundConfiguration?.backgroundInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        cell.contentConfiguration = listConfiguration
        cell.backgroundConfiguration = backgroundConfiguration
        return cell
    }
    
    
}
