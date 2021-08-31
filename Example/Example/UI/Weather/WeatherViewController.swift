//
//  ViewController.swift
//  Example
//
//  Created by 渡部 陽太 on 2020/03/30.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

protocol WeatherModel {
    func fetchWeather(at area: String, date: Date, completion: @escaping (Result<Response, WeatherError>) -> Void)
}

protocol DisasterModel {
    func fetchDisaster(completion: ((String) -> Void)?)
}

class WeatherViewController: UIViewController {
    
    var weatherModel: WeatherModel!
    var disasterModel: DisasterModel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var disasterLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var isWeatherFetching = false {
        didSet {
            self.isWeatherFetching ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
        }
    }
    
    private var presentingAlertController: UIAlertController?
    private var releaseNotificationHandler: (()->Void)?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        let token = notificationCenter.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [unowned self] notification in
            self.loadWeather(notification.object)
        }
        
        releaseNotificationHandler = {
            
            notificationCenter.removeObserver(token)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        releaseNotificationHandler?()
    }
    
    deinit {
        presentingAlertController.map {
            $0.dismiss(animated: false)
        }
        
        print(#function)
    }
            
    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loadWeather(_ sender: Any?) {
        guard !isWeatherFetching else {
            print("Currently Fetching.")
            return
        }
        
        self.isWeatherFetching = true
        weatherModel.fetchWeather(at: "tokyo", date: Date()) { result in
            DispatchQueue.main.async {
                self.isWeatherFetching = false
                self.handleWeather(result: result)
            }
        }
        disasterModel.fetchDisaster { (disaster) in
            self.disasterLabel.text = disaster
        }
    }
    
    func handleWeather(result: Result<Response, WeatherError>) {
        switch result {
        case .success(let response):
            self.weatherImageView.set(weather: response.weather)
            self.minTempLabel.text = String(response.minTemp)
            self.maxTempLabel.text = String(response.maxTemp)
            
        case .failure(let error):
            let message: String
            switch error {
            case .jsonEncodeError:
                message = "Jsonエンコードに失敗しました。"
            case .jsonDecodeError:
                message = "Jsonデコードに失敗しました。"
            case .unknownError:
                message = "エラーが発生しました。"
            }
            
            presentingAlertController.map {
                $0.dismiss(animated: true)
            }
            
            let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default) { [unowned self] _ in
                self.dismiss(animated: true) {
                    print("Close ViewController by \(alertController)")
                }
            })
            self.present(alertController, animated: true) {
                self.presentingAlertController = nil
            }

            presentingAlertController = alertController
        }
    }
}

private extension UIImageView {
    func set(weather: Weather) {
        switch weather {
        case .sunny:
            self.image = R.image.sunny()
            self.tintColor = R.color.red()
        case .cloudy:
            self.image = R.image.cloudy()
            self.tintColor = R.color.gray()
        case .rainy:
            self.image = R.image.rainy()
            self.tintColor = R.color.blue()
        }
    }
}
