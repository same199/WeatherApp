//
//  MVPPresenter.swift
//  WeatherApp
//
//  Created by LizOk&Same on 7.02.26.
//


protocol IMVPPresenter {
    func showCityLIst()
    func hideMenu()
    func fetchWeather(lat: Double, lon: Double)
    func searchCity(named name: String)
    func didSelectCity(at index: Int)
    func showAddCityAlert()
    func attachView(_ view: IMVPView)
    
}



final class MVPPresenter: IMVPPresenter {
    private var savedCities: [CityResponse] = []
    private weak var view: IMVPView?
    private let networkManager = NetworkManager()
    private let saveLoadManager = SaveLoadManager()

        init(){
            self.savedCities = saveLoadManager.loadCities()
        }
    func attachView(_ view: IMVPView) {
            self.view = view
        view.reloadCityMenu(with: savedCities)
        }
    
    func fetchWeather(lat: Double, lon: Double) {
            networkManager.fetchWeather(lat: lat, lon: lon) { [weak self] weather in
                self?.view?.updateView(with: weather)
            }
        }
    
    func searchCity(named name: String) {
        networkManager.searchCity(name: name) { [weak self] cities in
            guard let city = cities.first else { return }
            
            self?.savedCities.append(city)
            self?.saveLoadManager.saveCities(self?.savedCities ?? [])
            self?.view?.reloadCityMenu(with: self?.savedCities ?? [])
        }
    }
    
    func didSelectCity(at index: Int) {
        let city = savedCities[index]
        
        fetchWeather(lat: city.lat, lon: city.lon)
        view?.hideMenu()
    }
    
    func showCityLIst(){
        view?.showCityListMenu()
    }
    func hideMenu(){
        view?.hideMenu()
    }
    func showAddCityAlert() {
        view?.showAddCityAlert()
    }
}
