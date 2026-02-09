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
        label.textColor = ElementsColors.labelColor.color
        label.text = DefaultTextForLabels.locationLabelText.rawValue
        return label
    }()
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: LabelTextSize.temperatureLabelTextSize.rawValue)
        label.textColor = ElementsColors.labelColor.color
        label.text = DefaultTextForLabels.temperatureLabelText.rawValue
        return label
    }()
    private let feelsLikeTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: LabelTextSize.feelsLikeTemperatureAndWindLabelTextSize.rawValue)
        label.textColor = ElementsColors.labelColor.color
        label.text = DefaultTextForLabels.feelsLikeTemperatureLabelText.rawValue
        return label
    }()
    private let windDirectionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: LabelTextSize.feelsLikeTemperatureAndWindLabelTextSize.rawValue)
        label.textColor = ElementsColors.labelColor.color
        label.text = DefaultTextForLabels.windLabelText.rawValue
        return label
    }()
    private let setCityButton: UIButton = {
        let button = UIButton()
        button.setTitle("☰", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(ElementsColors.labelColor.color, for: .normal)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: LabelTextSize.setCityButtonTitleTextSize.rawValue)
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
        backView.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        backView.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        backView.addGestureRecognizer(backTap)
        view.addSubview(viewMenu)
        viewMenu.backgroundColor = .white
        viewMenu.snp.makeConstraints{ make in
            make.left.equalToSuperview().offset(-(MenuSize.menuWidth.rawValue))
            make.top.bottom.equalToSuperview()
            make.width.equalTo(MenuSize.menuWidth.rawValue)
        }
        viewMenu.layer.cornerRadius = CornerRadiusSize.defaultCornerRadiusSize.rawValue
        
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
        view.addSubview(windDirectionLabel)
        windDirectionLabel.snp.makeConstraints { make in
            make.top.equalTo(feelsLikeTemperatureLabel.snp.bottom).offset(Offsets.locationLabelBottomOffset.rawValue)
            make.centerX.equalToSuperview()
            
        }
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
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }

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
        let city = model.timezone.split(separator: "/").last.map { String($0) } ?? model.timezone
        temperatureLabel.text = "\(Int(model.current.temp.rounded()))°C"
        feelsLikeTemperatureLabel.text = "Feels like \(Int(model.current.feelsLike.rounded()))°C"
        locationNameLabel.text = city
        let windDirection = model.current.windDeg
        
        switch windDirection {
            case 0..<22.5:
            windDirectionLabel.text = WindDirection.north.rawValue
        case 22.5..<67.5:
            windDirectionLabel.text = WindDirection.northEast.rawValue
        case 67.5..<112.5:
            windDirectionLabel.text = WindDirection.east.rawValue
        case 112.5..<157.5:
            windDirectionLabel.text = WindDirection.southEast.rawValue
        case 157.5..<202.5:
            windDirectionLabel.text = WindDirection.south.rawValue
        case 202.5..<247.5:
            windDirectionLabel.text = WindDirection.southWest.rawValue
        case 247.5..<292.5:
            windDirectionLabel.text = WindDirection.west.rawValue
        case 292.5..<337.5:
            windDirectionLabel.text = WindDirection.northWest.rawValue
        case 337.5...360:
            windDirectionLabel.text = WindDirection.north.rawValue
        default:
            windDirectionLabel.text = "Something wrong"
        }
        
        }
    
    func didUpdateLocation(latitude: Double, longitude: Double) {
        presenter.fetchWeather(lat: latitude, lon: longitude)
        }
    
    func didFailWithError(_ error: Error) {
            print("Ошибка локации: \(error.localizedDescription)")
        }
}
