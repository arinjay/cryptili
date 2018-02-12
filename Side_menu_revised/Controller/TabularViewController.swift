//
//  TabularViewController.swift
//  Cryptili
//
//  Created by Arinjay on 23/01/18.
//  Copyright © 2018 Arinjay. All rights reserved.
//

import UIKit

class TabularViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!{
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var heros = [Herostats]()
    var imgArray : [UIImage] = [
                                UIImage(named: "icon1.png")!, UIImage(named: "icon2.png")!, UIImage(named: "icon3.png")!
                                , UIImage(named: "icon1.png")!, UIImage(named: "icon5.jpg")!, UIImage(named: "icon6.png")!,
                                UIImage(named: "icon7.png")!, UIImage(named: "icon8.png")!, UIImage(named: "icon9.png")!,UIImage(named: "icon1.png")!
                                ]

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            //print("successful")
            self.tableView.reloadData()
        }
        
        
        
        
        
        // using Custom Xib file
        tableView.register(UINib(nibName: "customnib", bundle: nil), forCellReuseIdentifier: "showData")
        
        self.tableView.backgroundColor = UIColor.init(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        configureTableView()
        
        
        //tranparent navigation bar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
    
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showData", for: indexPath) as! CustomTableViewCell
        
        cell.label1.text = heros[indexPath.row].name
        cell.label2.text = "$" + heros[indexPath.row].price_usd
        cell.imgView.image = imgArray[indexPath.row]
        
        
        // Changing color of labels
        if checkForPrice(data: Double(heros[indexPath.row].percent_change_1h)!){
            cell.label3.text = "1h: " + heros[indexPath.row].percent_change_1h + " %"
            cell.label3.textColor = UIColor.red
        }else {
            cell.label3.text = "1h: " + heros[indexPath.row].percent_change_1h + " %"
        }
        
        if checkForPrice(data: Double(heros[indexPath.row].percent_change_24h)!){
            cell.label4.text = "1d: " + heros[indexPath.row].percent_change_24h + " %"
            cell.label4.textColor = UIColor.red
        }else{
            cell.label4.text = "1d: " + heros[indexPath.row].percent_change_24h + " %"
        }
        
        if checkForPrice(data: Double(heros[indexPath.row].percent_change_7d)!){
            cell.label5.text = "7d: " + heros[indexPath.row].percent_change_7d + " %"
            cell.label5.textColor = UIColor.red
        }else {
            cell.label5.text = "7d: " + heros[indexPath.row].percent_change_7d + " %"
        }
        
        return cell
    }
    
    
    // adjusting tableView height
    func configureTableView(){
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 130
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
    // helper function for checking price
    func checkForPrice(data: Double) -> Bool{
        return data > 0 ? false : true
    }
    
    
    func downloadJSON(completed: @escaping () -> ()) {
        let url = URL(string: "https://api.coinmarketcap.com/v1/ticker/?limit=10")
        
        //URLSession.shared.dataTask(with: url!) { (data, response, error) in
        URLSession.shared.dataTask(with: url!) { [weak self](data, response, error) in
            
        
            if error == nil {
                do
                {
                    self?.heros = try JSONDecoder().decode([Herostats].self, from: data!)
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch {
                    print("Json error")
                }
            }
            }.resume()
    }
    
    
}
