import tkinter as tk
from game import TicTacToeGame
from ui import TicTacToeUI

if __name__ == "__main__":
    root = tk.Tk()
    game = TicTacToeGame()
    ui = TicTacToeUI(root, game)
    root.mainloop()
