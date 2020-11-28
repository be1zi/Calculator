//
//  MainScreenViewController.swift
//  Calculator
//
//  Created by Konrad Belzowski on 27/11/2020.
//

import UIKit

public class MainScreenViewController: UIViewController {
    
    //
    // MARK: - Properties
    //
    
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!

    private var viewModel: MainScreenViewModel = MainScreenViewModel()
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        configurateCollectionView()
    }
    
    //
    // MARK: - Method
    //
    
    private func configurateCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        collectionView.contentInset = UIEdgeInsets(top: Constant.margin, left: Constant.margin, bottom: Constant.margin, right: Constant.margin)
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func registerCell() {
        let nibName = String(describing: MainScreenCollectionViewCell.self)
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
    }
    
    private func getDefaultHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - 2 * Constant.margin - 3 * Constant.collectionViewInteritemSpacing) / 4.0
    }
}

extension MainScreenViewController: UICollectionViewDataSource {
   
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.buttonsViewModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainScreenCollectionViewCell", for: indexPath) as? MainScreenCollectionViewCell,
              viewModel.buttonsViewModels.indices.contains(indexPath.row) else {
            return UICollectionViewCell()
        }
        
        cell.model = viewModel.buttonsViewModels[indexPath.row]
        cell.corner = getDefaultHeight() / 2.0
        return cell
    }
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat
        let width: CGFloat
        
        if let number = viewModel.buttonsViewModels[indexPath.row].numericValue, number == 0 {
            height = getDefaultHeight()
            width = (UIScreen.main.bounds.width - 2 * Constant.margin - Constant.collectionViewInteritemSpacing) / 2.0
        } else {
            height = getDefaultHeight()
            width = height
        }
        
        return CGSize(width: width, height: height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.collectionViewInteritemSpacing
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return Constant.collectionViewLineSpacing
    }
}
