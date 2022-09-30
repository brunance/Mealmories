

import UIKit
let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)

class Page1: UIViewController {
    
    @IBOutlet weak var confeteAmarelo: UIImageView!
    @IBOutlet weak var botao1: UIButton!
   
    override func viewDidDisappear(_ animated: Bool) {
        confeteAmarelo.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        confeteAmarelo.isHidden = false
    }
    
    override func viewDidLoad() {
    
       
        
        super.viewDidLoad()
        confeteAmarelo.layer.zPosition = 0
        botao1.layer.zPosition = 1
        confeteAmarelo.layer.opacity = 0.5
    }

   
}

class Page2: UIViewController {
    
    @IBOutlet weak var b2: UIButton!
    @IBOutlet weak var confeteVermelho: UIImageView!
    
    override func viewDidDisappear(_ animated: Bool) {
        confeteVermelho.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        confeteVermelho.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
       
        confeteVermelho.layer.zPosition = 0
        confeteVermelho.layer.opacity = 0.5
        b2.layer.zPosition = 1
    }
    
}

class Page3: UIViewController {
    @IBOutlet weak var confeteAzul: UIImageView!
    @IBOutlet weak var b3: UIButton!
    
    override func viewDidDisappear(_ animated: Bool) {
        confeteAzul.isHidden = true
        
    }
   
    override func viewWillAppear(_ animated: Bool) {
    
        confeteAzul.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        b3.layer.zPosition = 1
        confeteAzul.layer.zPosition = 0
        confeteAzul.layer.opacity = 0.5
    }
    
    @IBAction func gotoApp(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "ListRecipesScreen", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "recipesScreen") as! ListRecipesViewController
        let targetNavigationController = UINavigationController(rootViewController: newViewController)
        targetNavigationController.modalPresentationStyle = .fullScreen
        
        self.present(targetNavigationController, animated: true, completion: nil)
    }
    
}
public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }

        func mapToDevice(identifier: String) -> String { // swiftlint:disable:this cyclomatic_complexity
            #if os(iOS)
            switch identifier {
            case "iPod5,1":                                       return "iPod touch (5th generation)"
            case "iPod7,1":                                       return "iPod touch (6th generation)"
            case "iPod9,1":                                       return "iPod touch (7th generation)"
            case "iPhone3,1", "iPhone3,2", "iPhone3,3":           return "iPhone 4"
            case "iPhone4,1":                                     return "iPhone 4s"
            case "iPhone5,1", "iPhone5,2":                        return "iPhone 5"
            case "iPhone5,3", "iPhone5,4":                        return "iPhone 5c"
            case "iPhone6,1", "iPhone6,2":                        return "iPhone 5s"
            case "iPhone7,2":                                     return "iPhone 6"
            case "iPhone7,1":                                     return "iPhone 6 Plus"
            case "iPhone8,1":                                     return "iPhone 6s"
            case "iPhone8,2":                                     return "iPhone 6s Plus"
            case "iPhone9,1", "iPhone9,3":                        return "iPhone 7"
            case "iPhone9,2", "iPhone9,4":                        return "iPhone 7 Plus"
            case "iPhone10,1", "iPhone10,4":                      return "iPhone 8"
            case "iPhone10,2", "iPhone10,5":                      return "iPhone 8 Plus"
            case "iPhone10,3", "iPhone10,6":                      return "iPhone X"
            case "iPhone11,2":                                    return "iPhone XS"
            case "iPhone11,4", "iPhone11,6":                      return "iPhone XS Max"
            case "iPhone11,8":                                    return "iPhone XR"
            case "iPhone12,1":                                    return "iPhone 11"
            case "iPhone12,3":                                    return "iPhone 11 Pro"
            case "iPhone12,5":                                    return "iPhone 11 Pro Max"
            case "iPhone13,1":                                    return "iPhone 12 mini"
            case "iPhone13,2":                                    return "iPhone 12"
            case "iPhone13,3":                                    return "iPhone 12 Pro"
            case "iPhone13,4":                                    return "iPhone 12 Pro Max"
            case "iPhone14,4":                                    return "iPhone 13 mini"
            case "iPhone14,5":                                    return "iPhone 13"
            case "iPhone14,2":                                    return "iPhone 13 Pro"
            case "iPhone14,3":                                    return "iPhone 13 Pro Max"
            case "iPhone14,7":                                    return "iPhone 14"
            case "iPhone14,8":                                    return "iPhone 14 Plus"
            case "iPhone15,2":                                    return "iPhone 14 Pro"
            case "iPhone15,3":                                    return "iPhone 14 Pro Max"
            case "iPhone8,4":                                     return "iPhone SE"
            case "iPhone12,8":                                    return "iPhone SE (2nd generation)"
            case "iPhone14,6":                                    return "iPhone SE (3rd generation)"
            case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":      return "iPad 2"
            case "iPad3,1", "iPad3,2", "iPad3,3":                 return "iPad (3rd generation)"
            case "iPad3,4", "iPad3,5", "iPad3,6":                 return "iPad (4th generation)"
            case "iPad6,11", "iPad6,12":                          return "iPad (5th generation)"
            case "iPad7,5", "iPad7,6":                            return "iPad (6th generation)"
            case "iPad7,11", "iPad7,12":                          return "iPad (7th generation)"
            case "iPad11,6", "iPad11,7":                          return "iPad (8th generation)"
            case "iPad12,1", "iPad12,2":                          return "iPad (9th generation)"
            case "iPad4,1", "iPad4,2", "iPad4,3":                 return "iPad Air"
            case "iPad5,3", "iPad5,4":                            return "iPad Air 2"
            case "iPad11,3", "iPad11,4":                          return "iPad Air (3rd generation)"
            case "iPad13,1", "iPad13,2":                          return "iPad Air (4th generation)"
            case "iPad13,16", "iPad13,17":                        return "iPad Air (5th generation)"
            case "iPad2,5", "iPad2,6", "iPad2,7":                 return "iPad mini"
            case "iPad4,4", "iPad4,5", "iPad4,6":                 return "iPad mini 2"
            case "iPad4,7", "iPad4,8", "iPad4,9":                 return "iPad mini 3"
            case "iPad5,1", "iPad5,2":                            return "iPad mini 4"
            case "iPad11,1", "iPad11,2":                          return "iPad mini (5th generation)"
            case "iPad14,1", "iPad14,2":                          return "iPad mini (6th generation)"
            case "iPad6,3", "iPad6,4":                            return "iPad Pro (9.7-inch)"
            case "iPad7,3", "iPad7,4":                            return "iPad Pro (10.5-inch)"
            case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":      return "iPad Pro (11-inch) (1st generation)"
            case "iPad8,9", "iPad8,10":                           return "iPad Pro (11-inch) (2nd generation)"
            case "iPad13,4", "iPad13,5", "iPad13,6", "iPad13,7":  return "iPad Pro (11-inch) (3rd generation)"
            case "iPad6,7", "iPad6,8":                            return "iPad Pro (12.9-inch) (1st generation)"
            case "iPad7,1", "iPad7,2":                            return "iPad Pro (12.9-inch) (2nd generation)"
            case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":      return "iPad Pro (12.9-inch) (3rd generation)"
            case "iPad8,11", "iPad8,12":                          return "iPad Pro (12.9-inch) (4th generation)"
            case "iPad13,8", "iPad13,9", "iPad13,10", "iPad13,11":return "iPad Pro (12.9-inch) (5th generation)"
            case "AppleTV5,3":                                    return "Apple TV"
            case "AppleTV6,2":                                    return "Apple TV 4K"
            case "AudioAccessory1,1":                             return "HomePod"
            case "AudioAccessory5,1":                             return "HomePod mini"
            case "i386", "x86_64", "arm64":                       return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
            default:                                              return identifier
            }
            #elseif os(tvOS)
            switch identifier {
            case "AppleTV5,3": return "Apple TV 4"
            case "AppleTV6,2": return "Apple TV 4K"
            case "i386", "x86_64": return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "tvOS"))"
            default: return identifier
            }
            #endif
        }

        return mapToDevice(identifier: identifier)
    }()

}

