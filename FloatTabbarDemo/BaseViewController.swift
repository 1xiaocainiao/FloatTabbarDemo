//
//  BaseViewController.swift
//  FloatTabbarDemo
//
//  Created by mac on 2024/10/24.
//

import UIKit

class BaseViewController: UIViewController {

    func toogleTabbar(hide: Bool) {
        guard let tabBar = tabBarController as? FloatingTabBarController else { return }
        tabBar.toggle(hide: hide)
    }
}
