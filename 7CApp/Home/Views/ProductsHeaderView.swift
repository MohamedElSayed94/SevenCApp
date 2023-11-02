//
//  ProductsHeaderView.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 02/11/2023.
//

import UIKit

class ProductsHeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Font.bold13.font
        label.textColor = DesignSystem.Color.black1.color
        return label
    }()
    private var seeAllButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "yellowArrow"), for: .normal)
        button.setTitle("See all  ", for: .normal)
        button.setTitleColor(DesignSystem.Color.yellow.color, for: .normal)
        button.titleLabel?.font = DesignSystem.Font.regular12.font
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension ProductsHeaderView {
    func configure() {
        backgroundColor = .systemBackground
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: inset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
        
        addSubview(seeAllButton)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        seeAllButton.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
    }
}
