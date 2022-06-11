//
//  HomeViewTableViewCells.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 30.05.2022.
//

import Foundation
import UIKit

class HomeViewTableViewCell: UITableViewCell {
    var parentViewController: UIViewController?
    
    lazy var simptomeAndPreventie: UIView = {
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: "Simptome si preventie", color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
            return label
        }()
        
        lazy var simptomeAndPreventie: UIStackView = {
            let stackView = PreventieAndSimptomeShortcut()
            return stackView
        }()
        
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        parentView.addSubviews(views: [label, simptomeAndPreventie])
        
        let labelConstraints = Constraints(childView: label, parentView: parentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 4),
            Constraint(constraintType: .top, multiplier: 1, constant: 10)
        ])
        labelConstraints.addConstraints()
        
        let simptomeAndPreventieConstraints = Constraints(childView: simptomeAndPreventie, parentView: parentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.98, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        
        simptomeAndPreventieConstraints.addConstraints()
        simptomeAndPreventie.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        return parentView
        
    }()
    
    lazy var quickCharts: UIView = {
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: "Statistici", color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
            return label
        }()
        
        lazy var button: UIButton = {
            let button = UIButton()
            button.initialize(title: "Mai mult", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 16), backgroundColor: .clear, image: UIImage(systemName: "arrow.forward"), imagePlacement: NSDirectionalRectEdge.trailing)
            button.addTarget(self, action: #selector(statisticsAction), for: .touchUpInside)
            return button
        }()
        
        lazy var charts: UIView = {
            let view = UIView()
            parentViewController!.addSubSwiftUIView(CasesAndDeaths(currentData: DataManager.currentCountryData!, historicData: DataManager.historicCountryData!), to: view)
            return view
        }()
        
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        parentView.addSubviews(views: [label, button])
        
        let labelConstraints = Constraints(childView: label, parentView: parentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
            Constraint(constraintType: .height, multiplier: 1, constant: 12)
        ])
        labelConstraints.addConstraints()
        
        let buttonConstraints = Constraints(childView: button, parentView: parentView, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: -10)
        ])
        buttonConstraints.addConstraints()
        
        parentView.addSubview(charts)
        
        let chartsConstraints = Constraints(childView: charts, parentView: parentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 5)
        ])
        chartsConstraints.addConstraints()
        charts.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50).isActive = true
        
        return parentView
    }()
    
    lazy var latestNews: UIView = {
        let latestArticle: Article = (DataManager.news?.first)!
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: "Ultima stire", color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
            return label
        }()
        
        lazy var button: UIButton = {
            let button = UIButton()
            button.initialize(title: "Mai mult", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 16), backgroundColor: .clear, image: UIImage(systemName: "arrow.forward"), imagePlacement: NSDirectionalRectEdge.trailing)
            button.addTarget(self, action: #selector(newsAction), for: .touchUpInside)
            return button
        }()
        
        lazy var articleCard: UIView = {
            lazy var imageView: UIImageView = {
                let imageView = UIImageView()
                imageView.downloaded(from: latestArticle.backgroundImage!)
                imageView.contentMode = .scaleAspectFill
                imageView.layer.cornerRadius = 24
                imageView.clipsToBounds = true
                return imageView
            }()
            
            lazy var articleLabel: UILabel = {
                let label = UILabel()
                label.initialize(text: latestArticle.title!, color: .white, font: boldFont(size: 16), alignment: .left, lines: 0)
                return label
            }()
            
            let parentView = UIView()
            parentView.addSubviews(views: [imageView, articleLabel])
            
            defaultConstraints(childView: imageView, parentView: parentView)
            
            let articleLabelConstraints = Constraints(childView: articleLabel, parentView: parentView, constraints: [
                Constraint(constraintType: .leading, multiplier: 1, constant: 12),
                Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
                Constraint(constraintType: .bottom, multiplier: 1, constant: 12)
            ])
            articleLabelConstraints.addConstraints()
            
            parentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(newsArticleAction)))
            
            return parentView
        }()
        
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.heightAnchor.constraint(equalToConstant: 230).isActive = true
        parentView.layer.cornerRadius = 24
        parentView.clipsToBounds = true
        parentView.addSubviews(views: [label, button, articleCard])
        
        let labelConstraints = Constraints(childView: label, parentView: parentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
        ])
        labelConstraints.addConstraints()
        
        let buttonConstraints = Constraints(childView: button, parentView: parentView, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: -5)
        ])
        buttonConstraints.addConstraints()
        
        let articleCardConstraints = Constraints(childView: articleCard, parentView: parentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.98, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        articleCardConstraints.addConstraints()
        articleCard.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20).isActive = true
        
        
        return parentView
    }()
    
    lazy var triajEpidemiologic: UIView = {
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: "Triaj Epidemiologic", color: .white, font: boldFont(size: 25), alignment: .left, lines: 1)
            return label
        }()
        
        lazy var imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "faceShield")!
            imageView.contentMode = .scaleAspectFill
            return imageView
        }()
        
        let parentView = UIView()
        parentView.backgroundColor = UIColor("#c2e1d9")
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        parentView.layer.cornerRadius = 24
        parentView.clipsToBounds = true
        parentView.addSubviews(views: [label, imageView])
        
        let labelConstraints = Constraints(childView: label, parentView: parentView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 12)
        ])
        labelConstraints.addConstraints()
        
        let imageViewConstraints = Constraints(childView: imageView, parentView: parentView, constraints: [
            Constraint(constraintType: .vertical, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalHeight, multiplier: 0.9, constant: 0),
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .aspectRatio, multiplier: (1.0 / 1.0), constant: 0)
        ])
        imageViewConstraints.addConstraints()
        
        parentView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(triajEpidemiologicAction)))
        
        return parentView
    }()
    
    lazy var infoShorcuts: UIView = {
        
        lazy var label: UILabel = {
            let label = UILabel()
            label.initialize(text: "Informatii", color: .black, font: boldFont(size: 16), alignment: .left, lines: 0)
            return label
        }()
        
        lazy var button: UIButton = {
            let button = UIButton()
            button.initialize(title: "Mai mult", titleColor: signatureDarkBlue, cornerRadius: 0, font: boldFont(size: 16), backgroundColor: .clear, image: UIImage(systemName: "arrow.forward"), imagePlacement: NSDirectionalRectEdge.trailing)
            button.addTarget(self, action: #selector(statisticsAction), for: .touchUpInside)
            return button
        }()
        
        lazy var shortcuts: UIStackView = {
            lazy var firstStackView: UIStackView = {
                lazy var sfaturiDeCalatorie: UIImageView = {
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "sfaturiDeCalatorie")!
                    imageView.contentMode = .scaleAspectFill
                    imageView.layer.cornerRadius = 24
                    imageView.clipsToBounds = true
                    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoShortcutOneTapped)))
                    imageView.isUserInteractionEnabled = true
                    return imageView
                }()
                
                lazy var intrebariFrecvente: UIImageView = {
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "intrebariFrecvente")!
                    imageView.contentMode = .scaleAspectFill
                    imageView.layer.cornerRadius = 24
                    imageView.clipsToBounds = true
                    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoShortcutTwoTapped)))
                    imageView.isUserInteractionEnabled = true
                    return imageView
                }()
                
                let firstParentStackView = UIStackView()
                firstParentStackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fillEqually, spacing: 10)
                firstParentStackView.addAranagedSubviews(views: [sfaturiDeCalatorie, intrebariFrecvente])
                firstParentStackView.layer.cornerRadius = 24
                firstParentStackView.clipsToBounds = true
                return firstParentStackView
            }()
            
            lazy var secondStackView: UIStackView = {
                lazy var vaccinare: UIImageView = {
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "vaccinare")!
                    imageView.contentMode = .scaleAspectFill
                    imageView.layer.cornerRadius = 24
                    imageView.clipsToBounds = true
                    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoShortcutThreeTapped)))
                    imageView.isUserInteractionEnabled = true
                    return imageView
                }()
                
                lazy var variante: UIImageView = {
                    let imageView = UIImageView()
                    imageView.image = UIImage(named: "variante")!
                    imageView.contentMode = .scaleAspectFill
                    imageView.layer.cornerRadius = 24
                    imageView.clipsToBounds = true
                    imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(infoShortcutFourTapped)))
                    imageView.isUserInteractionEnabled = true
                    return imageView
                }()
                
                let secondParentStackView = UIStackView()
                secondParentStackView.initalize(axis: .horizontal, alignment: .fill, distribution: .fill, spacing: 10)
                secondParentStackView.addAranagedSubviews(views: [vaccinare, variante])
                secondParentStackView.layer.cornerRadius = 24
                secondParentStackView.clipsToBounds = true
                return secondParentStackView
            }()
            
            let stackView = UIStackView()
            stackView.contentMode = .scaleAspectFit
            stackView.initalize(axis: .vertical, alignment: .fill, distribution: .fillProportionally, spacing: 10)
            stackView.addAranagedSubviews(views: [firstStackView, secondStackView])
            stackView.layer.cornerRadius = 24
            stackView.clipsToBounds = true
            return stackView
        }()
        
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        parentView.heightAnchor.constraint(equalToConstant: 350).isActive = true
        parentView.addSubviews(views: [label, button, shortcuts])
        
        let labelConstraints = Constraints(childView: label, parentView: parentView, constraints: [
            Constraint(constraintType: .leading, multiplier: 1, constant: 12),
            Constraint(constraintType: .top, multiplier: 1, constant: 0),
        ])
        labelConstraints.addConstraints()
        
        let buttonConstraints = Constraints(childView: button, parentView: parentView, constraints: [
            Constraint(constraintType: .trailing, multiplier: 1, constant: -12),
            Constraint(constraintType: .top, multiplier: 1, constant: -5)
        ])
        buttonConstraints.addConstraints()
        
        let shorcutsConstraints = Constraints(childView: shortcuts, parentView: parentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .leading, multiplier: 1, constant: 0),
            Constraint(constraintType: .bottom, multiplier: 1, constant: 0)
        ])
        shorcutsConstraints.addConstraints()
        shortcuts.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        
        return parentView
    }()
    
    func setup(){
        contentView.backgroundColor = UIColor("#f2f2f7")
        
        contentView.addSubviews(views: [simptomeAndPreventie, quickCharts, latestNews, infoShorcuts, triajEpidemiologic])
        
        let siptomeAndPreventieConstraints = Constraints(childView: simptomeAndPreventie, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.96, constant: 0),
            Constraint(constraintType: .top, multiplier: 1, constant: 10),
        ])
        siptomeAndPreventieConstraints.addConstraints()
        
        let quickChartsConstraints = Constraints(childView: quickCharts, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 1, constant: 0)
        ])
        quickChartsConstraints.addConstraints()
        quickCharts.topAnchor.constraint(equalTo: simptomeAndPreventie.bottomAnchor, constant: 10).isActive = true
        
        let latestNewsConstraints = Constraints(childView: latestNews, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.98, constant: 0)
        ])
        latestNewsConstraints.addConstraints()
        latestNews.topAnchor.constraint(equalTo: quickCharts.bottomAnchor, constant: 40).isActive = true
        
        let infoShortcutsConstraints = Constraints(childView: infoShorcuts, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.96, constant: 0),
        ])
        infoShortcutsConstraints.addConstraints()
        infoShorcuts.topAnchor.constraint(equalTo: latestNews.bottomAnchor, constant: 20).isActive = true
        
        let triajEpidemiologicConstraints = Constraints(childView: triajEpidemiologic, parentView: contentView, constraints: [
            Constraint(constraintType: .horizontal, multiplier: 1, constant: 0),
            Constraint(constraintType: .proportionalWidth, multiplier: 0.96, constant: 0)
        ])
        triajEpidemiologicConstraints.addConstraints()
        triajEpidemiologic.topAnchor.constraint(equalTo: infoShorcuts.bottomAnchor, constant: 10).isActive = true
    }
    
    @objc func statisticsAction(_ sender: UIButton){
        delegates.tabBar.goToPage(pageIndex: 3, direction: .forward)
        delegates.customTabBar.goToPage(index: 3)
    }
    
    @objc func homeLocationDisabled(_ sender: UIButton){
        delegates.tabBar.goToPage(pageIndex: 3, direction: .forward)
        delegates.customTabBar.goToPage(index: 3)
    }
    
    @objc func newsAction(_ sender: UIButton){
        delegates.tabBar.goToPage(pageIndex: 2, direction: .forward)
        delegates.customTabBar.goToPage(index: 2)
    }
    
    @objc func newsArticleAction(){
        delegates.tabBar.goToPage(pageIndex: 2, direction: .forward)
        delegates.customTabBar.goToPage(index: 2)
        delegates.news.externalSourceArticleTap(index: 0)
    }
    
    @objc func triajEpidemiologicAction() {
        delegates.homePage.goToPage(pageIndex: 1, direction: .forward)
        delegates.homePage.updateNavigationBar(page: Page(mainPage: .home, childType: .triaj))
        delegates.main.tabAnimation(visibility: .hide)
    }
    
    @objc func infoShortcutOneTapped(){
        delegates.tabBar.goToPage(pageIndex: 1, direction: .forward)
        delegates.customTabBar.goToPage(index: 1)
        delegates.info.setCategoriesIndex(index: 0)
    }
    
    @objc func infoShortcutTwoTapped(){
        delegates.tabBar.goToPage(pageIndex: 1, direction: .forward)
        delegates.customTabBar.goToPage(index: 1)
        delegates.info.setCategoriesIndex(index: 1)
    }
    
    @objc func infoShortcutThreeTapped(){
        delegates.tabBar.goToPage(pageIndex: 1, direction: .forward)
        delegates.customTabBar.goToPage(index: 1)
        delegates.info.setCategoriesIndex(index: 2)
    }
    
    @objc func infoShortcutFourTapped(){
        delegates.tabBar.goToPage(pageIndex: 1, direction: .forward)
        delegates.customTabBar.goToPage(index: 1)
        delegates.info.setCategoriesIndex(index: 3)
        delegates.info.variantsScroll()
    }
}
