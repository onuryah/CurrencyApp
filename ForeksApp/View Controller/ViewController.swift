//
//  ViewController.swift
//  ForeksApp
//
//  Created by Ceren Çapar on 20.01.2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var popUpButton: UIButton!
    @IBOutlet weak var secondPopUpButton: UIButton!
    var currencyArray : Currency?
    var currencyDetails : Welcome?
    var followerCurrencyArray : Currency?
    var followerDetails : Welcome?
    var repeatTimer : Timer?
    var selectedRow = 0{
        didSet{
            fetchData()
        }
    }
    var selectedRowTwo = 0{
        didSet{
            fetchData()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegatesAndColour()
        fetchData()
        repeatSettings()

    }
    @IBAction func popUpButtonClicked(_ sender: Any) {
        repeatTimer?.invalidate()
          repeatTimer = nil
        
        let vc = UIViewController()
        let screenWidth = UIScreen.main.bounds.width - 10
        let screenHeight = UIScreen.main.bounds.height/2
        vc.preferredContentSize = CGSize(width: screenWidth, height: screenHeight)
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(selectedRow, inComponent: 0, animated: false)
        pickerView.selectRow(selectedRowTwo, inComponent: 1, animated: false)
        vc.view.addSubview(pickerView)
        pickerView.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor).isActive = true
        vc.view.addSubview(pickerView)
        
        
        let alert = UIAlertController(title: "Test", message: "Select", preferredStyle: .actionSheet)
        alert.popoverPresentationController?.sourceView = popUpButton
        alert.popoverPresentationController?.sourceRect = popUpButton.bounds
        
        alert.setValue(vc, forKey: "contentViewController")
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { UIAlertAction in
            self.repeatSettings()
        }))
        
        alert.addAction(UIAlertAction(title: "Select", style: .default, handler: { UIAlertAction in
            self.selectedRow = pickerView.selectedRow(inComponent: 0)
            self.selectedRowTwo = pickerView.selectedRow(inComponent: 1)
            let selected = self.currencyArray?.mypage[self.selectedRow].name
            let selectedTwo = self.currencyArray?.mypage[self.selectedRowTwo].name
            let name = selected
            let nameTwo = selectedTwo
            self.popUpButton.setTitle(name, for: .normal)
            self.secondPopUpButton.setTitle(nameTwo, for: .normal)
            
            let selectedKey = self.currencyArray?.mypage[self.selectedRow].key
            let secondSelectedKey = self.currencyArray?.mypage[self.selectedRowTwo].key
            self.repeatSettings()
            if let selectedKey = selectedKey{
                if let secondSelectedKey = secondSelectedKey {
                    UserSingleton.keyOne = selectedKey
                    UserSingleton.keyTwo = secondSelectedKey
                }
            }
            
            
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    


}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource{
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let screenWidth = UIScreen.main.bounds.width - 10
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 30))
        label.text = currencyArray?.mypage[row].name
        label.sizeToFit()
        return label
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pickerCount = currencyArray?.mypage.count else{return 0}
        return pickerCount
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let elma = self.currencyArray?.mypageDefaults.count else{return 0}
            return elma
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CurrencyCell
        cell.currencyNameLabelField.text = currencyArray?.mypageDefaults[indexPath.row].cod
        
        
        
        switch UserSingleton.keyOne {
        case "las":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].las
        case "pdd":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].pdd
        case "ddi":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].ddi
            if let string = currencyDetails?.l[indexPath.row].ddi{
                let formattedStr = string.replacingOccurrences(of: ",", with: ".")
                if let double = Double(String(formattedStr)){
                    if double > 0{
                        cell.firstQueryLabelField.textColor = UIColor.green
                    }else if double < 0{
                        cell.firstQueryLabelField.textColor = UIColor.red
                    }else{
                        cell.firstQueryLabelField.textColor = UIColor.white
                    }
                    
                }
            }
        case "low":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].low
        case "hig":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].hig
        case "buy":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].buy
        case "sel":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].sel
        case "pdc":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].pdc
        case "cei":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].cei
        case "flo":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].flo
        case "gco":cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].gco
        default:
            cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].las
        }
        
        
        switch UserSingleton.keyTwo {
        case "las":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].las
        case "pdd":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].pdd
        case "ddi":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].ddi
            if let string = currencyDetails?.l[indexPath.row].ddi{
                let formattedStr = string.replacingOccurrences(of: ",", with: ".")
                if let double = Double(String(formattedStr)){
                    if double > 0{
                        cell.seconQueryLabelField.textColor = UIColor.green
                    }else if double < 0{
                        cell.seconQueryLabelField.textColor = UIColor.red
                    }else{
                        cell.seconQueryLabelField.textColor = UIColor.white
                    }
                }
            }
            
        case "low":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].low
        case "hig":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].hig
        case "buy":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].buy
        case "sel":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].sel
        case "pdc":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].pdc
        case "cei":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].cei
        case "flo":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].flo
        case "gco":cell.seconQueryLabelField.text = currencyDetails?.l[indexPath.row].gco
        default:
            cell.firstQueryLabelField.text = currencyDetails?.l[indexPath.row].las
        }
        cell.cloLabelField.text = currencyDetails?.l[indexPath.row].clo
        if currencyDetails?.l[indexPath.row].clo != followerDetails?.l[indexPath.row].clo{
            cell.cloLabelField.font = UIFont.systemFont(ofSize: 22)
            
        }else {
            cell.cloLabelField.font = UIFont.systemFont(ofSize: 15)
        }
        
        
        
        
        
        if let string = self.currencyDetails?.l[indexPath.row].las {
            let formatted = string.replacingOccurrences(of: ".", with: "")
            let formattedStr = formatted.replacingOccurrences(of: ",", with: ".")
            if let double = Double(String(formattedStr)){
                if let follower = self.followerDetails?.l[indexPath.row].las{
                    let formattedFollower = follower.replacingOccurrences(of: ".", with: "")
                    let formattedStrFollower = formattedFollower.replacingOccurrences(of: ",", with: ".")
                    if let doubleFollower = Double(String(formattedStrFollower)){
                        if double > doubleFollower{
                            cell.lasDifImageView.image = UIImage(named: "artis")
                        }else if double < doubleFollower{
                            cell.lasDifImageView.image = UIImage(named: "azalis")
                        }else{
                            cell.lasDifImageView.image = UIImage(named: "sabit")
                        }
                    }
                }
            }
        }
        
        
        
        return cell
    }
    fileprivate func setDelegatesAndColour(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.backgroundColor = .black
    }
    
    func fetchData(){
        let urlString = UrlClass().baseUrl+UrlClass().homePageHeader
        Webservice.fetchData(urlString: urlString, tableView: tableView, model: Currency.self) { currencies in
            self.currencyArray = currencies
            if UserSingleton.keyOne == "" && UserSingleton.keyTwo == ""{
                UserSingleton.keyOne = "las"
                UserSingleton.keyTwo = "pdd"
            }
            var urlString = UrlClass().baseUrl+UrlClass().fields+"\(UserSingleton.keyOne),\(UserSingleton.keyTwo)"+"&stcs="
            self.currencyArray?.mypageDefaults.forEach({ key in
                let requestKey = "\(key.tke)~"
                urlString = urlString+requestKey
            })
            let cleanUrlString = String(urlString.dropLast())
            
            Webservice.fetchData(urlString: cleanUrlString, tableView: self.tableView, model: Welcome.self) { details in
                self.currencyDetails = details
            }
        }
    }
    
    func repeatSettings(){
        repeatTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(repeating), userInfo: nil, repeats: true)
    }
    
    @objc func repeating(){
        self.followerCurrencyArray = self.currencyArray
        self.followerDetails = self.currencyDetails
        fetchData()
        
    }
    

    
    

    
}



/*
 let urlString = UrlClass().baseUrl+UrlClass().homePageHeader
 Webservice.fetchData(urlString: urlString, tableView: tableView, model: Currency.self) { currencies in
     self.currencyArray = currencies
     if UserSingleton.keyOne == "" && UserSingleton.keyTwo == ""{
         UserSingleton.keyOne = "flo"
         UserSingleton.keyTwo = "flo"
     }
     var urlString = UrlClass().baseUrl+UrlClass().fields+"\(UserSingleton.keyOne),\(UserSingleton.keyTwo)"+"&stcs="
     self.currencyArray?.mypageDefaults.forEach({ key in
         let requestKey = "\(key.tke)~"
         urlString = urlString+requestKey
     })
     let cleanUrlString = String(urlString.dropLast())
     print("kontrol: \(cleanUrlString)")
     
     Webservice.fetchData(urlString: cleanUrlString, tableView: self.tableView, model: Welcome.self) { details in
         print("yes be")
         self.currencyDetails = details
         print("kontrol: \(details)")
     }
 }
 */
