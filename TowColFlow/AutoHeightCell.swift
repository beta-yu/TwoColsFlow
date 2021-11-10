//
//  AutoHeightCell.swift
//  TowColFlow
//
//  Created by Yu Qi on 2021/11/10.
//

import UIKit

class AutoHeightCell: UICollectionViewCell {
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        contentView.addSubview(label)
        return label
    }()
    
    var title: String? {
        didSet {
            label.text = title
            label.sizeToFit()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.center = contentView.center
    }
}
