//
//  SelectViewController.swift
//  FaceIt
//
//  Created by michael chan on 2017/9/27.
//  Copyright © 2017年 michael chan. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController {
    
    private let emotionalFaces: Dictionary<String, FacialExpressionModel> = [
        "happy": FacialExpressionModel(eye: .open, mouth: .smile, eyebrow: .happy),
        "calm": FacialExpressionModel(eye: .open, mouth: .relax, eyebrow: .relax),
        "quiet": FacialExpressionModel(eye: .close, mouth: .relax, eyebrow: .relax),
        "sad": FacialExpressionModel(eye: .close, mouth: .sad, eyebrow: .sad)
    ]
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationVC = segue.destination
        if let navigation = destinationVC as? UINavigationController{
            destinationVC = navigation.visibleViewController!
        }
        if let faceVC = destinationVC as? FaceViewController{
            if let item = emotionalFaces[segue.identifier!]{
                faceVC.FacialExpression = item
            }
            if let button = sender as? UIButton{
                faceVC.navigationItem.title = button.currentTitle
            }
        }
    }


}
