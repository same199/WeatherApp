//
//  MVPController.swift
//  WeatherApp
//
//  Created by LizOk&Same on 7.02.26.
//

import UIKit
import SnapKit

protocol IMVPView: AnyObject{
    func updateView(with model: WeatherResponse)
    func showCityListMenu()
    func hideMenu()
}
final class MVPController: UIViewController, IMVPView, GeoAndLocationManagerDelegate {
    let viewMenu = UIView()
    let backView = UIView()
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
    
    private let presenter: IMVPPresenter
    
    init(presenter: IMVPPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private let locationManager = GeoAndLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        locationManager.delegate = self
        locationManager.requestLocationOnce()
    }
    
    private func configureUI(){
        view.backgroundColor = .black
        let backTap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addSubview(backView)
        backView.isHidden = true
        backView.isUserInteractionEnabled = false
        backView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        backView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        backView.addGestureRecognizer(backTap)
        view.addSubview(viewMenu)
        viewMenu.backgroundColor = .white
        viewMenu.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(-(MenuSize.menuWidth.rawValue))
            make.top.bottom.equalToSuperview()
            make.width.equalTo(MenuSize.menuWidth.rawValue)
        }
        
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
        view.addSubview(feelsLikeTemperatureLabel)
        feelsLikeTemperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(Offsets.locationLabelBottomOffset.rawValue)
            make.centerX.equalToSuperview()
        }
        view.addSubview(setCityButton)
        setCityButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(Offsets.setCityButtonTopOffset.rawValue)
            make.left.equalToSuperview().offset(Offsets.setCityButtonLeftOffset.rawValue)
            make.width.height.equalTo(ElementsSize.setCityButtonWidthAndHeight.rawValue)
        }
        setCityButton.addTarget(
            self,
            action: #selector(setCityButtonTapped),
            for: .touchUpInside
        )
    }
    @objc private func setCityButtonTapped() {
        presenter.showCityLIst()
    }
    @objc func tapDetected() {
        presenter.hideMenu()
    }
    func showCityListMenu() {
        viewMenu.snp.updateConstraints{make in
            make.left.equalToSuperview().offset(0)
        }
        backView.isHidden = false

    }
    
    func hideMenu(){
        viewMenu.snp.updateConstraints{make in
            make.left.equalToSuperview().offset(-(MenuSize.menuWidth.rawValue))
        }
        backView.isHidden = true
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    func updateView(with model: WeatherResponse) {
            // Обновляем лейблы
            temperatureLabel.text = "\(model.current.temp)°C"
            feelsLikeTemperatureLabel.text = "Feels like \(model.current.feelsLike)°C"
            locationNameLabel.text = model.timezone
        }
    
    func didUpdateLocation(latitude: Double, longitude: Double) {
        presenter.fetchWeather(lat: latitude, lon: longitude)
        }
    
    func didFailWithError(_ error: Error) {
            print("Ошибка локации: \(error.localizedDescription)")
        }
}
