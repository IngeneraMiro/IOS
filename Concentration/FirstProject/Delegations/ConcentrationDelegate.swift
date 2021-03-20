//
//  ConcentrationDelegate.swift
//  Concentration
//
//  Created by Miroslav Shtregarski on 18.03.21.
//

import Foundation

protocol ConcentrationDelegateToViewController: class {
    func softwareRestartTheGame()
    func updateScorePoints(newScorePoints: Int)
    func updateFlippedCrdsCounter(counterIncrement: Int)
    func changeViewByModel()
}
