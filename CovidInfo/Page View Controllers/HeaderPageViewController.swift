//
//  HeaderViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import UIKit

class HeaderPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []
    private var currentIndex = 0 {
        didSet{
            delegates.home.setPageControl(index: currentIndex)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        dataSource = self
        createViews()
        
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func createViews(){
        self.view.roundCorners([.topLeft, .topRight], radius: 24)

        for header in headersData{
            pages.append(HeaderViewController(headerImage: header.image))
        }
    }
}

extension HeaderPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return pages.last}
        print("Back: \(getCurrentIndex(views: pages))")
        //currentIndex = getCurrentIndex(views: pages)
        
        return self.pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard self.pages.count > nextIndex else {return pages.first}
        //currentIndex = getCurrentIndex(views: pages)
        print("Front: \(getCurrentIndex(views: pages))")
        
        return self.pages[nextIndex]
    }
}

class HeaderViewController: UIViewController{
    private var headerImage: UIImage!
    
    convenience init(headerImage: UIImage){
        self.init()
        self.headerImage = headerImage
    }
    
    override func viewDidLoad() {
        setup()
    }
    
    func setup(){
        let imageView = UIImageView()
        imageView.image = headerImage
        imageView.contentMode = .scaleAspectFill
        self.view.addSubview(imageView)
        defaultConstraints(childView: imageView, parentView: self.view)
    }
}
