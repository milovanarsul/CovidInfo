//
//  HeaderViewController.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 11.03.2022.
//

import UIKit

class HeaderPageViewController: UIPageViewController {
    
    fileprivate var pages: [UIViewController] = []
    private var pageControl = UIPageControl()
    private var timer: Timer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        dataSource = self
        createViews()
        setupPageControl()
        selfScroll()
        
        if let firstViewController = pages.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    fileprivate func createViews(){
        self.view.layer.cornerRadius = 24

        for index in 0..<headersData.count{
            pages.append(HeaderViewController(headerImage: headersData[index].image, headerIndex: index))
        }
    }
    
    func setupPageControl(){
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        pageControl.tintColor = .white
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .white
        self.view.addSubview(pageControl)
        
        let pageControlConstraints = Constraints(childView: pageControl, parentView: self.view, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        pageControlConstraints.addConstraints()
    }
    
    func selfScroll(){
        timer = Timer.scheduledTimer(withTimeInterval: 6.0, repeats: true) { timer in
            self.goToNextPage()
            self.pageControl.currentPage = self.getCurrentIndex(views: self.pages)
        }
        timer.tolerance = 0.2
    }
}

extension HeaderPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {return nil}
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0 else {return pages.last}
        
        return self.pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = self.pages.firstIndex(of: viewController) else {return nil}
        let nextIndex = viewControllerIndex + 1
        guard self.pages.count > nextIndex else {return pages.first}
        
        return self.pages[nextIndex]
    }
}

extension HeaderPageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed{
            guard let selectedVC = pageViewController.viewControllers?.first else { return }
            let selectedIndex = self.pages.firstIndex(of: selectedVC)!
            self.pageControl.currentPage = selectedIndex
            
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 9.0){
                self.selfScroll()
            }
        }
    }
}

class HeaderViewController: UIViewController{
    private var headerImage: UIImage!
    private var headerIndex: Int!
    
    convenience init(headerImage: UIImage, headerIndex: Int){
        self.init()
        self.headerImage = headerImage
        self.headerIndex = headerIndex
    }
    
    override func viewDidLoad() {
        setup()
        
        switch headerIndex{
        case 0:
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(header1Gesture)))
        case 1:
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(header2Gesture)))
        case 2:
            self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(header3Gesture)))
        default:
            ()
        }
    }
    
    func setup(){
        let imageView = UIImageView()
        imageView.image = headerImage
        imageView.contentMode = .scaleAspectFill
        self.view.addSubview(imageView)
        defaultConstraints(childView: imageView, parentView: self.view)
    }
    
    @objc func header1Gesture() {
        delegates.homePage.goToPage(pageIndex: 1, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .triaj))
        delegates.main.tabAnimation(visibility: .hide)
    }
    
    @objc func header2Gesture(){
        delegates.homePage.goToPage(pageIndex: 2, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .simptome))
        delegates.main.tabAnimation(visibility: .hide)
    }
    
    @objc func header3Gesture(){
        delegates.homePage.goToPage(pageIndex: 3, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .preventie))
        delegates.main.tabAnimation(visibility: .hide)
    }
}
