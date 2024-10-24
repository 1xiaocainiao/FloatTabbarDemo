//
//  ViewController.swift
//  FloatTabbarDemo
//
//  Created by mac on 2024/10/24.
//

import UIKit

class ViewController: BaseViewController {

    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Push new VC", for: .normal)
        button.addTarget(self, action: #selector(handeAction(_:)), for: .touchUpInside)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.titleEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
    }

    init(showPushButton: Bool = false) {
        super.init(nibName: nil, bundle: nil)

        if showPushButton {
            setupButton()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        toogleTabbar(hide: false)
    }

    func setupButton() {
        view.addSubview(button)
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc
    func handeAction(_ sender: UIButton) {
        let newVC = PushViewController()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.pushViewController(newVC, animated: true)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

