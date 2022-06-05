//
//  WebView+Script.swift
//  PhantomKit
//
//  Created by Pawel Wiszenko on 01.05.2021.
//  Copyright © 2021 Pawel Wiszenko. All rights reserved.
//

import Foundation

extension WebView {
    public enum Script {
        public static func hideElements(ids: [String]) -> String {
            guard !ids.isEmpty else { return "" }
            let ids = ids
                .map { "hideElementById('\($0)');" }
            return
                """
                \(_hideElementById)
                \(ids.joined(separator: " "))
                """
        }

        public static func hideElements(classNames: [String]) -> String {
            guard !classNames.isEmpty else { return "" }
            let classNames = classNames
                .map { "hideElementsByClassName('\($0)');" }
            return
                """
                \(_hideElementsByClassName)
                \(classNames.joined(separator: " "))
                """
        }
    }
}

// MARK: - Scripts

extension WebView.Script {
    private static let _hideElementById =
        """
        const hideElementById = id => {
            const element = document.getElementById(id);
            if (!element) { return; }
            if (element.style) {
                element.style.display = 'none';
            }
        };
        """

    private static let _hideElementsByClassName =
        """
        const hideElementsByClassName = className => {
            const elements = document.getElementsByClassName(className);
            if (!elements) { return; }
            for (let element of elements) {
                if (element.style) {
                    element.style.display = 'none';
                }
            }
        };
        """
}
