//
//  UIApplication+Ext.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 23.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension UIApplication {
    public func addTapGestureRecognizer() {
        guard let window = firstSceneKeyWindow else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing)).apply {
            $0.requiresExclusiveTouchType = false
            $0.cancelsTouchesInView = false
            $0.delegate = self
        }
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(
        _ gestureRecognizer: UIGestureRecognizer,
        shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer
    ) -> Bool {
        return false
    }
}
