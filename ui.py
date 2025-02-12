import tkinter as tk
from tkinter import messagebox
from ttkbootstrap import Style
from game import TicTacToeGame

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
