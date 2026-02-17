//
//  Constants.swift
//  WeatherApp
//
//  Created by LizOk&Same on 31.01.26.
//

import Foundation
import UIKit

public enum LabelTextSize: CGFloat {
    case temperatureLabelTextSize = 84
    case locationLabelTextSize = 32
    case feelsLikeTemperatureAndWindLabelTextSize = 16
    case setCityButtonTitleTextSize = 24
}


public enum Offsets: CGFloat {
    case locationLabelTopOffset = 160
    case setCityButtonLeftOffset = 24
    case setCityButtonTopOffset = 64
    case locationLabelBottomOffset = 4
    case tableViewTopOffset = 10
    case tableViewBottomOffset = 20
}

public enum ElementsSize: CGFloat {
    case setCityButtonWidthAndHeight = 40
}

public enum TableViewRowHeight: CGFloat {
    case defaultRowHeight = 48
}
public enum MenuSize: CGFloat {
    case menuWidth = 300
}

public enum CornerRadiusSize: CGFloat {
    case defaultCornerRadiusSize = 16
}

public enum ElementsColors {
    case labelColor

    var color: UIColor{
        switch self {
        case .labelColor:
            return .white
        }
    }
}

public enum DefaultTextForLabels: String{
    case locationLabelText = "Find your city..."
    case temperatureLabelText = "  "
    case feelsLikeTemperatureLabelText = " "
    case windLabelText = ""
}

public enum WindDirection: String {
    case north = "N ⭡"
    case northEast = "NE ↗"
    case east = "E ⭢"
    case southEast = "SE ↘"
    case south = "⭣ S"
    case southWest = "↙ SW"
    case west = "⭠ W"
    case northWest = "↖ NW"
    case defaultWindDirectionText = "Something went wrong..."
}

public enum TemperatureUnit: String {
    case celsius = "°C"
    case feelsLikeCelsius = "Feels like: "
}

public enum AddCityAlert: String{
    case alertTitle = "Add city"
    case alertMessage = "Enter city name..."
    case alertSearchButtonTitle = "Search"
    case alertCancelButtonTitle = "Cancel"
}

public enum ButtonTitle: String{
    case setCityButtonTitle = "☰"
    case addCityButtonTitle = "Add city"
}
