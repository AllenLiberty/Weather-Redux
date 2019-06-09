//
//  WeatherState.swift
//  Weather-Redux
//
//  Created by Allen on 2019/6/7.
//  Copyright © 2019 Allen. All rights reserved.
//

import HandyJSON
import ReSwift

struct WeatherState: StateType{
    var weatherModel: WeatherModel
    var detailModels: [WeatherDetailModel]
}
