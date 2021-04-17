//
//  AlphaBetaTuning.swift
//  AI-4
//
//  Created by ali on 4/17/21.
//

import Foundation


class Alpha_Beta_PruningGame: Game {
    
    var beta: Int = -2
    var alpha: Int = 2

    
    override func min() -> (Int, Int, Int) {
        var value = 2
        var x: Int? = nil
        var y: Int? = nil
        
        let result = getWinner()
        
        if result == "X" {
            return (-1, 0, 0)
        } else if result == "O" {
            return (1, 0, 0)
        } else if result == emptyItem {
            return (0, 0, 0)
        }
        
        for i in 0 ..< 3{
            for j in 0 ..< 3{
                if self.board[i][j] == emptyItem {
                    self.board[i][j] = "X"
                    var m = 0
                    (m, _, _) = self.max()
                    if m < value {
                        value = m
                        x = i
                        y = j
                    }
                    self.board[i][j] = emptyItem

                    if value <= alpha {
                          return (value, x ?? 0, y ?? 0)
                    }

                    if value < beta {
                          beta = value
                    }
                }
            }
        }
        
        return (value, x ?? 0, y ?? 0)
    }
    
    override func max() -> (Int, Int, Int) {
        var value = -2
        
        var x: Int? = nil
        var y: Int? = nil
        let result = getWinner()
        
        if result == "X" {
            return (-1, 0, 0)
        } else if result == "O" {
            return (1, 0, 0)
        } else if result == emptyItem {
            return (0, 0, 0)
        }
        
        for i in 0 ..< 3{
            for j in 0 ..< 3{
                if self.board[i][j] == emptyItem {
                    self.board[i][j] = "O"
                    var m = 0
                    (m, _, _) = self.min()
                    if m > value {
                        value = m
                        x = i
                        y = j
                    }
                    self.board[i][j] = emptyItem
                    
                    if value >= beta{
                        return (value, x ?? 0, y ?? 0)
                    }
                    
                    if value > alpha {
                        alpha = value
                    }
                }
            }
        }
        return (value, x ?? 0, y ?? 0)
    }
}
