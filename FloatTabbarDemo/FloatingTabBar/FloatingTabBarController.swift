//
//  FloatingTabBarController.swift
//  FloatTabbarDemo
//
//  Created by mac on 2024/10/24.
//

import UIKit

class FloatingTabBarController: UITabBarController {
    let normalImageNames: [String] = [
        "tabbar_discover_normal",
        "tabbar_me_normal",
        "tabbar_discover_normal",
        "tabbar_me_normal",
    ]
    
    let selectedImageNames: [String] = [
        "tabbar_discover_selected",
        "tabbar_me_selected",
        "tabbar_discover_selected",
        "tabbar_me_selected",
    ]
    
    lazy var floatingTabbarView: FloatingTabBar = {
        let view = FloatingTabBar(normalImageNames: normalImageNames,
                                  selectedImageNames: selectedImageNames)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var vcs: [UIViewController] = []
        for (index, normalImageName) in normalImageNames.enumerated() {
            let title = "\(index)"
            let contentVc = ViewController(showPushButton: index == 0)
            switch index {
            case 0:
                contentVc.view.backgroundColor = .darkGray
            case 1:
                contentVc.view.backgroundColor = .blue
            case 2:
                contentVc.view.backgroundColor = .green
            case 3:
                contentVc.view.backgroundColor = .gray
            default:
                contentVc.view.backgroundColor = .gray
            }
                
            let vc = createNavViewController(viewController: contentVc, title: title, normalImageName: normalImageName, selectedImageName: selectedImageNames[index])
            vcs.append(vc)
        }
        viewControllers = vcs
        
        tabBar.isHidden = true
        
        setupFloatingTabBar()
        // Do any additional setup after loading the view.
    }
    
    func setupFloatingTabBar() {
        floatingTabbarView.delegate = self
        view.addSubview(floatingTabbarView)
        floatingTabbarView.translatesAutoresizingMaskIntoConstraints = false
        floatingTabbarView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        floatingTabbarView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        floatingTabbarView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -getSafeAreaInsets().bottom).isActive = true
    }
    
    private func createNavViewController(viewController: UIViewController, title: String, normalImageName: String, selectedImageName: String) -> UIViewController {

        viewController.navigationItem.title = title

        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: normalImageName)
        viewController.tabBarItem.selectedImage =  UIImage(named: selectedImageName)

        return navController
    }
    
    func toggle(hide: Bool) {
        floatingTabbarView.toggle(hide: hide)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FloatingTabBarController: FloatingTabBarDelegate {
    func didClickFloatingTabBar(_ floatingTabBar: FloatingTabBar, index: Int) {
        selectedIndex = index
    }
}

public func getSafeAreaInsets() -> UIEdgeInsets {
    if #available(iOS 11, *) {
        guard let window = UIApplication.currentUIWindow else {
            return UIEdgeInsets.zero
        }
        return window.safeAreaInsets
    }
    return UIEdgeInsets.zero
}

extension UIApplication {
    static var currentUIWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
                .map({ $0 as? UIWindowScene })
                .compactMap({ $0 })
                .first?.windows.first
        } else {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        }
    }
    
}
