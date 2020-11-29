//
//  MainScreenViewModel.swift
//  Calculator
//
//  Created by Konrad Belzowski on 27/11/2020.
//

import UIKit
import RxSwift

public enum Operations: String {
    
    case comma = ","
    case equal = "="
    case add = "+"
    case sub = "-"
    case multiply = "x"
    case divide = "/"
    case percent = "%"
    case changeSign = "+/-"
    case clear = "AC"
    
    public func getPriority() -> Int {
        switch self {
        case .add, .sub:
            return 1
        case .multiply, .divide:
            return 2
        default:
            return 0
        }
    }
    
    public func immediateActionButton() -> Bool {
        switch self {
        case .clear, .changeSign, .percent, .comma:
            return true
        default:
            return false
        }
    }
}

public class MainScreenViewModel {
 
    //
    // MARK: - Properties
    //
    
    public private(set) var cellName = String(describing: MainScreenCollectionViewCell.self)
    public private(set) var buttonsViewModels = [MainScreenCollectionViewCellModel]()
    private var numbersArray = [Double]()
    private var operationsArray = [Operations]()
    private var currentNumberString = ""
    private var lastButtonTappedModel: MainScreenCollectionViewCellModel?
    public let resultSubject = PublishSubject<String>()
    
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
        buttonsViewModels = [MainScreenCollectionViewCellModel(color: UIColor.lightGray, operation: .clear),
                             MainScreenCollectionViewCellModel(color: UIColor.lightGray, operation: .changeSign),
                             MainScreenCollectionViewCellModel( color: UIColor.lightGray, operation: .percent),
                             MainScreenCollectionViewCellModel(color: UIColor.orange, operation: .divide),
                             MainScreenCollectionViewCellModel(title: "7", color: UIColor.darkGray, numericValue: 7),
                             MainScreenCollectionViewCellModel(title: "8", color: UIColor.darkGray, numericValue: 8),
                             MainScreenCollectionViewCellModel(title: "9", color: UIColor.darkGray, numericValue: 9),
                             MainScreenCollectionViewCellModel(color: UIColor.orange, operation: .multiply),
                             MainScreenCollectionViewCellModel(title: "4", color: UIColor.darkGray, numericValue: 4),
                             MainScreenCollectionViewCellModel(title: "5", color: UIColor.darkGray, numericValue: 5),
                             MainScreenCollectionViewCellModel(title: "6", color: UIColor.darkGray, numericValue: 6),
                             MainScreenCollectionViewCellModel(color: UIColor.orange, operation: .sub),
                             MainScreenCollectionViewCellModel(title: "1", color: UIColor.darkGray, numericValue: 1),
                             MainScreenCollectionViewCellModel(title: "2", color: UIColor.darkGray, numericValue: 2),
                             MainScreenCollectionViewCellModel(title: "3", color: UIColor.darkGray, numericValue: 3),
                             MainScreenCollectionViewCellModel(color: UIColor.orange, operation: .add),
                             MainScreenCollectionViewCellModel(title: "0", color: UIColor.darkGray, numericValue: 0),
                             MainScreenCollectionViewCellModel(color: UIColor.darkGray, operation: .comma),
                             MainScreenCollectionViewCellModel(color: UIColor.orange, operation: .equal)]
    }
    
    public func buttonDidTapped(at indexPath: IndexPath) {
        
        guard buttonsViewModels.indices.contains(indexPath.row) else { return }
        
        let model = buttonsViewModels[indexPath.row]
        
        if let number = model.numericValue {
            numberTapped(number)
        } else if let operation = model.operation {
            numberDidEndEditing()
            
            if operation.immediateActionButton() {
                immediateOperationTapped(operation)
            } else {
                arithmeticOperationTapped(operation)
            }
        }
        
        lastButtonTappedModel = model
    }
    
    private func numberTapped(_ number: Int) {
                
        if let operation = lastButtonTappedModel?.operation, operation == .equal {
            if let lastOperation = operationsArray.last, lastOperation == .equal {
                operationsArray.removeLast()
            }

            currentNumberString = ""
            numbersArray.removeAll()
        }
        
        currentNumberString.append(String(number))
        
        prepareResultValue()
    }
    
    private func numberDidEndEditing() {
        let numberValue = Double(currentNumberString)
        currentNumberString = ""
        
        if let value = numberValue {
            numbersArray.append(value)
        }
    }
    
    private func immediateOperationTapped(_ operation: Operations) {
        
        switch operation {
        case .clear:
            clearOperation()
        case .changeSign:
            changeSignOperation()
        case .percent:
            percentOperation()
        case .comma:
            commaOperation()
        default:
            break
        }
        
        prepareResultValue()
    }
    
    private func arithmeticOperationTapped(_ operation: Operations) {
        
        if let lastOperations = operationsArray.last, lastOperations.getPriority() >= operation.getPriority() {
            calculateSubValue(lastOperationsPriority: operation.getPriority())
        }
        
        if lastButtonTappedModel?.numericValue != nil {
            operationsArray.append(operation)
        } else {
            let _ = operationsArray.popLast()
            operationsArray.append(operation)
        }
        
        if operation == .equal {
            calculateTotalValue()
        }
        
        prepareResultValue()
    }
    
    private func prepareResultValue() {
        
        var result = ""
        
        for (index, item) in numbersArray.enumerated() {
            
            result += String(item)
            
            if operationsArray.indices.contains(index) {
                result += " \(operationsArray[index].rawValue)"
            }
            
            if index < (numbersArray.count - 1) {
                result += " "
            }
        }
        
        if !currentNumberString.isEmpty {
            result += " \(currentNumberString)"
        }
        
        resultSubject.onNext(result)
    }
    
    private func calculateTotalValue() {
        calculateSubValue(lastOperationsPriority: 0)
    }
    
    private func calculateSubValue(lastOperationsPriority: Int) {
                
        while true {
            var result: Double = 0

            guard let operations = operationsArray.popLast() else { return }
            
            if operations.getPriority() < lastOperationsPriority {
                operationsArray.append(operations)
                break
            }
            
            guard let secondNumber = numbersArray.popLast() else { break }
            guard let firstNumber = numbersArray.popLast() else {
                numbersArray.append(secondNumber)
                break
            }
            
            switch operations {
            case .add:
                result = firstNumber + secondNumber
            case .sub:
                result = firstNumber - secondNumber
            case .divide:
                result = firstNumber / secondNumber
            case .multiply:
                result = firstNumber * secondNumber
            default:
                break
            }
            numbersArray.append(result)
        }
    }
    
    //
    // MARK: - Operations
    //
    
    private func clearOperation() {

    }
    
    private func commaOperation() {

    }
    
    private func percentOperation() {
        
    }
    
    private func changeSignOperation() {
        
        if let operations = lastButtonTappedModel?.operation, !operations.immediateActionButton() {
            return
        }
        
        guard var value = numbersArray.last else { return }
        
        numbersArray.removeLast()
        
        value *= -1
        
        numbersArray.append(value)
    }
}
