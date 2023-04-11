//
//  ViewController.swift
//  Exchange
//
//  Created by Mac OS on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
    }
}

//MARK: - UIPickerDataSource

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return  coinManager.currencyArray.count
       }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return coinManager.currencyArray[row]
       }
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           let selectCurrency = coinManager.currencyArray[row]
           coinManager.getCoinPrice(for: selectCurrency)
       }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

//MARK: - CurrencyDelegate

extension ViewController: CurrencyManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateCurrency(price: String, currency: String) {
       DispatchQueue.main.async {
           self.bitcoinLabel.text = price
           self.currencyLabel.text = currency
       }
   }
}
