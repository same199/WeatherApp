//
//  WeatherScreenViewController.swift
//  WeatherApp
//
//  Created by LizOk&Same on 31.01.26.
//

import Foundation
import SnapKit
import UIKit

class WeatherScreenViewController: UIViewController {
    private let locationNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: LabelTextSize.locationLabelTextSize.rawValue)
        label.textColor = .white
        label.text = "Minsk"
        return label
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: LabelTextSize.temperatureLabelTextSize.rawValue)
        label.textColor = .white
        label.text = "36.6"
        return label
    }()
    private let feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: LabelTextSize.feelsLikeTemperatureLabelTextSize.rawValue)
        label.textColor = .white
        label.text = "Feels like 34.1"
        return label
    }()
    private let setCityButton: UIButton = {
        let button = UIButton()
        button.setTitle("☰", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        
        }
    private func configureUI(){
        view.backgroundColor = .black
        view.addSubview(locationNameLabel)
        locationNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(Offsets.locationLabelTopOffset.rawValue)
        }
        view.addSubview(temperatureLabel)
        temperatureLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(locationNameLabel.snp.bottom).offset(Offsets.locationLabelBottomOffset.rawValue)
        }
        view.addSubview(setCityButton)
        setCityButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Offsets.setCityButtonTopOffset.rawValue)
            make.left.equalToSuperview().offset(Offsets.setCityButtonLeftOffset.rawValue)
            make.width.height.equalTo(ElementsSize.setCityButtonWidthAndHeight.rawValue)
        }
        view.addSubview(feelsLikeTemperatureLabel)
        feelsLikeTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(Offsets.locationLabelBottomOffset.rawValue)
            make.centerX.equalToSuperview()
        }
        
        
    }
}
