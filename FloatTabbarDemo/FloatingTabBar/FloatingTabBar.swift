//
//  FloatingTabBar.swift
//  FloatTabbarDemo
//
//  Created by mac on 2024/10/24.
//

import UIKit

class TabBarConfig: NSObject {
    var backgroundColor: UIColor = .white
    
    var tabBarHeight: CGFloat = 60
    
    var tabBarItemHeight: CGFloat = 60
}

protocol FloatingTabBarDelegate: NSObjectProtocol {
    func didClickFloatingTabBar(_ floatingTabBar: FloatingTabBar, index: Int)
}

class FloatingTabBar: UIView {
    
    weak var delegate: FloatingTabBarDelegate?
    
    fileprivate var config: TabBarConfig!
    
    fileprivate var normalImageNames: [String] = []
    
    fileprivate var selectedImageNames: [String] = []
    
    fileprivate var buttons: [UIButton] = []
    
    init(config: TabBarConfig = TabBarConfig(),
         normalImageNames: [String],
         selectedImageNames: [String]) {
        super.init(frame: .zero)
        
        self.config = config
        self.normalImageNames = normalImageNames
        self.selectedImageNames = selectedImageNames
        
        backgroundColor = config.backgroundColor
        
        setupSubViews()
        
        updateUI(selectedIndex: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubViews() {
        for (index, normalImageName) in normalImageNames.enumerated() {
            let normalImage = UIImage(named: normalImageName)!
            let selectedImage = UIImage(named: selectedImageNames[index])!
            let button = createButton(normalImage: normalImage,
                                      selectedImage: selectedImage,
                                      index: index)
            buttons.append(button)
        }

        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.distribution = .fillEqually
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
    }
    
    func createButton(normalImage: UIImage,
                      selectedImage: UIImage,
                      index: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(normalImage, for: .normal)
        button.setImage(selectedImage, for: .selected)
        button.tag = index
        button.addTarget(self, action: #selector(changeTab(_:)), for: .touchUpInside)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: config.tabBarItemHeight).isActive = true
        return button
    }
    
    @objc func changeTab(_ sender: UIButton) {
        sender.pulse()
        delegate?.didClickFloatingTabBar(self, index: sender.tag)
        updateUI(selectedIndex: sender.tag)
    }
    
    func updateUI(selectedIndex: Int) {
        for (index, button) in buttons.enumerated() {
            button.isSelected = index == selectedIndex
        }
    }
    
    func toggle(hide: Bool) {
        if !hide {
            isHidden = hide
        }

        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 1,
                       initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.alpha = hide ? 0 : 1
            self.transform = hide ? CGAffineTransform(translationX: 0, y: 10) : .identity
        }) { (_) in
            if hide {
                self.isHidden = hide
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = .zero
        layer.shadowRadius = bounds.height / 2
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIButton {
    func pulse() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.15
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        layer.add(pulse, forKey: "pulse")
    }
}
