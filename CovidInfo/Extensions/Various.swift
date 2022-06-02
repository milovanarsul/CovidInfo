//
//  Various.swift
//  CovidInfo
//
//  Created by Milovan Arsul on 24.05.2022.
//

import Foundation
import UIKit

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        var wordBoxes = [CGSize]()
        var calculatedHeight = CGFloat.zero
        var currentLine = 0
        
        for word in self.wordsWithWordSeparators() {
            let box = word.boundingRect(with: CGSize.zero, attributes: [.font: font], context: nil)
            let boxSize = CGSize(width: box.width, height: box.height)
            
            if wordBoxes.isEmpty == true {
                wordBoxes.append(boxSize)
            }
            else if wordBoxes[currentLine].width + boxSize.width > width {
                wordBoxes.append(boxSize)
                currentLine += 1
            }
            else {
                wordBoxes[currentLine].width += boxSize.width
                wordBoxes[currentLine].height = max(wordBoxes[currentLine].height, boxSize.height)
            }
        }
        
        for wordBox in wordBoxes {
            calculatedHeight += wordBox.height
        }
        
        return calculatedHeight + 125
    }
    
    func wordsWithWordSeparators () -> [String] {
        let range = self.startIndex..<self.endIndex
        var words = [String]()
        
        self.enumerateSubstrings(in: range, options: .byWords) { (substr, substrRange, enclosingRange, stop) in
            let wordWithWordSeparators = String(self[enclosingRange])
            words.append(wordWithWordSeparators)
        }
        
        return words
    }
}

func stringToDate(string: String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ro_RO")
    dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
    let date = dateFormatter.date(from: string)
    return date!
}

func createDate(day: Int, month: Int, year: Int) -> Date{
    var dateComponents = DateComponents()
    dateComponents.day = day
    dateComponents.month = month
    dateComponents.year = year
    
    let userCalendar = Calendar(identifier: .gregorian)
    let date = userCalendar.date(from: dateComponents)
    return date!
}