class ViewController: UIPageViewController {

   
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    let nextButton = UIButton()
    let skipButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        AppDelegate.AppUtility.lockOrientation(.portrait)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CorDaview")
        setup()
        style()
        layout()
    }
}

extension ViewController {
    
  
    func setup() {
        dataSource = self
        delegate = self
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "OnBoard", bundle: nil)
        
        let page1 = storyBoard.instantiateViewController(withIdentifier: "Page1") as! Page1
        let page2 = storyBoard.instantiateViewController(withIdentifier: "Page2") as! Page2
        let page3 = storyBoard.instantiateViewController(withIdentifier: "Page3") as! Page3

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
    
       
       
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
    }
    
    func style() {
       
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
       
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitleColor(.clear, for: .normal)
        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(nextTapped(_:)), for: .primaryActionTriggered)
        nextButton.isEnabled = false
        
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.setTitleColor(.clear, for: .normal)
        skipButton.setTitle("Skip", for: .normal)
        skipButton.addTarget(self, action: #selector(skipTapped(_:)), for: .primaryActionTriggered)
       
       
    }
    
    func layout() {
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        let modelName = UIDevice.modelName
        if (modelName.localizedStandardContains(" iPad Pro (12.9-inch)")){
            NSLayoutConstraint.activate([
                
               
                pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
                pageControl.heightAnchor.constraint(equalToConstant: 20),
                view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier:8),
                
                nextButton.widthAnchor.constraint(equalToConstant: 100),
                nextButton.heightAnchor.constraint(equalToConstant: 150),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
                nextButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -300),
                
                skipButton.widthAnchor.constraint(equalToConstant: 100),
                skipButton.heightAnchor.constraint(equalToConstant: 150),
                skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                skipButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -300),
        
                
            ])
        }
        else{
            NSLayoutConstraint.activate([
                
                
                
                pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
                pageControl.heightAnchor.constraint(equalToConstant: 20),
                view.bottomAnchor.constraint(equalToSystemSpacingBelow: pageControl.bottomAnchor, multiplier:8),
                
                nextButton.widthAnchor.constraint(equalToConstant: 100),
                nextButton.heightAnchor.constraint(equalToConstant: 100),
                nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
                nextButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -40),
                
                skipButton.widthAnchor.constraint(equalToConstant: 100),
                skipButton.heightAnchor.constraint(equalToConstant: 100),
                skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                skipButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -40),
                
                
                
            ])
        }
    }
}
extension ViewController {

   

    @objc func skipTapped(_ sender: UIButton) {
        let lastPageIndex = pages.count - 1
        pageControl.currentPage = lastPageIndex
        
        goToSpecificPage(index: lastPageIndex, ofViewControllers: pages)
        
    }
    
    @objc func nextTapped(_ sender: UIButton) {
        pageControl.currentPage += 1
        goToNextPage()
     
       
    }
}



extension ViewController {
    
   
    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
}



extension ViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
       
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
     

        
        if currentIndex == 0 {
            return nil
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        if currentIndex == 1{
            nextButton.isEnabled = false
        }
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        }
        
        else {
            nextButton.isEnabled = true
            return nil
        }
        
    }
}


extension ViewController: UIPageViewControllerDelegate {
    
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
extension UIPageViewController {

    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
        
        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let currentPage = viewControllers?[0] else { return }
        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
        
        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
    }
    
    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
    }
    
}

