//
//  HomeViewController.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 01/11/2023.
//

import UIKit
import Combine

class HomeViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    var topBannerErrorView: UIView = UIView()
    var loadingViewController: UIViewController = SpinnerViewController()
    private var viewModel: HomeViewModelProtocol
    private var cancellable: [AnyCancellable] = []
    
    // MARK: - init
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        collectionView.reloadData()
        viewModel.fetchHome()
        configureStateListner()
        configureNavBar()
    }
    
    func configureStateListner() {
        viewModel.state.sink { [weak self] state in
            guard let self else { return }
            switch state {
            case .initial:
                break
            case .loading:
                self.showLoadingView()
            case .failed(let error):
                self.showError(error.localizedDescription)
                self.hideLoadingView()
            case .loaded:
                self.hideLoadingView()
                self.collectionView.reloadData()
            }
        }
        .store(in: &cancellable)
    }
    
    func configureNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: DesignSystem.Images.iconSearch.image?.withRenderingMode(.alwaysOriginal))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: DesignSystem.Images.alert.image?.withRenderingMode(.alwaysOriginal))
        self.navigationItem.titleView = UIImageView(image: DesignSystem.Images.title7C.image?.withRenderingMode(.alwaysOriginal))
    }
}


extension HomeViewController {
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.register(CategoryThumbnailCell.self, forCellWithReuseIdentifier: "\(CategoryThumbnailCell.self)")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "\(ProductCell.self)")
        collectionView.register(SliderCell.self, forCellWithReuseIdentifier: "\(SliderCell.self)")
        collectionView.register(AdsCell.self, forCellWithReuseIdentifier: "\(AdsCell.self)")
        
        collectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "\(HeaderView.self)")
        collectionView.register(
            ProductsHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "\(ProductsHeaderView.self)")
        
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
        return viewModel.getItemsCount(section: sectionType)
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let sectionType = Section.allCases[indexPath.section]
        
        switch sectionType {
            
        case .categories:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CategoryThumbnailCell.self)", for: indexPath) as? CategoryThumbnailCell else {
                return UICollectionViewCell()
            }
            let category = viewModel.model.categories[indexPath.item]
            cell.configureUI(model: category)
            return cell
        case .slider:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SliderCell.self)", for: indexPath) as? SliderCell else {
                return UICollectionViewCell()
            }
            let slider = viewModel.model.slider[indexPath.item]
            cell.configureUI(model: slider)
            return cell
        case .weeklySelection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProductCell.self)", for: indexPath) as? ProductCell else {
                return UICollectionViewCell()
            }
            let weeklyProduct = viewModel.model.weeklyProducts[indexPath.item]
            cell.configureUI(model: weeklyProduct)
            return cell
        case .ads:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(AdsCell.self)", for: indexPath) as? AdsCell else {
                return UICollectionViewCell()
            }
            let ads = viewModel.model.ads[indexPath.item]
            cell.configureUI(model: ads)
            return cell
        case .topProducts:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(ProductCell.self)", for: indexPath) as? ProductCell else {
                return UICollectionViewCell()
            }
            let topProduct = viewModel.model.topProducts[indexPath.item]
            cell.configureUI(model: topProduct)
            return cell
        }
    }
}
extension HomeViewController {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionType = Section.allCases[indexPath.section]
        if sectionType == .topProducts || sectionType == .weeklySelection {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(ProductsHeaderView.self)", for: indexPath) as? ProductsHeaderView else { return UICollectionReusableView() }
            header.label.text = Section.allCases[indexPath.section].sectionTitle
            return header
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "\(HeaderView.self)", for: indexPath) as? HeaderView else { return UICollectionReusableView() }
            header.label.text = Section.allCases[indexPath.section].sectionTitle
            return header
        }
        
    }
}

extension HomeViewController {
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int,
                                                                        layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch (sectionLayoutKind) {
            case .categories:
                return TopCategoriesSection()
            case .slider:
                return SliderLayoutSection()
            case .weeklySelection:
                return ProductLayoutSection()
            case .ads:
                return AdsLayoutSection()
            case .topProducts:
                return ProductLayoutSection()
            }
        }
        return layout
    }
}

extension HomeViewController {
    enum Section: CaseIterable{
        case categories
        case slider
        case weeklySelection
        case ads
        case topProducts
        
        var sectionTitle: String {
            switch self {
            case .categories:
                "7C Categories"
            case .slider:
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
}

extension HomeViewController: LoadableProtocol, FailableProtocol {}
