//
//  WeatherVC+TableViewDelegate.swift
//  weatherApp
//
//  Created by Sarika on 03.04.19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit

class WeatherTableViewModel {
    
    weak var delegate: WeatherViewController?
    
    var weatherDataArray = [list]()
    
    init(_ viewController: WeatherViewController) {
        delegate = viewController
    }
    
    //MARK: lazy loading
    lazy var isOn : Bool = {
        return false
    }()
    
    lazy var serverUrl: String = {
        var url = "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=24d0aea107909f7f040e8ef7de6ac643"
        return url
    }() //524901 id for Moscow Russia
    
    /**
     To get data from passed URL.
     */
    
    func  getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func getAPIData(){
        
        guard let url = URL(string: serverUrl) else{
            return
        }
        getData(from: url) { [weak self](data, response, error) in
            guard let data = data, error == nil else { return }
            
            do{
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                self?.weatherDataArray = weatherData.list
                DispatchQueue.main.async {
                    self?.delegate?.weatherTableView.reloadData()
                }
            }
            catch let jsonError{
                print("can't serialize data", jsonError)
            }
        }
    }

    /**
     To get data from local Json file.
     */
    func getLocalData()
    {
        if let url = Bundle.main.url(forResource: "weatherApp", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            
            do{
                let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                self.weatherDataArray = weatherData.list
                DispatchQueue.main.async {
                    self.delegate?.weatherTableView.reloadData()
                }
            }
            catch let jsonError{
                print("can't serialize data", jsonError)
            }
        }
    }
}
