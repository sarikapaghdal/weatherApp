//
//  ViewController.swift
//  weatherApp
//
//  Created by Sarika on 02.04.19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!

    //MARK: lazy loading
    lazy var viewModel: WeatherTableViewModel = {
        return WeatherTableViewModel(self)
    }()
    
    lazy var cellHeight : CGFloat = {
        return 110
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.weatherDataArray.removeAll()
        viewModel.getLocalData()
    }
    
    @IBAction func switchTapped(_ sender: UISwitch) {
        viewModel.weatherDataArray.removeAll()
        viewModel.isOn = sender.isOn
        if sender.isOn
        {
            viewModel.getAPIData()
        }
        else{
            viewModel.getLocalData()
        }
    }
}

//MARK: - TableView DataSource
extension WeatherViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: WeatherTableViewCell.identifier, for: indexPath) as? WeatherTableViewCell {
            cell.isOn = viewModel.isOn
            cell.configureCell(data: viewModel.weatherDataArray[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - TableView Delegate
extension WeatherViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.weatherDataArray.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}
