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

    private var viewModel: MainScreenViewModel?
    
    //
    // MARK: - Lifecycle
    //
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MainScreenViewModel()
    }
}

extension MainScreenViewController: UICollectionViewDataSource {
   
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.buttonsViewModels.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: viewModel?.cellName ?? "", for: indexPath) as? MainScreenTableViewCell,
              let _ = viewModel?.buttonsViewModels.indices.contains(indexPath.row) else {
            return UICollectionViewCell()
        }
        
        cell.model = viewModel?.buttonsViewModels[indexPath.row]
        
        return cell
    }
}
