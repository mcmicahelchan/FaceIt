//
//  ViewController.swift
//  FaceIt
//
//  Created by michael chan on 2017/9/21.
//  Copyright © 2017年 michael chan. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    var FacialExpression = FacialExpressionModel(eye: .open, mouth: .sad, eyebrow: .relax){
        didSet{
            updateUI()
        }
    }
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.scaleEye(reconizer:))))
            
            let happyReconizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.happier))
            happyReconizer.direction = .down
            faceView.addGestureRecognizer(happyReconizer)
            
            let sadReconizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.sader))
            sadReconizer.direction = .up
            faceView.addGestureRecognizer(sadReconizer)
            updateUI()
        }
    }
    
    @objc func happier(){
        FacialExpression.mouth = FacialExpression.mouth.moreSmile()
    }
    
    @objc func sader(){
        FacialExpression.mouth = FacialExpression.mouth.moreSad()
    }
    
    @IBAction func eyeBrowChange(_ recognizer: UIRotationGestureRecognizer) {
        let degree = recognizer.rotation
        if degree > 0{
            FacialExpression.eyebrow.happier()
        }else if degree < 0{
            FacialExpression.eyebrow.sader()
        }
    }
    
    @IBAction func eyeChange(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == .ended{
            switch FacialExpression.eye{
            case .open:
                FacialExpression.eye = .close
            case .close:
                FacialExpression.eye = .open
            default:
                break
            }
        }
    }
    func updateUI(){
        switch FacialExpression.eye{
        case .open:
            faceView.eyeOpen = true
        case .close:
            faceView.eyeOpen = false
        default:
            break
        }
        
        switch FacialExpression.mouth{
        case .smile:
            faceView.smileFactor = 1.0
        case .relax:
            faceView.smileFactor = 0.0
        case .sad:
            faceView.smileFactor = -1.0
        default:
            break
        }
        
        switch FacialExpression.eyebrow{
        case .happy:
            faceView.eyeBrowTiltFactor = 1.0
        case .relax:
            faceView.eyeBrowTiltFactor = 0.0
        case .sad:
            faceView.eyeBrowTiltFactor = -1.0
        default:
            break
        }
    }
}

