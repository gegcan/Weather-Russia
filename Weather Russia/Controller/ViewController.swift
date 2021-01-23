//
//  ViewController.swift
//  Weather Russia
//
//  Created by Александр on 14.01.2021.
//

import UIKit

class ViewController: UIViewController, TableViewControllerDelegate {
 
    let networkManager = NetworkManager()
    let myGradient = CAGradientLayer()
    let myButton = UIButton()
    let tempLabel = UILabel()
    let feelsLabel = UILabel()
    let cityNameLabel = UILabel()
    let myImage = UIImageView()
    var city = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        myGradientSetting()
        myButtonSetting()
        tempLabelSetting()
        cityNameLabelSetting()
        feelsLabelSetting()
        myImageSetting()
        
        getCity(citychooseCity: "Moscow")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        myGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
    }
    
    func cityName(city: String) {
        getCity(citychooseCity: city)
    }
    
    func getCity(citychooseCity: String) {
        networkManager.weatherUrl(city: citychooseCity) { city in
            DispatchQueue.main.async {
                self.tempLabel.text = "\(city.tempString) ºC - на улице"
                self.cityNameLabel.text = city.name
                self.feelsLabel.text = "\(city.feelsLike) ºC - ощущается"
            }
        }
    }
    
    // MARK: - Параметры UI элементов
    
    // Параметры feelsLabel
    fileprivate func feelsLabelSetting() {
        feelsLabel.textColor = .white
        feelsLabel.font = UIFont(name: "Times New Roman", size: 20)
        view.addSubview(feelsLabel)
        
        feelsLabel.translatesAutoresizingMaskIntoConstraints = false
        feelsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        feelsLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        feelsLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        feelsLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: -25).isActive = true
    }
    
    // Параметры cityNameLabel
    fileprivate func cityNameLabelSetting() {
        cityNameLabel.textColor = .white
        cityNameLabel.font = UIFont(name: "Times New Roman Bold", size: 40)
        view.addSubview(cityNameLabel)
        
        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        cityNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        cityNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        cityNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cityNameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
    }
    
    // Параметры myImage
    fileprivate func myImageSetting() {
  
        myImage.image = UIImage(named: "weather")
        view.addSubview(myImage)
        
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        myImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    // Параметры tempLabel
    fileprivate func tempLabelSetting() {
        tempLabel.textColor = .white
        tempLabel.font = UIFont(name: "Times New Roman", size: 25)
        view.addSubview(tempLabel)
        
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        tempLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        tempLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
    }
    
    // Параметры myButton
    fileprivate func myButtonSetting() {
        myButton.setTitle("⚙︎ выбрать город", for: .normal)
        myButton.setTitleColor(.white, for: .normal)
        myButton.setTitleColor(.gray, for: .highlighted)
        myButton.titleLabel?.font = UIFont(name: "Times New Roman", size: 20)
        myButton.backgroundColor = .black
        myButton.alpha = 0.5
        myButton.layer.cornerRadius = 12
        myButton.layer.masksToBounds = true
        myButton.addTarget(self, action: #selector(goToTableViewController), for: .touchUpInside)
        view.addSubview(myButton)
        
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30).isActive = true
        myButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        myButton.widthAnchor.constraint(equalToConstant: 170).isActive = true
    }

    // Параметры градиента
    fileprivate func myGradientSetting() {
        myGradient.startPoint = CGPoint(x: 0, y: 0)
        myGradient.endPoint = CGPoint(x: 1, y: 1)
        myGradient.colors = [#colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1).cgColor, #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1).cgColor]
        myGradient.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        view.layer.addSublayer(myGradient)
    }
    
    @objc func goToTableViewController () {
        guard let tvc = storyboard?.instantiateViewController(identifier: "TableViewController") as? TableViewController else {return}
        tvc.delegate = self
        present(tvc, animated: true)
    }

    
}

