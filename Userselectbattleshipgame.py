import tkinter as tk
from tkinter import messagebox


class BattleshipGame:
    def __init__(self, root):
        self.root = root
        self.root.title("Place Your Ship - Battleship Game")

        self.board_size = 6
        self.placing_ship = True
        self.ship_positions = []
        self.create_board()

    def create_board(self):
        self.buttons = [[tk.Button(self.root, width=4, height=2, bg='blue',
                                   command=lambda x=i, y=j: self.button_click(x, y))
                         for j in range(self.board_size)]
                        for i in range(self.board_size)]

        for i in range(self.board_size):
            for j in range(self.board_size):
                self.buttons[i][j].grid(row=i, column=j)

    def button_click(self, x, y):
        if self.placing_ship:
            self.place_ship(x, y)
        else:
            self.play_game(x, y)

    def place_ship(self, x, y):
        if len(self.ship_positions) == 0:
            self.ship_positions.append((x, y))
            self.buttons[x][y].config(bg='green')
        elif len(self.ship_positions) == 1:
            first_x, first_y = self.ship_positions[0]
            if x == first_x:
                if abs(y - first_y) == 1:
                    self.ship_positions.append((x, y))
                    self.buttons[x][y].config(bg='green')
            elif y == first_y:
                if abs(x - first_x) == 1:
                    self.ship_positions.append((x, y))
                    self.buttons[x][y].config(bg='green')
        elif len(self.ship_positions) == 2:
            first_x, first_y = self.ship_positions[0]
            second_x, second_y = self.ship_positions[1]

            if (x, y) not in self.ship_positions:
                if first_x == second_x:
                    if abs(y - second_y) == 1 or abs(y - first_y) == 1:
                        self.ship_positions.append((x, y))
                        self.buttons[x][y].config(bg='green')
                elif first_y == second_y:
                    if abs(x - second_x) == 1 or abs(x - first_x) == 1:
                        self.ship_positions.append((x, y))
                        self.buttons[x][y].config(bg='green')

        if len(self.ship_positions) == 3:
            for x, y in self.ship_positions:
                self.buttons[x][y].config(bg='blue')

            messagebox.showinfo("Ship Placed", "Your ship has been placed! Start the game.")
            self.placing_ship = False
            self.root.title("Battleship Game")

    def play_game(self, x, y):
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