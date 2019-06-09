//
//  WeatherThunk.swift
//  Weather-Redux
//
//  Created by Allen on 2019/6/7.
//  Copyright © 2019 Allen. All rights reserved.
//

import ReSwift
import ReSwiftThunk
import SwiftLocation

func fetchWeatherThunk(_ latitude:String, longitude: String) -> Thunk<WeatherState> {
    return Thunk<WeatherState> { dispatch, getState in
        guard var state = getState() else {return}
        DispatchQueue.main.async {
            WeatherApi.requestData(latitude, longitude: longitude, success: { (weatherModel, detailModels) in
                state.weatherModel = weatherModel
                state.detailModels = detailModels
                dispatch(WeatherAction(state: state))
            }, failure: { (error) in
                print("")
            })
        }
    }
}

let fetchLocationThunk = Thunk<WeatherState> { dispatch, getState in
    DispatchQueue.main.async {
        LocationManager.shared.locateFromGPS(.oneShot, accuracy: .city, result: { (result) in
            switch result {
            case .failure(let error):
                debugPrint("Received error: \(error) the location was changed to Culver")
                dispatch(fetchWeatherThunk("34.0273", longitude: "-118.3864"))
                
            case .success(let location):
                dispatch(fetchWeatherThunk(String(location.coordinate.latitude), longitude: String(location.coordinate.longitude)))
            }
        })
    }
}

fileprivate class WeatherApi {
    static func requestData(_ latitude:String, longitude:String, success:@escaping ((WeatherModel,[WeatherDetailModel]) -> Void),failure:@escaping ((Error) -> Void)){
        let url = URLStore.fetchWeather.rawValue + latitude + "," + longitude
        
        WHServerApi.request(url, success: { result in
            guard let currentlyModel = WeatherModel.deserialize(from: result, designatedPath: "currently")else {
                failure(NetWorkError.responseError(description: result))
                return
            }
            
            guard let dailyList:[WeatherDetailModel] = [WeatherDetailModel].deserialize(from: result, designatedPath: "daily.data") as? [WeatherDetailModel]else {
                failure(NetWorkError.responseError(description: result))
                return
            }
            success(currentlyModel,dailyList)
        }, failure: { error in
            failure(NetWorkError.responseError(description: "\(error)"))
        })
    }
}
