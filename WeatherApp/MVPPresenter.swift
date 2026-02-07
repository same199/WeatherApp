//
//  MVPPresenter.swift
//  WeatherApp
//
//  Created by LizOk&Same on 7.02.26.
//


protocol IMVPPresenter{
    func showCityLIst()
    func hideMenu()
    func fetchWeather(lat: Double, lon: Double)
}



final class MVPPresenter: IMVPPresenter {
    private weak var view: IMVPView?
    private let networkManager = NetworkManager()

        init(){}
    func attachView(_ view: IMVPView) {
            self.view = view
        }
    
    func fetchWeather(lat: Double, lon: Double) {
            networkManager.fetchWeather(lat: lat, lon: lon) { [weak self] weather in
                self?.view?.updateView(with: weather)
            }
        }
    func showCityLIst(){
        view?.showCityListMenu()
    }
    func hideMenu(){
        view?.hideMenu()
    }
}
