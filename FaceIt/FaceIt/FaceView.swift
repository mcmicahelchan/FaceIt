//
//  FaceView.swift
//  FaceIt
//
//  Created by michael chan on 2017/9/21.
//  Copyright © 2017年 michael chan. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    //changable parameters
    @IBInspectable
    var smileFactor: CGFloat = 1 { didSet{setNeedsDisplay()}}
    @IBInspectable
    var eyeOpen: Bool = false { didSet{setNeedsDisplay()}}
    @IBInspectable
    var eyeBrowTiltFactor: CGFloat = -1 { didSet{setNeedsDisplay()}}
    @IBInspectable
    var lineColor: UIColor = UIColor.black { didSet{setNeedsDisplay()}}
    @IBInspectable
    var eyeRaidus: CGFloat = 10.0 { didSet{setNeedsDisplay()}}
    
    
    @objc func scaleEye(reconizer: UIPinchGestureRecognizer){
        switch reconizer.state{
        case .changed, .ended:
            eyeRaidus *= reconizer.scale
            reconizer.scale = 1
        default:
            break
        }
    }
    
    private var skullRadius : CGFloat {
        return min(bounds.size.width, bounds.size.height)/2
    }
    private var centerPoint : CGPoint {
        return CGPoint(x:bounds.midX,y:bounds.midY)
    }
    
    struct offset{
        static let eyeOffset: CGFloat = 30.0
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
        lineColor.set()
        return circle
        
    }
    private func pathForEye(Eye: eye) -> UIBezierPath{
        switch Eye {
        case .left:
            if eyeOpen{
                return drawCircle(center: CGPoint(x:(centerPoint.x - offset.eyeOffset), y:(centerPoint.y-offset.eyeOffset)), radius: eyeRaidus)
            }else{
                let eye = UIBezierPath()
                eye.move(to: CGPoint(x: centerPoint.x - offset.eyeOffset - eyeRaidus, y: centerPoint.y-offset.eyeOffset))
                eye.addLine(to: CGPoint(x: centerPoint.x - offset.eyeOffset + 2 * eyeRaidus, y: centerPoint.y - offset.eyeOffset))
                eye.lineWidth = 5.0
                return eye
            }
        case .right:
            if eyeOpen{
                return drawCircle(center: CGPoint(x:centerPoint.x + offset.eyeOffset, y:centerPoint.y-offset.eyeOffset), radius: eyeRaidus)
            }else{
                let eye = UIBezierPath()
                eye.move(to: CGPoint(x: centerPoint.x + offset.eyeOffset - eyeRaidus, y: centerPoint.y-offset.eyeOffset))
                eye.addLine(to: CGPoint(x: centerPoint.x + offset.eyeOffset + 2 * eyeRaidus, y: centerPoint.y - offset.eyeOffset))
                eye.lineWidth = 5.0
                return eye
            }
            
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
    
    private func pathForEyebrow(Eye: eye) -> UIBezierPath{
        let eyebrowOffset = eyeBrowTiltFactor * 15
        switch Eye{
        case .left:
            let eyeBrow = UIBezierPath()
            eyeBrow.move(to: CGPoint(x: centerPoint.x - offset.eyeOffset - eyeRaidus, y: centerPoint.y - 1.5 * offset.eyeOffset))
            eyeBrow.addLine(to: CGPoint(x: centerPoint.x - offset.eyeOffset + 2 * eyeRaidus, y: centerPoint.y - 1.5 * offset.eyeOffset - eyebrowOffset))
            eyeBrow.lineWidth = 5.0
            return eyeBrow
        case .right:
            let eyeBrow = UIBezierPath()
            eyeBrow.move(to: CGPoint(x: centerPoint.x + offset.eyeOffset - eyeRaidus, y: centerPoint.y-1.5 * offset.eyeOffset - eyebrowOffset))
            eyeBrow.addLine(to: CGPoint(x: centerPoint.x + offset.eyeOffset + 2 * eyeRaidus, y: centerPoint.y - 1.5 * offset.eyeOffset))
            eyeBrow.lineWidth = 5.0
            return eyeBrow
    }
    }
    
    override func draw(_ rect: CGRect) {
       
        drawCircle(center: centerPoint, radius: skullRadius).stroke()
        pathForEye(Eye: eye.left).stroke()
        pathForEye(Eye: eye.right).stroke()
        pathForMouth(smileFactor: smileFactor).stroke()
        pathForEyebrow(Eye: eye.left).stroke()
        pathForEyebrow(Eye: eye.right).stroke()
     }

}
