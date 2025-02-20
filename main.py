from tkinter import Tk
from ui import BattleshipUI
from game import BattleshipGame

def main():
    root = Tk()
    game = BattleshipGame()
    BattleshipUI(root, game)
    root.mainloop()

if __name__ == "__main__":
    main()
