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
    var currencyManager = CurrencyManager.shared
    var currencyModel: CurrencyModel?

    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCurrency()
    }
    //MARK: - Actions
    @IBAction func convertPressed(_ sender: UIButton) {
        if euroTextField.hasText {
            guard let euroText = euroTextField.text else { return }
            dollarTextField.text = currencyModel?.convertEuroToDol(euroValue: euroText)
            dollarTextField.backgroundColor = .lightGray
            euroTextField.resignFirstResponder()
        } else {
            guard let dolText = dollarTextField.text else { return }
            euroTextField.text =  currencyModel?.convertDolToEuro(dollarValue: dolText)
            euroTextField.backgroundColor = .lightGray
            dollarTextField.resignFirstResponder()
        }
    }
}
//MARK: - CurrencyManagerDelegate
extension CurrencyViewController: CurrencyManagerDelegate {

    func didUpdateCurrencyRates(_ currencyManager: CurrencyManager, currency: CurrencyModel) {
        currencyModel = CurrencyModel(date: currency.date.dateFormatted(), dollarRate: currency.dollarRate, euroRate: currency.euroRate)
        dateLabel.text = currency.date.dateFormatted()
        rateBaseEuroLabel.text = "1€ = \(currency.dollarRate.doubleToStringTwoDecimal())$"
        rateBaseDolLabel.text = "1$ = " + currency.euroRate.doubleToStringTwoDecimal() + "€"

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

    fileprivate func toggleActivityIndicator(shown: Bool) {
        activityIndicator.isHidden = !shown
        allUIStackView.isHidden = shown

    }
}

