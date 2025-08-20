//
//  ViewController.swift
//  TestTask_87429
//
//  Created by Tanya G. on 18.08.2025.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    
    @IBOutlet weak var birthDateTF: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTF.isSecureTextEntry = true
        repeatPasswordTF.isSecureTextEntry = true

        createDatePicker()
        
        
    }
    
    
    //MARK: -передача имени на второй экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SecondViewController else { return }
        destinationVC.name = nameTF.text
    }

    //MARK: -настраиваю выборщик даты в поле "Укажите дату"
    func createDatePicker() {
        
        birthDateTF.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        
        toolBar.setItems([flexSpace, doneButton], animated: true)
        birthDateTF.inputAccessoryView = toolBar
    }
    
    @objc func doneAction() {
        getDateFromPicker()
        view.endEditing(true)
    }
    
    //передача даты с выборщика в поле "Укажите дату"
    func getDateFromPicker() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthDateTF.text = formatter.string(from: datePicker.date)
    }
    
    //MARK: -действие кнопки "Зарегистрироваться"
    @IBAction func buttonTapped() {
        
        guard let name = nameTF.text,
              let surname = surnameTF.text,
              let password = passwordTF.text,
              let repeatPassword = repeatPasswordTF.text else { return }
        
        //раскоментировать в конце:
//        if name.isEmpty || surname.isEmpty || password.isEmpty || repeatPassword.isEmpty {
//            showAlert(title: "Недостаточно информации",
//                      message: "Для успешной регистрации, пожалуйста, заполните все поля")
//        }
        
        //добавлен переход с идентификатором, для возможности задать условия для перехода
        performSegue(withIdentifier: "goToSecondVC", sender: nil)
    }
    
}

//MARK: -Расширение FirstViewController
extension FirstViewController {
    
    //создаю предупреждение, если поля не заполненны полностью
    private func showAlert(title: String, message: String) {
      
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
