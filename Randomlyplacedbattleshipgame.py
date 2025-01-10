import tkinter as tk
from tkinter import messagebox
import random


class BattleshipGame:
    def __init__(self, root):
        self.root = root
        self.root.title("Battleship Game")

        self.board_size = 6
        self.ship_positions = self.generate_ship_positions()

        self.create_board()

    def generate_ship_positions(self):
        orientation = random.choice(['horizontal', 'vertical'])
        if orientation == 'horizontal':
            row = random.randint(0, self.board_size - 1)
            col = random.randint(0, self.board_size - 3)
            return [(row, col), (row, col + 1), (row, col + 2)]
        else:
            row = random.randint(0, self.board_size - 3)
            col = random.randint(0, self.board_size - 1)
            return [(row, col), (row + 1, col), (row + 2, col)]

    def create_board(self):
        self.buttons = [[tk.Button(self.root, width=4, height=2, bg='blue',
                                   command=lambda x=i, y=j: self.button_click(x, y))
                         for j in range(self.board_size)]
                        for i in range(self.board_size)]

        for i in range(self.board_size):
            for j in range(self.board_size):
                self.buttons[i][j].grid(row=i, column=j)

    def button_click(self, x, y):
        if (x, y) in self.ship_positions:
            self.buttons[x][y].config(bg='red', state=tk.DISABLED)
            self.ship_positions.remove((x, y))
            if not self.ship_positions:
                messagebox.showinfo("Congratulations!", "You sunk the ship!")
                self.root.destroy()
        else:
            self.buttons[x][y].config(bg='white', state=tk.DISABLED)
            messagebox.showinfo("Oops!", "Try again.")


def main():
    root = tk.Tk()
    game = BattleshipGame(root)
    root.mainloop()


if __name__ == "__main__":
    main()
