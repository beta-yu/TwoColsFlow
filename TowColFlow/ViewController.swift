//
//  ViewController.swift
//  TowColFlow
//
//  Created by Yu Qi on 2021/11/10.
//

import UIKit

class ViewController: UIViewController {
    
    var collectionView: UICollectionView!
    let itemCount = 50
    let itemsHeight = (0..<50).map { _ in
        CGFloat(arc4random_uniform(150) + 50)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "TwoColFlow"
        let layout = TwoColFlowLayout()
        layout.delegate = self
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AutoHeightCell.self, forCellWithReuseIdentifier: "AutoHeightCell")
    }

}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AutoHeightCell", for: indexPath)
        if let cell = cell as? AutoHeightCell {
            cell.title = "\(indexPath.item + 1)"
            cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .green
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
}

extension ViewController: TwoColFlowLayoutDelegate {
    func towColFlowLayout(_ towColFlowLayout: TwoColFlowLayout, itemHeight indexPath: IndexPath) -> CGFloat {
        return itemsHeight[indexPath.item]
    }
}

