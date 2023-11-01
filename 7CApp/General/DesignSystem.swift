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
            }
        }
    }
    
    
}

extension DesignSystem {
    enum Font {
        case bold13
        case bold14
        case regular14
        
        var font: UIFont {
            switch self {
            case .bold13:
                return UIFont(name: "Poppins-Bold", size: 13) ?? .systemFont(ofSize: 13)
            case .bold14:
                return UIFont(name: "Poppins-Bold", size: 14) ?? .systemFont(ofSize: 14)
            case .regular14:
                return UIFont(name: "Poppins-Regular", size: 14) ?? .systemFont(ofSize: 14)
            }
        }
    }
}
