//
//  ProductCell.swift
//  SevenCApp
//
//  Created by Mohamed Elsayed on 01/11/2023.
//

import UIKit

class CategoryThumbnailCell: UICollectionViewCell {
    // MARK: - View Component
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
       
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Font.bold14.font
        label.textColor = DesignSystem.Color.white.color
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

// MARK: - configureUI

extension CategoryThumbnailCell {
    
    func configureUI(model: HomeModel.HomeItem){
        let url = URL(string: model.image)
        imageView.kf.setImage(with: url)
        titleLabel.text = model.name
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        let maskView = UIView()
        maskView.backgroundColor = DesignSystem.Color.lightGreyMask.color
        addSubview(maskView)
        maskView.translatesAutoresizingMaskIntoConstraints = false
        maskView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        maskView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        maskView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        maskView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.topAnchor.constraint(greaterThanOrEqualTo: topAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: 20).isActive = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}

