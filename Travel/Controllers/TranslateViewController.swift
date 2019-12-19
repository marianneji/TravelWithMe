//
//  TranslateViewController.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class TranslateViewController: UIViewController {

    @IBOutlet weak var detectedLanguageLabel: UILabel!
    @IBOutlet weak var inputTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!
    @IBOutlet weak var languagePickerView: UIPickerView!
    @IBOutlet weak var translateButton: UIButton!

    @IBOutlet weak var outputContainerView: UIView!
    @IBOutlet weak var inputContainerView: UIView!
    private var pickerViewTranslationLanguages = [String]()
    private var supportedLanguageCode = [String]()
    private var targetLanguageCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        fetchSupportedLanguage()
        setUpView(20)

    }

//MARK: - Actions
    @IBAction func translatePressed(_ sender: UIButton) {
        guard let target = targetLanguageCode else { return }
        translate(target)
    }

    fileprivate func translate(_ target: String) {
        TranslateManager.shared.translate(translateLanguage: target, textToTranslate: inputTextView.text) { (success, data) in
            if success, let data = data {
                for translation in data.translations {
                    self.outputTextView.text = translation.translatedText
                    self.detectedLanguageLabel.text = "Detected language: \(translation.detectedSourceLanguage)"
                }
            } else {
                self.didFailWithError(message: "Unable to reach the server. Check your internet connection")
            }
        }
    }

    func fetchSupportedLanguage() {
        TranslateManager.shared.getLanguages { (success, data) in
            if success, let data = data {
                for language in data.languages {
                    let code = language.language
                    let name = language.name
                    self.pickerViewTranslationLanguages.append(name)
                    self.supportedLanguageCode.append(code)
                    if let englishRow = self.pickerViewTranslationLanguages.firstIndex(of: "English") {
                        self.languagePickerView.selectRow(englishRow, inComponent: 0, animated: true)
                        self.languagePickerView.reloadAllComponents()
                        self.targetLanguageCode = "en"
                    }
                }
            } else {
                self.didFailWithError(message: "Unable to reach the server. Check your internet connection")
            }
        }
    }
}
//MARK: - PickerViewDelegate
extension TranslateViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewTranslationLanguages.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerViewTranslationLanguages[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        inputTextView.resignFirstResponder()
        targetLanguageCode = supportedLanguageCode[row]
    }
}
//MARK: - TextViewDelegate
extension TranslateViewController: UITextViewDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        inputTextView.text = ""
        outputTextView.text = ""
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if inputTextView.text != "" {
            inputTextView.resignFirstResponder()
        } else {
            inputTextView.text = "Enter your word here"
        }
    }
}
//MARK: - DoneButton
extension TranslateViewController {

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

    @objc func doneButtonAction() {
        guard let target = targetLanguageCode else { return }
        translate(target)
        inputTextView.resignFirstResponder()
    }

    func setUpView(_ cornerRadius: CGFloat) {
        translateButton.layer.cornerRadius = cornerRadius
        inputTextView.layer.cornerRadius = cornerRadius
        outputTextView.layer.cornerRadius = cornerRadius
        inputContainerView.layer.cornerRadius = cornerRadius
        outputContainerView.layer.cornerRadius = cornerRadius
    }
}
