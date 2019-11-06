//
//  TranslateViewController.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController, UIPickerViewDelegate, UITextViewDelegate, UIPickerViewDataSource {



    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var languagePickerView: UIPickerView!
    @IBOutlet weak var translateButton: UIButton!
    @IBOutlet weak var bottomInputTextViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomOutputTextViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputTextView.delegate = self
        outputTextView.delegate = self
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        fetchSupportedLanguage()

//        // Observe for keyboard notifications.
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillAppear(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        inputTextView.text = ""
    }
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//        <#code#>
//    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if inputTextView.text != "" {
            textView.resignFirstResponder()
        } else {
            inputTextView.text = "Enter your word here"
        }
    }




    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return TranslateManager.shared.supportedLanguage.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TranslateManager.shared.supportedLanguage[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        TranslateManager.shared.targetLanguageCode = TranslateManager.shared.supportedLanguage[row].code
    }

    @IBAction func translatePressed(_ sender: UIButton) {
        // implementer detectlanguage et donner une valeur à sourceCode
        if inputTextView.text != "" {
            TranslateManager.shared.textToTranslate = inputTextView.text
        }
        TranslateManager.shared.translate { (translation) in
            if let translation = translation {
                DispatchQueue.main.async {
                    [unowned self] in
                    self.outputTextView.text = translation
                }
            } else {
                print("Ca n'a pas marché")
            }
        }
    }

    func fetchSupportedLanguage() {
        TranslateManager.shared.fetchSupportedLanguage { (success) in
            if success {
                DispatchQueue.main.async {
                    [unowned self] in
                    self.languagePickerView.reloadAllComponents()
                }
            } else {
                print("il y a une erreur, trouve la")
            }
        }
    }
//    @objc func handleKeyboardWillAppear(notification: Notification) {
//        guard let userInfo = notification.userInfo else { return }
//        if let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//            let keyboardHeight = keyboardSize.size.height
//            bottomInputTextViewConstraint.constant = 20.0
//            bottomInputTextViewConstraint.constant += keyboardHeight
//        }
//    }
//
//
//    @objc func handleKeyboardWillHide(notification: Notification) {
//        guard let userInfo = notification.userInfo else { return }
//        if let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
//            let keyboardHeight = keyboardSize.size.height
//            bottomInputTextViewConstraint.constant -= keyboardHeight
//        }
//    }

}
