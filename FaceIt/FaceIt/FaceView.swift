//
//  FaceView.swift
//  FaceIt
//
//  Created by michael chan on 2017/9/21.
//  Copyright © 2017年 michael chan. All rights reserved.
//

import UIKit

class FaceView: UIView {
    var smileFactor: CGFloat = 0 //1 means smile and -1 means sad.
    private var skullRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height)/2
    }
    private var centerPoint : CGPoint {
        return CGPoint(x:bounds.midX,y:bounds.midY)
    }
    
    struct offset{
        static let eyeRaidus: CGFloat = 10.0
        static let eyeOffset: CGFloat = 50.0
        static let mouthWidth: CGFloat = 200.0
        static let mouthOffset: CGFloat = 80.0
    }
    enum eye{
        case left
        case right
    }
   
    private func drawCircle(center: CGPoint, radius: CGFloat) -> UIBezierPath{
        let circle = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*M_PI), clockwise: true)
        circle.lineWidth = 5.0
        UIColor.init(red: 125.0, green: 125.0, blue: 0.0, alpha: 1.0).set()
        return circle
        
    }
    private func pathForEye(Eye: eye) -> UIBezierPath{
        switch Eye {
        case .left:
            return drawCircle(center: CGPoint(x:(centerPoint.x - offset.eyeOffset), y:(centerPoint.y-offset.eyeOffset)), radius: offset.eyeRaidus)
        case .right:
            return drawCircle(center: CGPoint(x:centerPoint.x + offset.eyeOffset, y:centerPoint.y-offset.eyeOffset), radius: offset.eyeRaidus)
        default:
            break
        }
    }
    private func pathForMouth(smileFactor: CGFloat) -> UIBezierPath{
        let smileOffset = CGFloat(max(-1, min(smileFactor, 1)) * 70.0)
        let start = CGPoint(x:centerPoint.x - offset.mouthWidth/2, y:centerPoint.y + offset.mouthOffset)
        let end = CGPoint(x:centerPoint.x + offset.mouthWidth/2, y:centerPoint.y + offset.mouthOffset)
        let cp1 = CGPoint(x:centerPoint.x + offset.mouthWidth/3, y:centerPoint.y + offset.mouthOffset + smileOffset)
        let cp2 = CGPoint(x:centerPoint.x - offset.mouthWidth/3, y:centerPoint.y + offset.mouthOffset + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5.0
        return path
        
    }
    
    override func draw(_ rect: CGRect) {
       
        drawCircle(center: centerPoint, radius: skullRadius).stroke()
        pathForEye(Eye: eye.left).stroke()
        pathForEye(Eye: eye.right).stroke()
        pathForMouth(smileFactor: smileFactor).stroke()
     }

}
