//
//  HeaderView.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 01/11/2023.
//

import UIKit


class HeaderView: UICollectionReusableView {
    
    let label: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Font.bold13.font
        label.textColor = DesignSystem.Color.black1.color
        return label
    }()
    private var seeAllButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
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

extension HeaderView {
    func configure() {
        backgroundColor = .systemBackground
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        
        let inset = CGFloat(10)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: inset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -inset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -inset)
        ])
        
        addSubview(seeAllButton)
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24).isActive = true
        seeAllButton.centerYAnchor.constraint(equalTo: label.centerYAnchor).isActive = true
    }
}
