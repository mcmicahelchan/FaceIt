//
//  FacialExpressionModel.swift
//  FaceIt
//
//  Created by michael chan on 2017/9/25.
//  Copyright © 2017年 michael chan. All rights reserved.
//

import Foundation

struct FacialExpressionModel{
    enum Eye:Int{
        case open
        case close
    }
    
    enum Mouth:Int {
        case smile
        case relax
        case sad
        
        func moreSmile() -> Mouth{
            return  Mouth(rawValue: rawValue - 1) ?? .smile
        }
        func moreSad() -> Mouth{
            return Mouth(rawValue: rawValue + 1) ?? .sad
        }
    }
    
    enum EyeBrow: Int{
        case happy
        case relax
        case sad
        
        func happier() -> EyeBrow{
            return  EyeBrow(rawValue: rawValue - 1) ?? .happy
        }
        
        func sader() -> EyeBrow{
            return EyeBrow(rawValue: rawValue + 1) ?? .sad
        }
    }
    
    var eye: Eye
    var mouth: Mouth
    var eyebrow: EyeBrow
}
