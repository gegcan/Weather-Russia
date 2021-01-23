//
//  TableViewController.swift
//  Weather Russia
//
//  Created by Александр on 14.01.2021.
//

import UIKit

protocol TableViewControllerDelegate {
    func cityName(city: String)
}

class TableViewController: UITableViewController {
    
    var cityRuArray: [String] = []
    var cityEnArray: [String] = []
    var delegate: TableViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        cityArray()
    }
    
    private func cityArray() {
        guard let jsonURL = Bundle.main.path(forResource: "citys", ofType: "json") else {return}
        guard let jsonString = try? String(contentsOf: URL(fileURLWithPath: jsonURL), encoding: String.Encoding.utf8) else {return}
        
        var cityRuEn: JsonModel!
        let decoder = JSONDecoder()
        
        do {
            cityRuEn = try decoder.decode(JsonModel.self, from: Data(jsonString.utf8))
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        guard let result = cityRuEn else {return}
        cityRuArray = result.cityRu
        cityEnArray = result.cityEn
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityRuArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = cityRuArray[indexPath.row]
        cell.backgroundColor = #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let city = cityEnArray[indexPath.row]
        self.delegate.cityName(city: city)
        dismiss(animated: true)
    }
}
