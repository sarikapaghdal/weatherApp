//
//  weatherAppTests.swift
//  weatherAppTests
//
//  Created by Sarika on 02.04.19.
//  Copyright © 2019 Sarika. All rights reserved.
//

import XCTest
@testable import weatherApp

class weatherAppTests: XCTestCase {
    
    override func setUp() {
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testViewModelInitialization(){
        let viewController = WeatherViewController()
        XCTAssertNoThrow(WeatherTableViewModel(viewController))
    }

    func testAPIData() {
        guard let serverUrl = URL(string: "http://api.openweathermap.org/data/2.5/forecast?id=524901&APPID=24d0aea107909f7f040e8ef7de6ac643") else { return }
        URLSession.shared.dataTask(with: serverUrl) { (data, response, error) in
            guard let data = data else { return }
            do {
                
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                    let jsonArray =  jsonResult.value(forKey: "list") as? NSArray{
                    for json in jsonArray {
                        XCTAssertNotNil(json)
                        if let arrayData = json as? [String : AnyObject]{
                            XCTAssertNotNil(arrayData)
                        }
                    }
                    XCTAssertNotNil(jsonArray)
                }
            } catch let err {
                print("Err", err)
                }
            }.resume()
    }
    
    func testImageUrlData()
    {
           let imageUrl = "http://openweathermap.org/img/w/04d.png"
            guard let imageRUL = URL(string: imageUrl) else {
                return
            }
            URLSession.shared.dataTask(with: imageRUL) { (data, response, error) in
            guard let data = data else { return }
            XCTAssertNotNil(data)
        }
    }
    func testLocalData()
    {
        if let url = Bundle.main.url(forResource: "weatherApp", withExtension: "json"),
            let data = try? Data(contentsOf: url) {
            
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary,
                    let jsonArray =  jsonResult.value(forKey: "list") as? NSArray{
                    for json in jsonArray {
                        XCTAssertNotNil(json)
                        if let arrayData = json as? [String : AnyObject]{
                            XCTAssertNotNil(arrayData)
                        }
                    }
                    XCTAssertNotNil(jsonArray)
                }
            }catch let err {
                print("Err", err)
            }
        }
    }
    
    func testWeatherViewControllerInitialized() {
        let mainViewController = WeatherViewController()
        XCTAssertNotNil(mainViewController)
        XCTAssertNoThrow(mainViewController)
    }
}
