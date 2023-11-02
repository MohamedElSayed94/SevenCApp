//
//  AdsLayoutSection.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import UIKit

class AdsLayoutSection: NSCollectionLayoutSection {
    
    convenience init() {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 24, bottom: 40, trailing: 24)
        
        self.init(group: group)
        orthogonalScrollingBehavior = .groupPagingCentered
    }
    
    
}
