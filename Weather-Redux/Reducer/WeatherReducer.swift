//
//  WeatherReducer.swift
//  Weather-Redux
//
//  Created by Allen on 2019/6/7.
//  Copyright © 2019 Allen. All rights reserved.
//

import ReSwift

func weatherReducer(action:Action, state: WeatherState? ) -> WeatherState {
    var state = state ?? WeatherState(weatherModel: WeatherModel(), detailModels: [])
    switch action {
    case let weatherAction as WeatherAction:
        state = weatherAction.state
    default:
        break
    }
    return state
}
