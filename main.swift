//
//  main.swift
//  AI-4
//
//  Created by ali on 4/17/21.
//

import Foundation

class Game {
    
    var board: [[String]] = []
    var player_turn = "X"
    var result: String? = nil
    var emptyItem = " - "
    
    init() {
        board = [[emptyItem, emptyItem, emptyItem],
                 [emptyItem, emptyItem, emptyItem],
                 [emptyItem, emptyItem, emptyItem]]
        self.player_turn = "X"
    }
    
    func drawBoard() {
        for i in 0 ..<  3{
            for j in 0 ..<  3{
                print("\(board[i][j])", terminator:" ")
            }
            print("\n")
        }
    }
    
    func isLegal(x: Int, y: Int) -> Bool{
        if (x < 0) || (y < 0) || (y > 2) || (x > 2) {
            return false
        } else if self.board[x][y] != emptyItem {
            return false
        } else {
            return true
        }
    }
    
    
    // If returns - this is a tie
    func getWinner() -> String? {
        
        //Vertical Win
        for i in 0 ..< 3 {
            if self.board[0][i] != emptyItem && self.board[0][i] == self.board[1][i] && self.board[1][i] == self.board[2][i] {
                return self.board[0][i]
            }
        }
        
        //Horizontal win
        for i in 0 ..< 3 {
            if self.board[i] == ["X", "X", "X"] {
                return "X"
            } else if self.board[i] == ["O", "O", "O"] {
                return "O"
            }
        }
        
        //Main diagonal win
        if self.board[0][0] != emptyItem && self.board[0][0] == self.board[1][1] && self.board[0][0] == self.board[2][2] {
            return self.board[0][0]
        }
        
        //Second diagonal win
        if self.board[0][2] != emptyItem && self.board[0][2] == self.board[1][1] && self.board[0][2] == self.board[2][0] {
            return self.board[0][2]
        }
        
        for i in 0 ..< 3 {
            for j in 0 ..< 3 {
                if board[i][j] == emptyItem {
                    return nil
                }
            }
        }
        return emptyItem
    }
    
    
    func min() -> (Int, Int, Int) {
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
                }
            }
        }
        
        return (value, x ?? 0, y ?? 0)
    }
    
    func max() -> (Int, Int, Int) {
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
                }
            }
        }
        
        return (value, x ?? 0, y ?? 0)
    }
    
    func start() {
        while true {
            self.drawBoard()
            self.result = self.getWinner()

            if self.result != nil {
                if result == "X" {
                    print("The winner is X!")
                } else if result == "O" {
                    print("The winner is O!")
                } else if result == emptyItem {
                    print("It's a tie!")
                }
                self.board = [[emptyItem, emptyItem, emptyItem],
                         [emptyItem, emptyItem, emptyItem],
                         [emptyItem, emptyItem, emptyItem]]
                self.player_turn = "X"
                return
            }
            
            var px: Int = -1
            var py: Int = -1
            
            if self.player_turn == "X" {
                while true {
                    print("Insert the X coordinate: ", terminator:"")
                    px = Int(readLine() ?? "-1")!
                    print("Insert the Y coordinate: ", terminator:"")
                    py = Int(readLine() ?? "-1")!
                    
                    
                    if self.isLegal(x: px, y: py){
                        self.board[px][py] = "X"
                        self.player_turn = "O"
                        break
                    } else {
                        print("The move is not valid! Try again.")
                    }
                }
            } else {
                (_ , px, py) = self.max()
                self.board[px][py] = "O"
                self.player_turn = "X"
            }
        }
    }
    
    func recomendation() {
        var qx: Int = -1
        var qy: Int = -1
        (_, qx, qy) = self.min()
        print("Recommended move: X = \(qx), Y = \(qy)")
    }
    
}


let g = Game()
g.start()



