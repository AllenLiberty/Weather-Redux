//
//  WeatherListViewController.swift
//  Weather-Redux
//
//  Created by Allen on 2019/6/7.
//  Copyright © 2019 Allen. All rights reserved.
//

import UIKit
import ReSwift
import ReSwiftThunk
import Alamofire

class WeatherListViewController: UIViewController {

    var tableDataSource: TableDataSource<UITableViewCell, WeatherDetailModel>?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentlyView: WeatherListHeaderView!
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherStore.subscribe(self)
        weatherStore.dispatch(fetchWeatherThunk("37.8267", longitude: "-122.4233"))
        listeningNetwork()
    }
    
    deinit {
        weatherStore.unsubscribe(self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherDetail", let controller = segue.destination as? WeatherDetailViewController {
            controller.dailyModel = sender as? WeatherDetailModel
        }
    }
    
    @IBAction func onLocation(_ sender: Any) {
        weatherStore.dispatch(fetchLocationThunk)
    }
}

extension WeatherListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toWeatherDetail", sender: weatherStore.state.detailModels[indexPath.row])
    }
}

extension WeatherListViewController: StoreSubscriber {
    func newState(state: WeatherState) {
        tableDataSource = TableDataSource(cellIdentifier:"WeatherCell", models: state.detailModels) { (cell, model) in
            cell.textLabel?.text = model.weekday + "  High:" + model.apparentTemperatureHigh + "℉  Low:" +  model.apparentTemperatureLow + "℉"
            cell.imageView?.image = model.weatherIcon
            return cell
        }
        tableView.dataSource = tableDataSource
        tableView.reloadData()
        currentlyView.updateUI(state.weatherModel)
    }
}

// Network Changed
extension WeatherListViewController{
    func listeningNetwork(){
        let net = NetworkReachabilityManager()
        net?.startListening()
        net?.listener = { status in
            if net?.isReachable ?? false {
                switch status {
                case .reachable(.ethernetOrWiFi), .reachable(.wwan):
                    weatherStore.dispatch(fetchWeatherThunk("37.8267", longitude: "-122.4233"))
                default: break
                }
            }
        }
    }
}

let weatherMiddlware : Middleware<WeatherState> = createThunksMiddleware()
var weatherStore = Store<WeatherState>(reducer: weatherReducer, state: nil, middleware: [weatherMiddlware])
