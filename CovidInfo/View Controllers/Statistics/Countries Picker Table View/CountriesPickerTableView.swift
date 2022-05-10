//
//  CountriesPickerTableView.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 10.05.2022.
//

import UIKit

class CountriesPickerTableView: UITableView {
    
    func setup(){
        delegate = self
        dataSource = self
        registerCell(CountriesPickerTableViewCell.self)
        separatorStyle = .singleLine
        separatorColor = .black
        backgroundColor = .clear
    }
}

extension CountriesPickerTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CountriesPickerTableViewCell
        cell.country = CountryCell(image: "", name: "")
        cell.clipsToBounds = false
        cell.contentView.clipsToBounds = false
        cell.layer.masksToBounds = false
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
    }
}
