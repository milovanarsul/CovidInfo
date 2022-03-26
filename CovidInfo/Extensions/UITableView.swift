//
//  UITableView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 26.03.2022.
//

import Foundation
import UIKit

extension UITableView {
    func registerCell<Cell: UITableViewCell>(_ cellClass: Cell.Type) {
        register(cellClass, forCellReuseIdentifier: String(describing: cellClass))
    }

    func dequeueReusableCell<Cell: UITableViewCell>(forIndexPath indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {
            fatalError()
        }
        return cell
    }
}

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
}
