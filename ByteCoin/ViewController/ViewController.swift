//
//  ViewController.swift
//  ByteCoin
//
//  Created by Danila Bolshakov on 12.08.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let background = UIImageView()
        background.backgroundColor = UIColor(named: "viewColor")
        return background
    }()
    
    private lazy var generalLabelView: UILabel = {
        let label = UILabel()
        label.text = "Byte Coin"
        label.font = UIFont(name: "Helvetica", size: 40)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var labelViewStackOne: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textAlignment = .center
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var labelViewStackTwo: UILabel = {
        let label = UILabel()
        label.text = coinManger.currencyArray.first
        label.font = UIFont(name: "Helvetica", size: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let element = UIStackView()
        element.axis = .horizontal
        return element
    }()
    
    private lazy var imageView: UIImageView = {
        let element = UIImageView()
        element.image = UIImage(systemName: "bitcoinsign.circle.fill")
        element.contentMode = .scaleAspectFit
        return element
    }()
    
    private lazy var pickerView: UIPickerView = {
        let element = UIPickerView()
        return element
    }()
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinManger.delegate = self
        pickerView.dataSource = self
        pickerView.delegate = self
        setViews()
        setupConstrains()
    }
    
    //MARK: - Private Properties
    
    var coinManger = CoinManager()
    
    //MARK: - func
    
    
}

extension ViewController {
    
    //MARK: - Setup Views
    
    private func setViews() {
        view.addSubview(backgroundImageView)
        backgroundImageView.addSubview(generalLabelView)
        backgroundImageView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(imageView)
        mainStackView.addArrangedSubview(labelViewStackOne)
        mainStackView.addArrangedSubview(labelViewStackTwo)
        view.addSubview(pickerView)
    }
    
    //MARK: - Setup Constraints
    
    private func setupConstrains() {
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        generalLabelView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(200)
            make.bottom.equalToSuperview().inset(600)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(200)
        }
        
        labelViewStackOne.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        labelViewStackTwo.snp.makeConstraints { make in
            make.width.height.equalTo(100)
        }
        
        pickerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.width.equalTo(200)
        }
    }
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManger.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectCurrent = coinManger.currencyArray[row]
        coinManger.getSelect(for: selectCurrent)
    }
}

extension ViewController: CoinManagerDelegate {
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.labelViewStackOne.text = price
            self.labelViewStackTwo.text = currency
        }
    }
}
