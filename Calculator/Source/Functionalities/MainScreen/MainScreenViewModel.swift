//
//  MainScreenViewModel.swift
//  Calculator
//
//  Created by Konrad Belzowski on 27/11/2020.
//

import UIKit

public enum Operations: Int {
    
    case comma
    case equal
    case add
    case sub
    case multiply
    case divide
    case percent
    case changeSign
    case clear
}

public class MainScreenViewModel {
 
    //
    // MARK: - Properties
    //
    
    public private(set) var cellName = String(describing: MainScreenCollectionViewCell.self)
    public private(set) var buttonsViewModels = [MainScreenCollectionViewCellModel]()

    //
    // MARK: - Init
    //
    
    public init() {
        prepareButtonsViewModels()
    }
    
    //
    // MARK: - Methods
    //
    
    private func prepareButtonsViewModels() {
        buttonsViewModels = [MainScreenCollectionViewCellModel(title: "AC", color: UIColor.gray, operation: .clear),
                             MainScreenCollectionViewCellModel(title: "+/-", color: UIColor.gray, operation: .changeSign),
                             MainScreenCollectionViewCellModel(title: "%", color: UIColor.gray, operation: .percent),
                             MainScreenCollectionViewCellModel(title: "/", color: UIColor.orange, operation: .divide),
                             MainScreenCollectionViewCellModel(title: "7", color: UIColor.darkGray, numericValue: 7),
                             MainScreenCollectionViewCellModel(title: "8", color: UIColor.darkGray, numericValue: 8),
                             MainScreenCollectionViewCellModel(title: "9", color: UIColor.darkGray, numericValue: 9),
                             MainScreenCollectionViewCellModel(title: "X", color: UIColor.orange, operation: .multiply),
                             MainScreenCollectionViewCellModel(title: "4", color: UIColor.darkGray, numericValue: 4),
                             MainScreenCollectionViewCellModel(title: "5", color: UIColor.darkGray, numericValue: 5),
                             MainScreenCollectionViewCellModel(title: "6", color: UIColor.darkGray, numericValue: 6),
                             MainScreenCollectionViewCellModel(title: "-", color: UIColor.orange, operation: .sub),
                             MainScreenCollectionViewCellModel(title: "1", color: UIColor.darkGray, numericValue: 1),
                             MainScreenCollectionViewCellModel(title: "2", color: UIColor.darkGray, numericValue: 2),
                             MainScreenCollectionViewCellModel(title: "3", color: UIColor.darkGray, numericValue: 3),
                             MainScreenCollectionViewCellModel(title: "+", color: UIColor.orange, operation: .add),
                             MainScreenCollectionViewCellModel(title: "0", color: UIColor.darkGray, numericValue: 0),
                             MainScreenCollectionViewCellModel(title: ",", color: UIColor.darkGray, operation: .comma),
                             MainScreenCollectionViewCellModel(title: "=", color: UIColor.orange, operation: .equal)]
    }
    
    public func buttonDidTapped(model: MainScreenCollectionViewCellModel) {
        
    }
}
