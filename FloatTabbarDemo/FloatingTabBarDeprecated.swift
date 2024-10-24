import UIKit

let kTabBarHeight: CGFloat = 60

class FloatingTabBarDeprecated: UITabBar {
    
    private var shapeLayer: CALayer?
    
    private var centerWidth: CGFloat = 0
    private var centerHeight: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        self.addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -2);
        shapeLayer.shadowOpacity = 0.1
        shapeLayer.shadowRadius = 10
        
        if let oldShapeLayer = self.shapeLayer {
            self.layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            self.layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height))
        path.close()
        
        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 给整个 TabBar 添加圆角
        self.layer.masksToBounds = true
        self.layer.cornerRadius = kTabBarHeight / 2
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = kTabBarHeight // 设置 TabBar 高度
        return sizeThatFits
    }
}

// MARK: - TabBarController
class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // 设置 TabBar 的位置（使其悬浮）
        tabBar.frame = CGRect(x: 8,
                            y: view.frame.height - 90,
                            width: view.frame.width - 16,
                              height: kTabBarHeight)
    }
    
    private func setupTabBar() {
        // 设置 TabBar 外观
        UITabBar.appearance().backgroundColor = .clear
//        UITabBar.appearance().tintColor = .red
//        UITabBar.appearance().unselectedItemTintColor = .gray
        
        // 移除 TabBar 顶部线条
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        
        UITabBar.appearance().isTranslucent = true
        
        // 创建自定义 TabBar
        let customTabBar = FloatingTabBarDeprecated()
        setValue(customTabBar, forKey: "tabBar")
    }
    
    private func setupViewControllers() {
            // 创建视图控制器并设置基本属性
        let firstVC = createViewController(backgroundColor: .blue, title: "First")
            let secondVC = createViewController(backgroundColor: .white, title: "Second")
        let thirdVC = createViewController(backgroundColor: .yellow, title: "Third")
            let fourthVC = createViewController(backgroundColor: .white, title: "Fourth")
            
            // 设置 TabBar 项
            firstVC.tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(named: "tabbar_discover_normal"),
                selectedImage: UIImage(named: "tabbar_discover_selected")
            )
            
            secondVC.tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(named: "tabbar_me_normal"),
                selectedImage: UIImage(named: "tabbar_me_selected")
            )
            
            thirdVC.tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(named: "tabbar_discover_normal"),
                selectedImage: UIImage(named: "tabbar_discover_selected")
            )
            
            fourthVC.tabBarItem = UITabBarItem(
                title: nil,
                image: UIImage(named: "tabbar_me_normal"),
                selectedImage: UIImage(named: "tabbar_me_selected")
            )
            
            // 设置导航控制器
            let nav1 = UINavigationController(rootViewController: firstVC)
            let nav2 = UINavigationController(rootViewController: secondVC)
            let nav3 = UINavigationController(rootViewController: thirdVC)
            let nav4 = UINavigationController(rootViewController: fourthVC)
            
            setViewControllers([nav1, nav2, nav3, nav4], animated: false)
        }
        
        private func createViewController(backgroundColor: UIColor, title: String) -> UIViewController {
            let vc = UIViewController()
            vc.view.backgroundColor = backgroundColor
            vc.title = title
            
            // 添加一个示例标签来验证视图是否正确加载
            let label = UILabel()
            label.text = title
            label.translatesAutoresizingMaskIntoConstraints = false
            vc.view.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: vc.view.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: vc.view.centerYAnchor)
            ])
            
            return vc
        }
}

