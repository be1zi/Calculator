//
//  MainScreenCollectionViewCellModel.swift
//  Calculator
//
//  Created by Konrad Belzowski on 27/11/2020.
//

import UIKit

public struct MainScreenCollectionViewCellModel {
    
    //
    // MARK: - Properties
    //
    
    public let operation: Operations?
    public let title: String
    public let color: UIColor
    public let numericValue: Int?
    
    //
    // MARK: - Init
    //
    
    public init(title: String, color: UIColor, numericValue: Int) {
        self.title = title
        self.color = color
        self.numericValue = numericValue
        self.operation = nil
    }
    
    public init(color: UIColor, operation: Operations) {
        self.title = operation.rawValue
        self.color = color
        self.numericValue = nil
        self.operation = operation
    }
}
