//
//  Theme.swift
//  Memory
//
//  Created by Miroslav Shtregarski on 18.03.21.
//

import Foundation

class Theme{
  static private var themeCollection = [["☃️","🦋","🍏","🎃","🪆","⛱","🍭","🍔","🌞","👻","💀"],
                          ["👉","👆","👇","👈","👍","👎","🤘","👏","👊","🤝","👌"],
                          ["😂","😀","😇","😎","🥸","😍","🤪","☹️","🤥","🤐","🤠"],
                          ["🐫","🦞","🦣","🐬","🐖","🦤","🐝","🐌","🐥","🦧","🐓"],
                          ["🍎","🍌","🍓","🍉","🍇","🍋","🍊","🥝","🍆","🍒","🍅"],
                          ["🎱","🏈","🏀","⚽️","🥊","🏂","🏹","🏓","🪂","🏇","🚴‍♂️"]]
        
    
 static  func getRandomTheme() -> Array<String> {
         let randomThemeNumber = Int(arc4random_uniform(UInt32(themeCollection.count)))
         return self.themeCollection[randomThemeNumber]
    }
 
    
}
