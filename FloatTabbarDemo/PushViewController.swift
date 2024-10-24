//
//  PushViewController.swift
//  FloatTabbarDemo
//
//  Created by mac on 2024/10/24.
//

import UIKit

class PushViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Pushed VC"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toogleTabbar(hide: true)
    }

}
