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
        collectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    private func registerCell() {
        let nibName = String(describing: MainScreenCollectionViewCell.self)
        collectionView.register(UINib(nibName: nibName, bundle: nil), forCellWithReuseIdentifier: nibName)
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
        
        return cell
    }
}

extension MainScreenViewController: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = (UIScreen.main.bounds.width - 5 * 16.0) / 4.0

        return CGSize(width: size, height: size)
    }
}
