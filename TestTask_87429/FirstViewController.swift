//
//  ViewController.swift
//  TestTask_87429
//
//  Created by Tanya G. on 18.08.2025.
//

import UIKit

class FirstViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surnameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    @IBOutlet weak var birthDateTF: UITextField!
    let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTF.delegate = self
        surnameTF.delegate = self
        passwordTF.delegate = self
        repeatPasswordTF.delegate = self
        birthDateTF.delegate = self
        
        passwordTF.isSecureTextEntry = true
        repeatPasswordTF.isSecureTextEntry = true
        
        //достаю из хранилища имя (если оно там есть)
        nameTF.text = UserSettings.userName
        
        createDatePicker()
    }
    
    
    //MARK: -валидация текстовых полей
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard nameTF.text?.isEmpty == false else { return }
        
        if textField == nameTF {
            if let _ = Double(nameTF.text!) {
                showAlert(title: "Ошибка", message: "Имя должно состоять только из букв") {
                    self.nameTF.text = ""
                }
            }
        } else if textField == surnameTF {
            if let _ = Double(surnameTF.text!) {
                showAlert(title: "Ошибка", message: "Фамилия может содержать только буквы") {
                    self.surnameTF.text = ""
                }
            }
        } else if textField == repeatPasswordTF {
            if repeatPasswordTF.text != passwordTF.text {
                showAlert(title: "Ошибка", message: "Введенный текст должен совпадать с паролем") {
                    self.repeatPasswordTF.text = ""
                }
            }
        }
    }
    
    //MARK: - запрет на ручной ввод в поле с датой
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == birthDateTF {
            return false
        }
        return true
    }

    //MARK: -скрытие клавиатуры по нажатию кнопки done на ней же
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
    }
    
    //MARK: -настраиваю выборщик даты
    func createDatePicker() {
        
        birthDateTF.inputView = datePicker
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
        
        let localeID = Locale.preferredLanguages.first
        datePicker.locale = Locale(identifier: localeID!)
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil,
                                        action: nil)
        let doneButton = UIBarButtonItem(title: "готово",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneAction))
        
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
              let repeatPassword = repeatPasswordTF.text,
              let date = birthDateTF.text else { return }
        //создаю предупреждение, если поля не заполненны полностью
        if name.isEmpty || surname.isEmpty || password.isEmpty || repeatPassword.isEmpty || date.isEmpty {
            showAlert(title: "Недостаточно информации",
                      message: "Для успешной регистрации, пожалуйста, заполните все поля")
        }
        
        //добавлен переход с идентификатором, для возможности задать условия для перехода
        performSegue(withIdentifier: "goToSecondVC", sender: nil)
        
        //сохраняю имя в локальное хранилище
        UserSettings.userName = name
    }
    
    
    //MARK: -передача имени на второй экран
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? SecondViewController else { return }
        destinationVC.name = nameTF.text
    }
    
    //MARK: -alert
    private func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
      
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
