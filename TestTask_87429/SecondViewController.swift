//
//  SecondViewController.swift
//  TestTask_87429
//
//  Created by Tanya G. on 18.08.2025.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var name: String!
    private var arrayData: [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        fetchProduct()
    }
    
    //вызов сообщения по нажатию на кнопку "Приветствие"
    @IBAction func showGreating() {
        
        let alert = UIAlertController(title: nil,
                                      message: "Привет, \(name!)",
                                      preferredStyle: .alert)
        let closeAction = UIAlertAction(title: "закрыть", style: .default)
        alert.addAction(closeAction)
        present(alert, animated: true)
    }
    
    //MARK: -формирование списка в таблице
    private func fetchProduct() {
        NetworkManager.shared.sendRequest { [weak self] response in
            DispatchQueue.main.async {
                guard let self else { return }
                
                for item in response {
                    let product = Product(title: item.title, price: item.price)
                    self.arrayData.append(product)
                }
                
                self.tableView.reloadData()
            }
        }
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
        
        listConfiguration.text = "Название: \(model.title)"
        listConfiguration.secondaryText = "Цена: \(model.price)"
        listConfiguration.textProperties.numberOfLines = 0
        listConfiguration.textProperties.font = UIFont.systemFont(ofSize: 18)
        
        backgroundConfiguration?.cornerRadius = 8
        backgroundConfiguration?.backgroundInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        cell.contentConfiguration = listConfiguration
        cell.backgroundConfiguration = backgroundConfiguration
        return cell
    }
}
