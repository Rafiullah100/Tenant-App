//
//  ServicesViewController.swift
//  Raabt2
//
//  Created by Ngc on 10/07/2024.
//

import UIKit

class CompanyWorkerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var searchButtonView: UIView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var categoryCollectionView: UICollectionView!{
        didSet{
            categoryCollectionView.register(UINib(nibName: "CompanyWorkerCategoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CompanyWorkerCategoryCollectionViewCell.identifier)
            categoryCollectionView.delegate = self
            categoryCollectionView.dataSource = self
        }
    }
    
    @IBOutlet weak var workerCollectionView: UICollectionView!{
        didSet{
            workerCollectionView.register(UINib(nibName: "CompanyWorkerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CompanyWorkerCollectionViewCell.identifier)
            workerCollectionView.delegate = self
            workerCollectionView.dataSource = self
        }
    }
    
    
    var row: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        searchView.clipsToBounds = true
        searchButtonView.clipsToBounds = true
        textField.textAlignment = Helper.shared.isRTL() ? .right : .left
        textField.placeholder = LocalizationKeys.selectBranch.rawValue.localizeString()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == categoryCollectionView {
            let cell = categoryCollectionView.dequeueReusableCell(withReuseIdentifier: CompanyWorkerCategoryCollectionViewCell.identifier, for: indexPath) as! CompanyWorkerCategoryCollectionViewCell
                    
            if row == indexPath{
                cell.servicesBgView.backgroundColor = .black
            }else{
                cell.servicesBgView.backgroundColor = .white
            }
            
            return cell
            
        }else{
            let cell = workerCollectionView.dequeueReusableCell(withReuseIdentifier: CompanyWorkerCollectionViewCell.identifier, for: indexPath)as! CompanyWorkerCollectionViewCell
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView {
            row = indexPath
            collectionView.reloadData()
        }
        else{
            Switcher.gotoWorkerListScreen(delegate: self)
        }
    }
}

extension CompanyWorkerViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == categoryCollectionView {
            return CGSize(width: 65, height: 75)
        }
        else{
            let cellsAcross: CGFloat = 2
            let spaceBetweenCells: CGFloat = 10
            let width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
            return CGSize(width: width, height: 170)
        }
    }
}


