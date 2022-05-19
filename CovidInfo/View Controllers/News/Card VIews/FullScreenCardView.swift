//
//  FullScreenCardView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.03.2022
//

import UIKit

class FullScreenCardView: UIViewController, UIScrollViewDelegate {
    
    lazy var snapshotView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOpacity = 0.2
        imageView.layer.shadowRadius = 10.0
        imageView.layer.shadowOffset = CGSize(width: -1, height: 2)
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.autoresizingMask = .flexibleHeight
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        view.bounces = true
        view.clipsToBounds = true
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        return button
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var viewsAreHidden: Bool = false {
        didSet {
            closeButton.isHidden = viewsAreHidden
            cardView?.isHidden = viewsAreHidden
            textLabel.isHidden = viewsAreHidden

            view.backgroundColor = viewsAreHidden ? .clear : .white
        }
    }
    
    private let article: Article
    private(set) var cardView: NewsCardView?
    
    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
      fatalError()
    }
    
    override func viewDidLoad() {
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    deinit{}
}

extension FullScreenCardView {
    
    func configureView() {
        configureScrollView()
        configureCardView()
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureCardView() {
        let cardModel = article
        article.viewMode = .full
        cardView = NewsCardView(article: cardModel)
        cardView?.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(cardView!)
        
        let topPadding = UIWindow.topPadding
        
        NSLayoutConstraint.activate([
            cardView!.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -topPadding),
            cardView!.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            cardView!.heightAnchor.constraint(equalToConstant: 450),
            cardView!.widthAnchor.constraint(equalToConstant: view.frame.size.width)
        ])
        
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1.0),
            closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0)
        ])
        
        if cardView?.article.backgroundType == .light {
            closeButton.setImage(UIImage(named: "darkOnLight")!, for: UIControl.State.normal)
        } else {
            closeButton.setImage(UIImage(named: "lightOnDark")!, for: UIControl.State.normal)
        }
        
        let text = article.articleDescription
        let textAttributes: [NSAttributedString.Key: Any] = [
            .font : UIFont.systemFont(ofSize: 20, weight: .medium),
            .foregroundColor: UIColor.black
        ]

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1.2
        
        let attributedString = NSMutableAttributedString(attributedString: NSMutableAttributedString(string: text!, attributes: textAttributes))
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        textLabel.attributedText = attributedString
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        
        scrollView.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            textLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            textLabel.topAnchor.constraint(equalTo: cardView!.bottomAnchor, constant: 20.0),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0)
        ])
    }
    
    @objc func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func createSnapshotOfView() {
        let snapshotImage = view.createSnapshot()
        snapshotView.image = snapshotImage
        scrollView.addSubview(snapshotView)
        
        let topPadding = UIWindow.topPadding
        snapshotView.frame = CGRect(x: 0, y: -topPadding, width: view.frame.size.width, height: view.frame.size.height)
        
        scrollView.delegate = self
    }
}

extension FullScreenCardView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yPositionForDismissal: CGFloat = 20.0
        var yContentOffset = scrollView.contentOffset.y
        let topPadding = UIWindow.topPadding
        
        yContentOffset += topPadding
        
        updateCloseButton(yContentOffset: yContentOffset)
        
        if scrollView.isTracking {
            scrollView.bounces = true
        } else {
            scrollView.bounces = yContentOffset > 500
        }
        
        if yContentOffset < 0 && scrollView.isTracking {
            viewsAreHidden = true
            snapshotView.isHidden = false
            
            let scale = (100 + yContentOffset) / 100
            snapshotView.transform = CGAffineTransform(scaleX: scale, y: scale)
            
            snapshotView.layer.cornerRadius = -yContentOffset > yPositionForDismissal ? yPositionForDismissal : -yContentOffset
            
            if yPositionForDismissal + yContentOffset <= 0 {
                self.close()
            }
            
        } else {
            viewsAreHidden = false
            snapshotView.isHidden = true
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.bounces = true
    }
    
    func updateCloseButton(yContentOffset: CGFloat) {
        
        let topPadding = UIWindow.topPadding
        
        if yContentOffset < 450 - topPadding && cardView?.article.backgroundType == .dark {
            closeButton.setImage(UIImage(named: "lightOnDark"), for: .normal)
        } else {
            closeButton.setImage(UIImage(named: "darkOnLight"), for: .normal)
        }
    }
}
