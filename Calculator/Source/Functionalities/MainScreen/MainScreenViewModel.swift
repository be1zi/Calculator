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
    
    public private(set) var cellName = String(describing: MainScreenTableViewCell.self)
    public private(set) var buttonsViewModels = [MainScreenTableViewCellModel]()

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
        buttonsViewModels = [MainScreenTableViewCellModel(title: "AC", color: UIColor.gray, operation: .clear),
                             MainScreenTableViewCellModel(title: "+/-", color: UIColor.gray, operation: .changeSign),
                             MainScreenTableViewCellModel(title: "%", color: UIColor.gray, operation: .percent),
                             MainScreenTableViewCellModel(title: "%", color: UIColor.orange, operation: .divide),
                             MainScreenTableViewCellModel(title: "7", color: UIColor.darkGray, numericValue: 7),
                             MainScreenTableViewCellModel(title: "8", color: UIColor.darkGray, numericValue: 8),
                             MainScreenTableViewCellModel(title: "9", color: UIColor.darkGray, numericValue: 9),
                             MainScreenTableViewCellModel(title: "X", color: UIColor.darkGray, operation: .multiply),
                             MainScreenTableViewCellModel(title: "4", color: UIColor.darkGray, numericValue: 4),
                             MainScreenTableViewCellModel(title: "5", color: UIColor.darkGray, numericValue: 5),
                             MainScreenTableViewCellModel(title: "6", color: UIColor.darkGray, numericValue: 6),
                             MainScreenTableViewCellModel(title: "-", color: UIColor.darkGray, operation: .sub),
                             MainScreenTableViewCellModel(title: "1", color: UIColor.darkGray, numericValue: 1),
                             MainScreenTableViewCellModel(title: "2", color: UIColor.darkGray, numericValue: 2),
                             MainScreenTableViewCellModel(title: "3", color: UIColor.darkGray, numericValue: 3),
                             MainScreenTableViewCellModel(title: "+", color: UIColor.darkGray, operation: .add),
                             MainScreenTableViewCellModel(title: "0", color: UIColor.darkGray, numericValue: 0),
                             MainScreenTableViewCellModel(title: ",", color: UIColor.darkGray, operation: .comma),
                             MainScreenTableViewCellModel(title: "=", color: UIColor.darkGray, operation: .equal)]
    }
}
