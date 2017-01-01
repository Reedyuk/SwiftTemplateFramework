//
//  Constants.swift
//
//
//  Created by Andrew Reed on 03/06/2016.
//  Copyright © 2016 Andrew Reed. All rights reserved.
//

import UIKit
import Foundation

/// The struct used to contain simple constants.
public struct Constants {
    /// All theme related operations
    struct Theme {
        /// Method used to update the theme throughout the app
        static func updateTheme() {
            UINavigationBar.appearance().barStyle = Constants.Theme.defaultBarStyle
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:
                Constants.Theme.defaultTintColour], for:.selected)
            UIBarButtonItem.appearance().tintColor = Constants.Theme.defaultTabTextTint
            UINavigationBar.appearance().tintColor = Constants.Theme.defaultTintColour
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:
                Constants.Theme.defaultTabTextTint], for:UIControlState())
            UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName:
                Constants.Theme.defaultTabTextTint], for:.selected)
            UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName:
                UIFont.preferredFont(forTextStyle: UIFontTextStyle.title3),
NSForegroundColorAttributeName: Constants.Theme.defaultNavTextTint]
            UITabBar.appearance().barStyle = Constants.Theme.defaultBarStyle
            UIApplication.shared.statusBarStyle = Constants.Theme.defaultStatusBarStyle
        }
        static let slateGrey = UIColor(red: CGFloat(104.0/255.0), green: CGFloat(107.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(1.0))
        static let coolGrey = UIColor(red: CGFloat(156.0/255.0), green: CGFloat(158.0/255.0), blue: CGFloat(161.0/255.0), alpha: CGFloat(1.0))
        static let silver = UIColor(red: CGFloat(202.0/255.0), green: CGFloat(208.0/255.0), blue: CGFloat(213.0/255.0), alpha: CGFloat(0.80))
        static let lightGreen = UIColor(red: CGFloat(33/255.0), green: CGFloat(168/255.0), blue: CGFloat(70/255.0), alpha: CGFloat(1))
        static let cyan = UIColor(red: CGFloat(0/255.0), green: CGFloat(169/255.0), blue: CGFloat(212/255.0), alpha: CGFloat(1))
        static let darkishGreen = UIColor(red: CGFloat(40.0/255.0), green: CGFloat(151.0/255.0), blue: CGFloat(71.0/255.0), alpha: CGFloat(1))
        static let highlightGreen = UIColor(red: CGFloat(67.0/255.0), green: CGFloat(253.0/255.0), blue: CGFloat(119.0/255.0), alpha: CGFloat(1))
        static let greyBackground = UIColor(red: CGFloat(245/255.0), green: CGFloat(245/255.0), blue: CGFloat(245/255.0), alpha: CGFloat(1))

        /// The colour we use in the DarkNavigationController.
        static let darkNavTitleColour = Constants.Theme.coolGrey
        static let darkNavButtonColour = Constants.Theme.silver

        static let darkPaymentCardTextColour = Constants.Theme.slateGrey
        static let paymentCardTextColour = Constants.Theme.silver.withAlphaComponent(CGFloat(1.0))

        static var defaultTintColour: UIColor {
            get {
                return UIColor(red: 47.0/255.0, green: 177.0/255.0, blue: 83.0/255.0, alpha: 1.0)
            }
        }
        static var defaultStatusBarStyle: UIStatusBarStyle {
            get {
                return .lightContent
            }
        }
        static var defaultBarStyle: UIBarStyle {
            get {
                return .default
            }
        }
        static var defaultNavTextTint: UIColor {
            get {
                return UIColor.white
            }
        }
        static var defaultTabTextTint: UIColor {
            get {
                return UIColor(red: CGFloat(104.0/255.0), green: CGFloat(107.0/255.0), blue: CGFloat(110.0/255.0), alpha: CGFloat(1.0))
            }
        }
        static var chartLabelColor: UIColor { return Theme.coolGrey }
        static var gridColor: UIColor { return Theme.silver }
        /// Variable we are using for the time it takes to fade in and out.
        static let transitionFadeInOutDuration = 0.5
        static let transitionRevealInOutDuration = 0.3

        static var errorColor: UIColor {
            get {
                return UIColor(red:0.98, green:0.19, blue:0.28, alpha:0.8)
            }
        }
        static var errorColorOpaque: UIColor {
            get {
                return UIColor(red:0.98, green:0.19, blue:0.28, alpha:1)
            }
        }
    }
}
