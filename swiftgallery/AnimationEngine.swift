//
//  AnimationEngine.swift
//  swiftgallery
//
//  Created by TEST on 4/26/21.
//

import Foundation
import UIKit

class AnimationEngine: UIViewController, CAAnimationDelegate {

    private static var type = CATransitionSubtype.fromRight

    static func slide(_ view: UIView, _ duration:Double) {
        var transition: CATransition? = nil
        transition = CATransition.init()
        transition?.duration = duration
        transition?.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition?.type = CATransitionType.push
        transition?.subtype = type
        view.layer.add(transition!, forKey: nil)
    }
}
