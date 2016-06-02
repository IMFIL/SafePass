//
//  CheckBox.swift
//  SafePass
//
//  Created by Filip Slatinac on 2016-04-30.
//  Copyright © 2016 Filip. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    
    let Checked = UIImage(named: "checked_checkbox")! as UIImage
    let UnChecked = UIImage (named: "unchecked_checkbox")! as UIImage
    
    var isChecked: Bool = false{
        didSet{
            if(isChecked){
                self.setImage(Checked, forState: .Normal)
            }
            else{
                self.setImage(UnChecked, forState: .Normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBox.buttonClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    
    func buttonClicked(sender: UIButton){
        if(sender == self){
            if(isChecked){
                isChecked = false
            }
            else {
                isChecked = true
            }
        }
    }

 

}
