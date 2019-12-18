//
//  CurrencyViewController.swift
//  Travel
//
//  Created by Graphic Influence on 25/10/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit

class CurrencyViewController: UIViewController {
//MARK: - Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateBaseEuroLabel: UILabel!
    @IBOutlet weak var rateBaseDolLabel: UILabel!
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!
    @IBOutlet weak var convertButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var allUIStackView: UIStackView!
    //MARK: - Variables
    var dollarRate: Double = 0.0
    var euroRate: Double = 0.0

    var currencyManager = CurrencyManager.shared
    var currencyModel: CurrencyModel?
//MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        euroTextField.delegate = self
        dollarTextField.delegate = self
        updateCurrency()
    }
//MARK: - Actions
    @IBAction func convertPressed(_ sender: UIButton) {
        if euroTextField.hasText {
            dollarTextField.text = currencyModel?.convertEuroToDol(euroValue: euroTextField.text!)
            dollarTextField.backgroundColor = .lightGray
           // convertEuroToDol()
            euroTextField.resignFirstResponder()
        } else {
            euroTextField.text =  currencyModel?.convertDolToEuro(dollarValue: dollarTextField.text!)
            euroTextField.backgroundColor = .lightGray
            dollarTextField.resignFirstResponder()
        }
    }
}
//MARK: - CurrencyManagerDelegate
extension CurrencyViewController: CurrencyManagerDelegate {

    func didUpdateCurrencyRates(_ currencyManager: CurrencyManager, currency: CurrencyModel) {
        dateLabel.text = currency.date.dateFormatted()
        rateBaseEuroLabel.text = "1€ = \(currency.dollarRate.doubleToStringTwoDecimal())$"
        dollarRate = currency.dollarRate
        euroRate = 1.0 / currency.dollarRate
        rateBaseDolLabel.text = "1$ = " + euroRate.doubleToStringTwoDecimal() + "€"
        currencyModel = CurrencyModel(date: currency.date.dateFormatted(), dollarRate: dollarRate)
    }
}
//MARK: - TextFieldDelegate
extension CurrencyViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        euroTextField.resignFirstResponder()
        dollarTextField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        dollarTextField.text = ""
        euroTextField.text = ""
        euroTextField.backgroundColor = .white
        dollarTextField.backgroundColor = .white
    }
}
//MARK: - updateView
extension CurrencyViewController {

    fileprivate func updateCurrency() {
        toggleActivityIndicator(shown: true)
        currencyManager.getCurrencyExchangeRate { (success, currency) in
            self.toggleActivityIndicator(shown: false)
            if success, let currency = currency {
                DispatchQueue.main.async {
                    [unowned self] in
                    self.didUpdateCurrencyRates(self.currencyManager, currency: currency)
                }
            } else {
                self.didFailWithError(message: "We couldn't reach the server, please refresh")
            }
        }
    }

    fileprivate func convertEuroToDol() {
        if let euro = euroTextField.text {
            print(euro)
            if let euroDouble = Double(euro) {
                print(euroDouble)
                let result = euroDouble * dollarRate
                dollarTextField.text = result.doubleToStringTwoDecimal()
                dollarTextField.backgroundColor = .lightGray
            }
        }
    }

    fileprivate func convertDolToEuro() {
        if let dol = dollarTextField.text {
            print(dol)
            if let dolDouble = Double(dol) {
                print(dolDouble)
                let result = dolDouble * euroRate
                euroTextField.text = String(format: "%.2f", result)
                euroTextField.backgroundColor = .lightGray
            }
        }
    }

    fileprivate func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        allUIStackView.isHidden = shown

    }
}

extension CurrencyViewController: ErrorManagerDelegate {
    func didFailWithError(message: String) {
        let ac = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
}
