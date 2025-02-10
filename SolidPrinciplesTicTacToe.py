#!/usr/bin/env python
# coding: utf-8

# In[1]:


import tkinter as tk
from tkinter import messagebox
from ttkbootstrap import Style

class TicTacToeGame:
    def __init__(self):
        self.board = [['' for _ in range(3)] for _ in range(3)]
        self.current_player = "X"
    
    def make_move(self, row, col):
        if self.board[row][col] == '':
            self.board[row][col] = self.current_player
            return True
        return False

    def check_result(self):
        lines = (
            self.board[0], self.board[1], self.board[2],
            [self.board[i][0] for i in range(3)],
            [self.board[i][1] for i in range(3)],
            [self.board[i][2] for i in range(3)],
            [self.board[i][i] for i in range(3)],
            [self.board[i][2 - i] for i in range(3)]
        )
        
        for line in lines:
            if line[0] == line[1] == line[2] != '':
                return line[0]
        
        if all(self.board[i][j] != '' for i in range(3) for j in range(3)):
            return "Draw"
        
        return None

    def reset_game(self):
        self.board = [['' for _ in range(3)] for _ in range(3)]
        self.current_player = "X"

class TicTacToeUI:
    def __init__(self, root, game):
        self.root = root
        self.game = game
        self.buttons = []
        
        self.setup_ui()
    
    def setup_ui(self):
        self.root.title("Tic-Tac-Toe")
        style = Style(theme="flatly")
        self.root.geometry("265x320")
        
        for i in range(3):
            row_buttons = []
            for j in range(3):
                button = tk.Button(self.root, text='', width=10, height=6,
                                   command=lambda i=i, j=j: self.handle_move(i, j))
                button.grid(row=i, column=j, padx=5, pady=5)
                row_buttons.append(button)
            self.buttons.append(row_buttons)
    
    def handle_move(self, row, col):
        if self.game.make_move(row, col):
            self.buttons[row][col].configure(text=self.game.current_player)
            winner = self.game.check_result()
            
            if winner:
                self.show_result(winner)
                self.reset_board()
            else:
                self.game.current_player = "O" if self.game.current_player == "X" else "X"
    
    def show_result(self, winner):
        message = "It's a draw!" if winner == "Draw" else f"Congrats Player {winner} wins!"
        messagebox.showinfo("Game Over", message)
    
    def reset_board(self):
        self.game.reset_game()
        for row in self.buttons:
            for button in row:
                button.configure(text='')

if __name__ == "__main__":
    root = tk.Tk()
    game = TicTacToeGame()
    ui = TicTacToeUI(root, game)
    root.mainloop()


# In[ ]:




