//
//  HomeViewController.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 01/11/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    enum Section: CaseIterable{
        case topCategories
        case topWideBanner
        case weeklySelection
        case ads
        case topProducts
        
        var sectionTitle: String {
            switch self {
            case .topCategories:
                "7C Categories"
            case .topWideBanner:
                ""
            case .weeklySelection:
                "Weekly Selection"
            case .ads:
                ""
            case .topProducts:
                "Top Products"
            }
        }
    }
    var categoriesArr = ["Office Furniture", "Chair", "Desk", "Beds", "Room"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        collectionView.reloadData()
        self.view.backgroundColor = DesignSystem.Color.white.color
    }

}


extension HomeViewController {
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(CategoryThumbnailCell.self, forCellWithReuseIdentifier: "\(CategoryThumbnailCell.self)")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "\(ProductCell.self)")
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "\(HeaderView.self)")
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = Section.allCases[section]
        
        switch sectionType {
        case .topCategories:
            return categoriesArr.count
        case .topWideBanner:
            return 4
        case .weeklySelection:
            return 4
        case .ads:
            return 1
        case .topProducts:
            return 5
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if Section.allCases[indexPath.section] == .topWideBanner {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryThumbnailCell.self)", for: indexPath) as? CategoryThumbnailCell else {
                return UICollectionViewCell()
            }
            cell.configureUI(imageName: "Rectangle5", title: "")
            return cell
        } else if Section.allCases[indexPath.section] == .ads {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryThumbnailCell.self)", for: indexPath) as? CategoryThumbnailCell else {
                return UICollectionViewCell()
            }
            cell.configureUI(imageName: "addBanner", title: "")
            return cell
        } else if Section.allCases[indexPath.section] == .topCategories {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryThumbnailCell.self)", for: indexPath) as? CategoryThumbnailCell else {
                return UICollectionViewCell()
            }
            cell.configureUI(imageName: "WeeklySelection1", title: categoriesArr[indexPath.item])
            return cell
        
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProductCell.self)", for: indexPath) as? ProductCell else {
                return UICollectionViewCell()
            }
            cell.configureUI(imageName: "WeeklySelection1", title: categoriesArr[indexPath.item], isDiscounted: true, price: 100, priceOffer: 90)
            return cell
        }
        
        
    }
}
extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderView.self)", for: indexPath) as? HeaderView else { return UICollectionReusableView() }
        header.label.text = Section.allCases[indexPath.section].sectionTitle
        return header
    }
}

extension HomeViewController {
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { [weak self] (sectionIndex: Int,
                                                                        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            guard let self else {return nil}
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .topCategories:
                return generateTopCategoriesLayout()
            case .topWideBanner:
                return generateTopBannersLayout()
            case .weeklySelection:
                return generateGroupedProductLayout()
            case .ads:
                return generateTopBannersLayout()
            case .topProducts:
                return generateGroupedProductLayout()
            }
        }
        return layout
    }
    func generateTopCategoriesLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(117), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        return section
    }
    func generateTopBannersLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = .init(top: 24, leading: 0, bottom: 0, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        return section
    }
    func generateGroupedProductLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 15, trailing: 5)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(256))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 2)
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
}
