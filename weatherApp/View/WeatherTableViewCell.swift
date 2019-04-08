//
//  WeatherTableViewCell.swift
//  weatherApp
//
//  Created by Sarika on 02.04.19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var IconImageView: UIImageView!
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //MARK: cell identifier
    static let identifier: String = {
        return "WeatherCell"
    }()
    
    //MARK: lazy loading
    lazy var isOn : Bool = {
        return false
    }()
    
    lazy var imageUrl : String = {
        return "http://openweathermap.org/img/w/"
    }()
    
    lazy var endPoint : String = {
        return ""
    }()
    
    func configureCell(data: list?){
        if let dateIs = data?.date {
            dateLabel.text = dateIs
        }
        
        if let temprature = data?.main.temprature {
            tempratureLabel.text = "\(temprature)K"
        }
        
        if let descriptionIs = data?.weather[0].description {
            descriptionLabel.text = descriptionIs
        }
        
        if let iconIs = data?.weather[0].icon {
            if !isOn {
                if let currentImage = Bundle.main.path(forResource: iconIs, ofType: nil) {
                    guard let image = UIImage(contentsOfFile: currentImage) else {
                        fatalError("Unable to load thumbnail")
                    }
                    IconImageView.image = image
                }
            }
            else{
                endPoint = imageUrl + iconIs + ".png"
                guard let imageURL = URL(string: endPoint) else {
                    return
                }
                
                getData(from: imageURL) { (data, response, error) in
                    guard let data = data, error == nil else { return }
                    self.imageFromUrl(data: data)
                }
            }
        }
    }
    
    func  getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    /**
     To set image of imageview.
     */
    func imageFromUrl(data: Data)
    {
        DispatchQueue.main.async {
            self.IconImageView.image = UIImage(data: data)
        }
    }
}
