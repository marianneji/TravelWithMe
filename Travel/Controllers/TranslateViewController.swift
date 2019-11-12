//
//  TranslateViewController.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController,  UITextViewDelegate, UIPickerViewDataSource {



    @IBOutlet weak var detectedLanguageLabel: UILabel!
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
        addDoneButtonOnKeyboard()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSupportedLanguage()

        outputTextView.text = "Press translate to see your translation here"
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        inputTextView.text = ""
        outputTextView.text = ""
    }

    fileprivate func detectLanguage() {
        TranslateManager.shared.detectLanguage(forText: inputTextView.text) { (language) in
            if let language = language {
                self.detectedLanguageLabel.text? = "Dectected language : \(language)"
            }
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if inputTextView.text != "" {

//            detectLanguage()
            inputTextView.resignFirstResponder()
        } else {
            inputTextView.text = "Enter your word here"
        }
    }

    @IBAction func translatePressed(_ sender: UIButton) {

        if inputTextView.text != "" {

            TranslateManager.shared.textToTranslate = inputTextView.text
            inputTextView.resignFirstResponder()
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
                    if let englishRow = TranslateManager.shared.languageCode.firstIndex(of: "en") {
                    self.languagePickerView.selectRow(englishRow, inComponent: 0, animated: true)
                        TranslateManager.shared.targetLanguageCode = "en"
                    }
                }
            } else {
                print("il y a une erreur, trouve la")
            }
        }
    }

    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        inputTextView.inputAccessoryView = doneToolbar
    }
    @objc func doneButtonAction(){
        inputTextView.resignFirstResponder()
    }
}
//MARK: - UIPICKERVIEWDELEGATE
extension TranslateViewController: UIPickerViewDelegate {

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
           inputTextView.resignFirstResponder()
           print("\(TranslateManager.shared.supportedLanguage[row].code) = \(row)")
       }


}
