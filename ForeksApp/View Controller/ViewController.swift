//
//  ViewController.swift
//  ForeksApp
//
//  Created by Ceren Çapar on 20.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var currencyArray : Currency?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        fetchData()
        fetchDetails()
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let elma = self.currencyArray?.mypageDefaults.count else{return 0}
            return elma
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        cell.currencyNameLabelField.text = currencyArray?.mypageDefaults[indexPath.row].cod
        return cell
    }
    fileprivate func setDelegates(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func fetchData(){
        let urlString = UrlClass().baseUrl+UrlClass().homePageHeader
        
        Webservice.fetchData(urlString: urlString, tableView: tableView, model: Currency.self) { annah in
            self.currencyArray = annah
        }
    }
    
    func fetchDetails(){
        self.currencyArray?.mypageDefaults.forEach({ key in
            let urlString = UrlClass().baseUrl+UrlClass().fields+"\(key)"
            Webservice.fetchData(urlString: urlString, tableView: tableView, model: Welcome.self) { annah in
                print("kontrol : \(annah)")
            }
        })
    }
    
    

    
}

