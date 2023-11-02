//
//  DesignSystem.swift
//  7CApp
//
//  Created by Mohamed Elsayed on 01/11/2023.
//

import UIKit

struct DesignSystem {
    
    
    enum Color {
        case white
        case black1
        case pink
        case black3
        case yellow
        case lightGreyMask
        case navBarShadow
        
        var color: UIColor {
            switch self {
            case .white:
                return .white
            case .black1:
                return UIColor(red: 41/255, green: 45/255, blue: 50/255, alpha: 1)
            case .pink:
                return UIColor(red: 222/255, green: 7/255, blue: 7/255, alpha: 0.41)
            case .black3:
                return UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1)
            case .yellow:
                return UIColor(red: 226/255, green: 149/255, blue: 71/255, alpha: 1)

            case .lightGreyMask:
                return UIColor(white: 0, alpha: 0.3)

            case .navBarShadow:
                return UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
            }
        }
    }
    
    
}
extension DesignSystem {
    
    enum Images {
        case iconSearch
        case alert
        case title7C
        case yellowArrow
        case arrowLeft
        case addCartIcon
        
        var image: UIImage? {
            switch self {
            case .iconSearch:
                UIImage(named: "IconSearch")
            case .alert:
                UIImage(named: "Alert")
            case .title7C:
                UIImage(named:"7CTitle")
            case .yellowArrow:
                UIImage(named: "yellowArrow")
            case .arrowLeft:
                UIImage(named: "arrow-left")
            case .addCartIcon:
                UIImage(named: "addCartIcon")
            }
        }
    }
}
extension DesignSystem {
    
    enum Font {
        case bold13
        case bold14
        case regular14
        case regular12
        
        var font: UIFont {
            switch self {
            case .bold13:
                return UIFont(name: "Poppins-Bold", size: 13) ?? .systemFont(ofSize: 13)
            case .bold14:
                return UIFont(name: "Poppins-Bold", size: 14) ?? .systemFont(ofSize: 14)
            case .regular14:
                return UIFont(name: "Poppins-Regular", size: 14) ?? .systemFont(ofSize: 14)
            case .regular12:
                return UIFont(name: "Poppins-Regular", size: 12) ?? .systemFont(ofSize: 12)
            }
        }
    }
}
