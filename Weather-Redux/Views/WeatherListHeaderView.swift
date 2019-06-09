//
//  WeatherListHeaderView.swift
//  WeatherHelper
//
//  Created by Allen on 2019/6/7.
//  Copyright © 2019 Allen. All rights reserved.
//

import UIKit

class WeatherListHeaderView: UIView {
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var dewPointLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var nearestStormBearingLabel: UILabel!
    @IBOutlet weak var nearestStormDistanceLabel: UILabel!
    @IBOutlet weak var ozoneLabel: UILabel!
    @IBOutlet weak var precipIntensityLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!
    @IBOutlet weak var iconImageVIew: UIImageView!
    
    func updateUI(_ model:WeatherModel) {
        apparentTemperatureLabel.text = model.apparentTemperature
        cloudCoverLabel.text = String(model.cloudCover)
        dewPointLabel.text = model.dewPoint
        humidityLabel.text = String(model.humidity)
        nearestStormBearingLabel.text = String(model.nearestStormBearing)
        nearestStormDistanceLabel.text = String(model.nearestStormDistance)
        ozoneLabel.text = model.ozone
        precipIntensityLabel.text = String(model.precipIntensity)
        summaryLabel.text = model.summary
        temperatureLabel.text = model.temperature
        timeLabel.text = model.weekday
        windBearingLabel.text = model.windBearing
        iconImageVIew.image = model.weatherIcon
    }
}
