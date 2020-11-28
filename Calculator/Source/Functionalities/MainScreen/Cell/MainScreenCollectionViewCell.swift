//
//  MainScreenCollectionViewCell.swift
//  Calculator
//
//  Created by Konrad Belzowski on 27/11/2020.
//

import UIKit

public class MainScreenCollectionViewCell: UICollectionViewCell {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var button: UIButton!
    
    public var model: MainScreenCollectionViewCellModel? {
        didSet {
            setData()
        }
    }
    
    //
    // MARK: - Method
    //
    
    private func setData() {
        
        guard let viewModel = model else { return }
        
        button.setTitle(viewModel.title, for: .normal)
        button.backgroundColor = viewModel.color
    }
}
