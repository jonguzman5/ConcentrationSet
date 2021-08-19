//
//  ConcentrationThemeChooserViewController.swift
//  ConcentrationSet
//
//  Created by ジョナサン on 11/25/20.
//  Copyright © 2020 ジョナサン. All rights reserved.
//

import Foundation
import UIKit

class ConcentrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {


    let themes = [
        "Sports"   : "⚽️🏀🏈⚾️🎾🏐🏓🏸🏒🚴‍♀️🚣‍♀️🏏",
        "Animals"  : "🐶🐱🐭🦊🦁🐸🐔🦑🕷🐙🐖",
        "Faces"    : "😀😙😛🤣😇😎😡🤡👹🤠",
    ]

    override func awakeFromNib() {
        splitViewController?.delegate = self
    }
    
    
    func splitViewController(_ splitViewController: UISplitViewController,
                             collapseSecondary secondaryViewController: UIViewController,
                             onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcentrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }
    
    private var lastSeguedToConcentrationViewController: ConcentrationViewController?
    
    @IBAction func changeTheme(_ sender: Any) {
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle,
               let newTheme = themes[themeName] {
                    cvc.theme = newTheme
            }
        } else if let cvc = lastSeguedToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle,
               let newTheme = themes[themeName] {
                    cvc.theme = newTheme
            }
            navigationController?.pushViewController(cvc, animated: true)
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton)?.currentTitle,
               let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController {
                    cvc.theme = theme
                    lastSeguedToConcentrationViewController = cvc
                }
            }
        }
    }

}
