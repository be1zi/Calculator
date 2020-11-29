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
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
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
        
        nameLabel.text = viewModel.title
        containerView.backgroundColor = viewModel.color
    }
}
