//
//  AdsCell.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import UIKit
import Kingfisher

class AdsCell: UICollectionViewCell {
    // MARK: - View Component
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
       
        return imageView
    }()
    
}

// MARK: - configureUI

extension AdsCell {
    
    func configureUI(model: HomeModel.HomeItem){
        let url = URL(string: model.image)
        imageView.kf.setImage(with: url)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        layer.cornerRadius = 8
        layer.masksToBounds = true
    }
}


