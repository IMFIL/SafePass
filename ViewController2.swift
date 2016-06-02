//
//  ViewController2.swift
//  SafePass
//
//  Created by Filip Slatinac on 2016-04-30.
//  Copyright © 2016 Filip. All rights reserved.
//

import UIKit
import Foundation

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffleArray()
    {
        for _ in 0..<10
        {
            sortInPlace { (_,_) in arc4random() < arc4random() }
        }
    }
}

class ViewController2: ViewController {
    
    
    var SymbolBool = false
    var NumberBool = false
    var CapitalBool = false
    
    var randomNumberSymbol: [Int] = []
    var randomNumberNumber: [Int] = []
    var randomNumberCapital: [Int] = []
    var OtherCharacters:[Int] = []
    var SetCharacters: [String] = []
    
    
    @IBOutlet weak var SetCharacterLabel: UILabel!
    
    @IBOutlet weak var LengthTF: UITextField!

    
    
    var LengthOfPass: Int?{
        //Max is 20
        if(LengthTF.text! == ""){
            
            return 10
            
        }
        
        else if (Int(LengthTF.text!) > 20){
            
            return 20

        }
        
        else if (Int(LengthTF.text!) <= 5){
            
            return 10
            
        }
        
        else{
            return Int(LengthTF.text!)
        }
    }
    
    func RandomNumberGenerator(limit: Int) -> Int{
        return Int(arc4random_uniform(UInt32(limit)))
        
    }
    
    var numberOfSymbols: Int?{
        if (SymbolBool){
            var  number = RandomNumberGenerator(Int(LengthOfPass!/3))
            while (number == 0){
                number = RandomNumberGenerator(Int(LengthOfPass!/3))
            }
            return number
        }
        return 0
    }
    
    
    var numberOfNumbers: Int?{
        if (NumberBool){
            var  number = RandomNumberGenerator(Int(LengthOfPass!/3))
            while (number == 0){
                number = RandomNumberGenerator(Int(LengthOfPass!/3))
            }
            return number
        }
        return 0
    }
    
    
    var numberOfCapitals: Int?{
        if (CapitalBool){
            var  number = RandomNumberGenerator(Int(LengthOfPass!/3))
            while (number == 0){
                number = RandomNumberGenerator(Int(LengthOfPass!/3))
            }
            return number
        }
        return 0
    }
    
    
    
    
    
    
    @IBAction func SymbolsButton(sender: AnyObject) {
        if (SymbolBool){
            SymbolBool = false
        }
        else{
            SymbolBool = true
        }
        

    }
    

    @IBAction func CapitalButton(sender: AnyObject) {
        if (CapitalBool){
            CapitalBool = false
        }
        else{
            CapitalBool = true
        }

    }

    @IBAction func NumberButton(sender: AnyObject) {
        
        if (NumberBool){
            NumberBool = false
        }
        else{
            NumberBool = true
        }

    }

    
    
    @IBOutlet weak var SetCharacterTF: UITextField!
    
    
    @IBOutlet weak var PlateFormTF: UITextField!
    
    
    @IBAction func AddTFButton(sender: AnyObject) {
        var added: String = ""
        if(SetCharacterTF.text != ""){
        SetCharacters.append(SetCharacterTF.text!)
        }
        
        for i in SetCharacters{
           added += i
           added += "\n"
        }
        if(added != ""){
        SetCharacterLabel.text = added
        }
        
    }
    
    

    
    func PassWordGen() -> String{
        
        
        var NSCounter = 0
        var NNCounter = 0
        var NCCounter = 0
        
        var passwordArray: [String] = []
        
        var OtherCharactersCounter = 0
        
        randomNumberCapital = []
        randomNumberNumber = []
        randomNumberSymbol = []
        OtherCharacters = []
        
        var password = ""
        
        if (SymbolBool){
            while NSCounter < numberOfSymbols{
                randomNumberSymbol.append(33 + Int(arc4random_uniform(14)))
                NSCounter += 1
            }
            randomNumberSymbol.shuffleArray()
        }
        
        if (NumberBool){
            while NNCounter < numberOfNumbers{
                randomNumberNumber.append(Int(arc4random_uniform(9)))
                NNCounter += 1
            }
            randomNumberNumber.shuffleArray()
        }
        
        if (CapitalBool){
            while NCCounter < numberOfCapitals{
                randomNumberCapital.append(65 + Int(arc4random_uniform(26)))
                NCCounter += 1
            }
            randomNumberCapital.shuffleArray()
        }
        
        
        if (LengthTF.text == "" || Int(LengthTF.text!) > 20 || Int(LengthTF.text!) <= 5){
            
            LengthTF.text = "10"
            
        }
        
        while OtherCharactersCounter < Int(LengthTF.text!)! - (randomNumberSymbol.count + randomNumberNumber.count + randomNumberCapital.count){
            
            OtherCharacters.append(97 + Int(arc4random_uniform(26)))
            OtherCharactersCounter += 1
        }
        
        
        OtherCharacters.shuffleArray()
        
        
        if(randomNumberSymbol.count > 0){
            for i in randomNumberSymbol{
                passwordArray.append(String(UnicodeScalar(i)))
            }
        }
        
        
        if(randomNumberNumber.count > 0){
            for i in randomNumberNumber{
                passwordArray.append(String(i))
            }
        }
        
        
        if(randomNumberCapital.count > 0){
            for i in randomNumberCapital{
                passwordArray.append(String(UnicodeScalar(i)))
            }
        }
        
        
        if(OtherCharacters.count > 0) {
            for i in OtherCharacters{
                passwordArray.append(String(UnicodeScalar(i)))
            }
        }
        
        passwordArray.shuffleArray()
        
        
        for i in passwordArray{
            password += i
        }
        
        
        return password
        
        
    }
    
    func Reset(){
        
        let title = "Confirm Password"
            let message = "Your password is: " + PassWordGen() + " for " + PlateFormTF.text!
            
            let alert = UIAlertController(title: title, message: message,preferredStyle:  UIAlertControllerStyle.Alert)
            
            let button = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
            
            let button2 = UIAlertAction(title: "Reset",style: UIAlertActionStyle.Default, handler: {action in
            self.Reset()
            })
            
            alert.addAction(button)
            alert.addAction(button2)
            
            presentViewController(alert,animated: true, completion: nil)

    }
    
 
    @IBAction func GenerateButton(sender: AnyObject) {
        SetCharacters = []
        
        if (PlateFormTF.text == ""){
            let title = "Missing platform"
            let message = "Indicate the corresponding platform"
            
            let alert = UIAlertController(title: title, message: message,preferredStyle:  UIAlertControllerStyle.Alert)
            
            let button = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            
            alert.addAction(button)
            
            presentViewController(alert,animated: true, completion: nil)
            
        }
        
        else{
            
            let title = "Confirm Password"
            let message = "Your password is: " + PassWordGen() + "for " + PlateFormTF.text!
            
            let alert = UIAlertController(title: title, message: message,preferredStyle:  UIAlertControllerStyle.Alert)
        
            let button = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Cancel, handler: nil)
            
            let button2 = UIAlertAction(title: "Reset",style: UIAlertActionStyle.Default, handler: {action in
            self.Reset()
            })
            
            alert.addAction(button)
            alert.addAction(button2)
            
            presentViewController(alert,animated: true, completion: nil)
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LengthTF.keyboardType = .NumberPad
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
