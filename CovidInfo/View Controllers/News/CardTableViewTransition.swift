//
//  CardTransitionManager.swift
//  CovidInfo
//
//  Created by Milovan Arsul 25.03.2022.
//

import UIKit

enum CardTransitionType {
    case presentation
    case dismissal
    
    var blurAlpha: CGFloat { return self == .presentation ? 1 : 0 }
    var dimAlpha: CGFloat { return self == .presentation ? 0.5 : 0 }
    var closeAlpha: CGFloat { return self == .presentation ? 1 : 0 }
    var cornerRadius: CGFloat { return self == .presentation ? 20.0 : 0.0 }
    var cardMode: CardMode { return self == .presentation ? .card : .full }
    var next: CardTransitionType { return self == .presentation ? .dismissal : .presentation }
}

class CardTransitionManager: NSObject {
    var transitionOrigin: Bool = false
    var transitionDeorigin: Bool = false
    let transitionDuration: Double = 1.0
    var transition: CardTransitionType = .presentation
    let shrinkDuration: Double = 0.2
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var whiteView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var cardsTableViewType: CardsTableViewType = .news
    
    private func addBackgroundViews(to containerView: UIView) {
        blurEffectView.frame = containerView.frame
        blurEffectView.alpha = transition.next.blurAlpha
        containerView.addSubview(blurEffectView)
        
        dimmingView.frame = containerView.frame
        dimmingView.alpha = transition.next.dimAlpha
        containerView.addSubview(dimmingView)
    }
    
    private func createCardViewCopy(cardView: NewsCardView) -> NewsCardView {
        let cardModel = cardView.article
        cardModel.viewMode = transition.cardMode
        let cardViewCopy = NewsCardView(article: cardModel)
        return cardViewCopy
    }
}

extension CardTransitionManager: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        containerView.subviews.forEach({ $0.removeFromSuperview() })
        
        addBackgroundViews(to: containerView)
        
        var fromView: UIViewController?
        var toView: UIViewController?
        
        switch cardsTableViewType {
        case .news:
            fromView = transitionDeorigin ? transitionContext.viewController(forKey: .from) : delegates.tabBar.getCurrentPresentedViewController()
            toView = transitionDeorigin ? delegates.tabBar.getCurrentPresentedViewController() : transitionContext.viewController(forKey: .to)
        case .variants: ()
            fromView = transitionDeorigin ? transitionContext.viewController(forKey: .from) : delegates.info.getCardsViewController()
            toView = transitionDeorigin ? delegates.info.getCardsViewController() : transitionContext.viewController(forKey: .to)
        }
    
        guard let cardView = (transition == .presentation) ? (fromView as! NewsViewController).selectedCellCardView() : (toView as! NewsViewController).selectedCellCardView() else {return}
        
        let cardViewCopy = createCardViewCopy(cardView: cardView)
        containerView.addSubview(cardViewCopy)
        cardView.isHidden = true
        
        let absoluteCardViewFrame = cardView.convert(cardView.frame, to: nil)
        cardViewCopy.frame = absoluteCardViewFrame
        cardViewCopy.layoutIfNeeded()
        
        whiteView.frame = transition == .presentation ? cardViewCopy.containerView.frame : containerView.frame
        whiteView.layer.cornerRadius = transition.cornerRadius
        cardViewCopy.insertSubview(whiteView, aboveSubview: cardViewCopy.shadowView)
        
        if cardView.article.backgroundType == .light {
            closeButton.setImage(UIImage(named: "darkOnLight"), for: .normal)
        } else {
            closeButton.setImage(UIImage(named: "lightOnDark"), for: .normal)
        }
        
        cardViewCopy.containerView.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: cardViewCopy.shadowView.topAnchor, constant: 20.0),
            closeButton.widthAnchor.constraint(equalToConstant: 30.0),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor, multiplier: 1.0),
            closeButton.rightAnchor.constraint(equalTo: cardViewCopy.shadowView.rightAnchor, constant: -20.0)
        ])
        
        if transition == .presentation {
            let detailView = toView as! FullScreenCardView
            containerView.addSubview(detailView.view)
            detailView.viewsAreHidden = true
            closeButton.alpha = transition.next.closeAlpha
            
            moveAndConvertToCardView(cardView: cardViewCopy, containerView: containerView, yOriginToMoveTo: 0) {
                detailView.viewsAreHidden = false
                cardViewCopy.removeFromSuperview()
                cardView.isHidden = false
                detailView.createSnapshotOfView()
                transitionContext.completeTransition(true)
            }
        } else {
            // Dismissal
            let detailView = fromView as! FullScreenCardView
            detailView.viewsAreHidden = true
            closeButton.alpha = transition.next.closeAlpha
            cardViewCopy.frame = CGRect(x: 0, y: 0, width: (detailView.cardView?.frame.size.width)!, height: (detailView.cardView?.frame.size.height)!)
            moveAndConvertToCardView(cardView: cardViewCopy, containerView: containerView, yOriginToMoveTo: absoluteCardViewFrame.origin.y) {
                cardView.isHidden = false
                transitionContext.completeTransition(true)
            }
        }
    }
    
    func makeShrinkAnimator(for cardView: NewsCardView) -> UIViewPropertyAnimator {
        return UIViewPropertyAnimator(duration: shrinkDuration, curve: .easeOut) {
            cardView.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self.dimmingView.alpha = 0.05
        }
    }
    
    func makeExpandContractAnimator(for cardView: NewsCardView, in containerView: UIView, yOrigin: CGFloat) -> UIViewPropertyAnimator {
        let springTiming = UISpringTimingParameters(dampingRatio: 0.75, initialVelocity: CGVector(dx: 0, dy: 4))
        let animator = UIViewPropertyAnimator(duration: transitionDuration - shrinkDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            cardView.transform = .identity
            cardView.containerView.layer.cornerRadius = self.transition.next.cornerRadius
            cardView.frame.origin.y = yOrigin
            
            self.blurEffectView.alpha = self.transition.blurAlpha
            self.dimmingView.alpha = self.transition.dimAlpha
            self.closeButton.alpha = self.transition.closeAlpha
            
            self.whiteView.layer.cornerRadius = self.transition.next.cornerRadius
            
            containerView.layoutIfNeeded()
            
            self.whiteView.frame = self.transition == .presentation ? containerView.frame : cardView.containerView.frame
        }
        return animator
    }
    
    func moveAndConvertToCardView(cardView: NewsCardView, containerView: UIView, yOriginToMoveTo: CGFloat, completion: @escaping () -> ()) {
        let shrinkAnimator = makeShrinkAnimator(for: cardView)
        let expandContractAnimator = makeExpandContractAnimator(for: cardView, in: containerView, yOrigin: yOriginToMoveTo)
        
        expandContractAnimator.addCompletion { _ in
            completion()
        }
        
        if transition == .presentation {
            shrinkAnimator.addCompletion { _ in
                cardView.layoutIfNeeded()
                cardView.updateLayout(for: self.transition.next.cardMode)
                expandContractAnimator.startAnimation()
            }
            
            shrinkAnimator.startAnimation()
        } else {
            cardView.layoutIfNeeded()
            cardView.updateLayout(for: self.transition.next.cardMode)
            expandContractAnimator.startAnimation()
        }
    }
}

extension CardTransitionManager: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .presentation
        transitionOrigin = true
        transitionDeorigin = false
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition = .dismissal
        transitionDeorigin = true
        transitionOrigin = false
        return self
    }
}
