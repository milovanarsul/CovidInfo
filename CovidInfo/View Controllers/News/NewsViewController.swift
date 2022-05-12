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
        tableView.registerCell(GenericTableViewCell<CardView>.self)
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
    
    func fetchData(predicate: NSPredicate){
        cardsViewData?.removeAll()
        let request = Article.fetchRequest() as NSFetchRequest<Article>
        request.predicate = predicate
        
        do {
            self.cardsViewData = try AppDelegate.context.fetch(request)
            DispatchQueue.main.async {
                self.newsCardsTableView.reloadData()
            }
        } catch {
            fatalError()
        }
    }
    
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
            fetchData(predicate: untrustedSources)
            transitionManager?.cardsTableViewType = .news
        case .variants:
            fetchData(predicate: isVariant)
            transitionManager?.cardsTableViewType = .variants
        default: ()
        }
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {}
    
    var trustedSourcesTopConstraint = NSLayoutConstraint()
    var tableViewTopConstaint = NSLayoutConstraint()
    
    func setup(){
        view.backgroundColor = .clear
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
        let cardCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<CardView>
        let cardViewModel = cardsViewData![indexPath.row]
        guard let cellView = cardCell.cellView else {
            let cardView = CardView(article: cardViewModel)
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
    
    func selectedCellCardView() -> CardView? {
        guard let indexPath = newsCardsTableView.indexPathForSelectedRow else { return nil }
        let cell = newsCardsTableView.cellForRow(at: indexPath) as! GenericTableViewCell<CardView>
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
            fetchData(predicate: trustedSources)
        case false:
            fetchData(predicate: untrustedSources)
        }
    }
}
