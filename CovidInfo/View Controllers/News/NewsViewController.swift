//
//  ArticlesView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.03.2022.
//

import Foundation
import UIKit

class NewsViewController: UIViewController{
    lazy var trustedSourcesCardsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.registerCell(GenericTableViewCell<CardView>.self)
        tableView.registerCell(GenericTableViewCell<TrustedSources>.self)
        tableView.cornerRadius = 24
        tableView.backgroundColor = .white
        return tableView
    }()
    
    let transitionManager = CardTransitionManager()
    let trustedSourcesCardsViewData: [Article] = CardsData.shared.cards
    var trustedSourcesCardsTableViewTopConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        delegates.news = self
        view.backgroundColor = .clear
        self.view.addSubview(trustedSourcesCardsTableView)
        trustedSourcesCardsTableViewTopConstraint = trustedSourcesCardsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100)
        NSLayoutConstraint.activate([
            trustedSourcesCardsTableViewTopConstraint,
            trustedSourcesCardsTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            trustedSourcesCardsTableView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            trustedSourcesCardsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trustedSourcesCardsViewData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0:
            let cardCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<TrustedSources>
            guard cardCell.cellView != nil else {
                let trustedSource = TrustedSources()
                trustedSource.setup()
                cardCell.addSubview(trustedSource)
                defaultAnchors(childView: trustedSource, parentView: cardCell)
                return cardCell
            }
            
            cardCell.clipsToBounds = false
            cardCell.contentView.clipsToBounds = false
            cardCell.cellView?.clipsToBounds = false
            cardCell.layer.masksToBounds = false
            cardCell.contentView.layer.masksToBounds = false
            cardCell.cellView?.layer.masksToBounds = false
        
            return cardCell
        default:
            let cardCell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableViewCell<CardView>
            let cardViewModel = trustedSourcesCardsViewData[indexPath.row - 1]
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
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 110 : 450
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cardViewModel = trustedSourcesCardsViewData[indexPath.row]
        let detailView = FullScreenCardView(article: cardViewModel)
        detailView.modalPresentationStyle = .overCurrentContext
        detailView.transitioningDelegate = transitionManager
        present(detailView, animated: true, completion: nil)
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
    }
    
    func selectedCellCardView() -> CardView? {
        guard let indexPath = trustedSourcesCardsTableView.indexPathForSelectedRow else { return nil }
        let cell = trustedSourcesCardsTableView.cellForRow(at: indexPath) as! GenericTableViewCell<CardView>
        guard let cardView = cell.cellView else { return nil }

        return cardView
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollLenghtForContentView = scrollView.contentOffset.y/5
        delegates.main.scrollAnimation(size: scrollView.contentOffset.y)
        if 30 - scrollLenghtForContentView > -70 {
            trustedSourcesCardsTableViewTopConstraint.constant = 100 - scrollLenghtForContentView
        }
    }
}

extension NewsViewController: NewsDelegate{
    func removeViewController(){
        embed.removeFromParent(viewController: self)
    }
}
