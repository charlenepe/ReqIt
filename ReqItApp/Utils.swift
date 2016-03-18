//
//  Utils.swift
//  ReqItApp
//
//  Created by Jitendra Gaur on 18/03/16.
//  Copyright © 2016 Charlene Pe. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    static func showAlertWithoutHandler(title: String, msg: String, view: UIViewController) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
        alert.addAction(action)
        view.presentViewController(alert, animated: true, completion: nil)
    }
    
    static func showAlert(title: String, msg: String) -> UIAlertController{
        return UIAlertController(title: title, message: msg, preferredStyle: .Alert)
    }
}
