//
//  ProductCell.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 01/11/2023.
//

import UIKit

class ProductCell: UICollectionViewCell {
    // MARK: - View Component
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
       
        return imageView
    }()
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Font.regular14.font
        label.textColor = DesignSystem.Color.black3.color
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    private var priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        return stackView
    }()
    private var priceLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Font.bold14.font
        label.textColor = DesignSystem.Color.pink.color
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    private var offerPriceLabel: UILabel = {
        let label = UILabel()
        label.font = DesignSystem.Font.bold14.font
        label.textColor = DesignSystem.Color.black1.color
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    private var addToCartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "addCartIcon"), for: .normal)
        return button
    }()
}

// MARK: - configureUI

extension ProductCell {
    
    func configureUI(imageName: String, title: String, isDiscounted: Bool, price: Double, priceOffer: Double){
        imageView.image = UIImage(named: imageName)
        titleLabel.text = title
        
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: "\(price)KW")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        priceLabel.attributedText = attributeString
        offerPriceLabel.text = "\(priceOffer)KW"
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        addSubview(priceStackView)
        priceStackView.addArrangedSubview(priceLabel)
        priceStackView.addArrangedSubview(offerPriceLabel)
        priceStackView.translatesAutoresizingMaskIntoConstraints = false
        priceStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        priceStackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        priceStackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        priceStackView.heightAnchor.constraint(equalToConstant: 21).isActive = true
        
        addSubview(addToCartButton)
        addToCartButton.translatesAutoresizingMaskIntoConstraints = false
        addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        addToCartButton.centerYAnchor.constraint(equalTo: priceStackView.centerYAnchor).isActive = true
        addToCartButton.widthAnchor.constraint(equalToConstant: 16).isActive = true
        addToCartButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        priceStackView.trailingAnchor.constraint(lessThanOrEqualTo: addToCartButton.leadingAnchor, constant: -8).isActive = true
        
    }
}
