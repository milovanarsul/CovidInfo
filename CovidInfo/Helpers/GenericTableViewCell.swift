//
//  GenericTableViewCell.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 09.06.2022.
//

import Foundation
import UIKit

class GenericTableViewCell<View: UIView>: UITableViewCell {
    var cellView: View? {
        didSet {
            guard cellView != nil else { return }
            setUpViews()
        }
    }
    
    private func setUpViews() {
        guard let cellView = cellView else { return }
        
        addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        defaultAnchors(childView: cellView, parentView: self)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
    }
}
