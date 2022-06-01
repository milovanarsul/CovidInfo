//
//  ArticlesView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.03.2022.
//

import Foundation
import UIKit
import CoreData
import Firebase

class NewsViewController: UIViewController {
    
    lazy var trustedSourcesView: UIView = {
        let view = TrustedSources()
        view.setup()
        return view
    }()
    
    lazy var newsCardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(GenericTableViewCell<NewsCardView>.self)
        tableView.cornerRadius = 24
        tableView.backgroundColor = .white
        return tableView
    }()
    
    var cardsTableViewType: CardsTableViewType?
    let transitionManager: CardTransitionManager? = CardTransitionManager()
    var cardsViewData: [Article]?
    
    let trustedSources = NSPredicate(format: "isTrusted == true")
    let untrustedSources = NSPredicate(format: "isTrusted == false")
    let isVariant = NSPredicate(format: "isVariant == true")
    
    init(cardsTableViewType: CardsTableViewType){
        self.cardsTableViewType = cardsTableViewType
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        delegates.news = self
        
        switch cardsTableViewType {
        case .news:
            DataManager.fetchNews(predicate: untrustedSources)
            cardsViewData = DataManager.news
            transitionManager?.cardsTableViewType = .news
        case .variants:
            cardsViewData = FirebaseManager.variantsData
            transitionManager?.cardsTableViewType = .variants
        default: ()
        }
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {}
    
    var trustedSourcesTopConstraint = NSLayoutConstraint()
    var tableViewTopConstaint = NSLayoutConstraint()
    
    func setup(){
        view.backgroundColor = UIColor("#f2f2f7")
        view.addSubview(newsCardsTableView)
        
        switch cardsTableViewType {
        case .news:
            view.addSubviews(views: [trustedSourcesView, newsCardsTableView])
            
            let trustedSourcesConstraints = Constraints(childView: trustedSourcesView, parentView: view, constraints: [
                Constraint(constraintType: .leading, multiplier: 1, constant: 0),
                Constraint(constraintType: .trailing, multiplier: 1, constant: 0),
                Constraint(constraintType: .height, multiplier: 1, constant: 120)
            ])
            trustedSourcesConstraints.addConstraints()
            trustedSourcesTopConstraint = NSLayoutConstraint(item: trustedSourcesView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([trustedSourcesTopConstraint])
            
            NSLayoutConstraint.activate([
                newsCardsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
                newsCardsTableView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
                newsCardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                newsCardsTableView.topAnchor.constraint(equalTo: trustedSourcesView.bottomAnchor, constant: -10)
            ])
        case .variants:
            view.addSubview(newsCardsTableView)
            defaultAnchors(childView: newsCardsTableView, parentView: view)
        default: ()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch cardsTableViewType {
        case .news:
            delegates.main.tabBarExtension(visibility: .show)
        case .variants: ()
        default: ()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        switch cardsTableViewType {
        case .news:
            delegates.main.tabBarExtension(visibility: .hide)
        case .variants: ()
        default: ()
        }
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsViewData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cardCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<NewsCardView>
        let cardViewModel = cardsViewData![indexPath.row]
        guard let cellView = cardCell.cellView else {
            let cardView = NewsCardView(article: cardViewModel)
            cardCell.cellView = cardView

            return cardCell
        }
        
        cellView.configure(with: cardViewModel)
        cardCell.clipsToBounds = false
        cardCell.contentView.clipsToBounds = false
        cardCell.cellView?.clipsToBounds = false
        cardCell.layer.masksToBounds = false
        cardCell.contentView.layer.masksToBounds = false
        cardCell.cellView?.layer.masksToBounds = false
        
        return cardCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardViewModel = cardsViewData![indexPath.row]
        let detailView = FullScreenCardView(article: cardViewModel)
        detailView.modalPresentationStyle = .overCurrentContext
        detailView.transitioningDelegate = transitionManager
        present(detailView, animated: true, completion: nil)
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    func selectedCellCardView() -> NewsCardView? {
        guard let indexPath = newsCardsTableView.indexPathForSelectedRow else { return nil }
        let cell = newsCardsTableView.cellForRow(at: indexPath) as! GenericTableViewCell<NewsCardView>
        guard let cardView = cell.cellView else { return nil }

        return cardView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

extension NewsViewController: NewsDelegate{
    func scrollToTop(){
        newsCardsTableView.setContentOffset(.zero, animated: true)
    }
    
    func refreshData(){
        switch trusted {
        case true:
            DataManager.fetchNews(predicate: trustedSources)
            cardsViewData = DataManager.news
            newsCardsTableView.reloadData()
        case false:
            DataManager.fetchNews(predicate: untrustedSources)
            cardsViewData = DataManager.news
            newsCardsTableView.reloadData()
        }
    }
    
    func externalSourceArticleTap(index: Int){
        let indexPath = IndexPath(row: 0, section: 0)
        newsCardsTableView.selectRow(at: indexPath, animated: false, scrollPosition: .top)
        newsCardsTableView.delegate?.tableView?(newsCardsTableView, didSelectRowAt: indexPath)
    }
}
