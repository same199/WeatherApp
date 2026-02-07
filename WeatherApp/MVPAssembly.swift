//
//  MVPAssembly.swift
//  WeatherApp
//
//  Created by LizOk&Same on 7.02.26.
//

import UIKit

final class MVPAssembly {
    
    func assemble() -> UIViewController {
        let presenter = MVPPresenter()
        let controller = MVPController(presenter: presenter)
        presenter.attachView(controller) // <--- Важно!
        return controller
    }
}
