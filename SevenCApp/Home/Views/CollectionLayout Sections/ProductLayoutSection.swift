//
//  ProductLayoutSection.swift
//  SevenCApp
//
//  Created by Mohamed Elsayed on 01/11/2023.
//

import UIKit

class ProductLayoutSection: NSCollectionLayoutSection {
    
    convenience init() {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 8, bottom: 15, trailing: 8)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(256))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        sectionHeader.pinToVisibleBounds = true
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 5, trailing: 16)
        self.init(group: group)
        
        boundarySupplementaryItems = [sectionHeader]
    }
    
    
}
