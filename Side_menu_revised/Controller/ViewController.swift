//
//  ViewController.swift
//  Cryptili
//
//  Created by Arinjay on 26/11/17.
//  Copyright © 2017 Arinjay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//extension NSLayoutConstraint {
//
//    override open var description: String {
//        let id = identifier ?? ""
//        return "id: \(id), constant: \(constant)"
//    }
//}

class ViewController: UIViewController {

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var fireButton: UIButton!
    @IBOutlet weak var mailButton: UIButton!
    @IBOutlet weak var notificationButton: UIButton!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var leadingConstraint: NSLayoutConstraint!
    
    
   
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var hourlyChangeLbl2: UILabel!
    @IBOutlet weak var dayChangeLbl: UILabel!
    @IBOutlet weak var marketCapLbl: UILabel!
    @IBOutlet weak var avlSupplyLbl: UILabel!
    @IBOutlet weak var rankLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    
    @IBAction func dismissSideMenu(_ sender: UIButton) {
        leadingConstraint.constant = -120
    }
    let url = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTCINR"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leadingConstraint.constant = -120
        
        // for transparent navbar
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // for removing the line between navbar and view
        navigationController?.navigationBar.shadowImage = UIImage()
        setCustomBackImage()
        
        getBitcoinData(url: url)
    }
    
    
    func getBitcoinData(url: String) {
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                if response.result.isSuccess {
                    
                    print("Sucess! Got the  data")
                    
                    let bitCoinJSON : JSON = JSON(response.result.value!)
                    
                    self.updateBitCoinData(json: bitCoinJSON)
                    
                } else {
                    print("Error: \(String(describing: response.result.error))")
                    //self.bitcoinPriceLabel.text = "Connection Issues"
                }
        }
        
    }
    
    
    func updateBitCoinData(json : JSON) {
        if let bitResult = json["ask"].double{
            let convertResult = String(bitResult)
            priceLbl.text = "₹ " + convertResult
            //bitcoinPriceLabel.text = currencyLogoArray[currencyLogoCount] + " " + convertResult
        }
        if let bitResult2 = json["high"].double{
            let convertResult = String(bitResult2)
            highLbl.text = "₹ " + convertResult
        }
        if let bitresult3 = json["low"].double{
            let convertResult = String(bitresult3)
            hourlyChangeLbl2.text = "₹ " + convertResult
        }
       
        if let bitResult4 = json["changes"]["price"]["day"].double{
            let converResult = String(bitResult4)
            dayChangeLbl.text = "₹ " + converResult
            if checkForPrice(data:  bitResult4) {
                dayChangeLbl.textColor = UIColor.red
            }else{
                dayChangeLbl.textColor = UIColor.green
            }
        }
        if let bitResult5 = json["averages"]["day"].double{
            let converResult = String(bitResult5)
            marketCapLbl.text = "₹ " + converResult
        }
        if let bitResult6 = json["changes"]["percent"]["week"].double{
            let converResult = String(bitResult6)
            avlSupplyLbl.text = converResult + " %"
            if checkForPrice(data: bitResult6) {
                avlSupplyLbl.textColor = UIColor.red
            } else {
                avlSupplyLbl.textColor = UIColor.green
            }
        }
    
        else{
            print("Poor Internet Connection")
        }
        
        
    }

    func checkForPrice(data: Double) -> Bool{
        return data > 0 ? false : true
    }
    
    
    
    // for navigation back button
    func setCustomBackImage(){
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain , target: nil, action: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    // MARK: Slide menu functions:
    @IBAction func showMenu(_ sender: UIBarButtonItem) {
        if(isOpen){
            
            UIView.animate(withDuration: 0.4, animations: {
                self.sideView.alpha = 1
            })
            leadingConstraint.constant = -120
            
            isOpen = !isOpen
        }
        else{
            UIView.animate(withDuration: 0.4, animations: {
                self.sideView.alpha = 1
            })
            leadingConstraint.constant = 0
            
            isOpen = !isOpen
        }
    }
    
    @IBAction func homeButtonPressed(_ sender: UIButton) {
        leadingConstraint.constant = -120
    }
    var isOpen = false
    
    
    
    

}

