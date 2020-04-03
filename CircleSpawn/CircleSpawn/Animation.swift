//
//  Animation.swift
//  CircleSpawn
//
//  Created by Dominik Drąg on 03/04/2020.
//  Copyright © 2020 DaftAcademy. All rights reserved.
//

import UIKit

class Animation {
    func spawn(object: UIView) {
        object.alpha = 0
        object.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.2, animations: {
            object.alpha = 1
            object.transform = .identity
        })
    }
    
    func despawn(object: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            object.alpha = 0
            object.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }, completion: { completed in
            object.removeFromSuperview()
        })
    }
    
    func pickUp(object: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            object.alpha = 0.5
            object.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        })
    }
    
    func putDown(object: UIView) {
        UIView.animate(withDuration: 0.2, animations: {
            object.alpha = 1
            object.transform = .identity
        })
    }
}
