//
//  UIView.swift
//  Calculator
//
//  Created by Konrad Belzowski on 28/11/2020.
//

import UIKit

extension UIView {
    
    @IBInspectable var corner: CGFloat {
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
}
