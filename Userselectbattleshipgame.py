import tkinter as tk
from tkinter import messagebox


class BattleshipGame:
    def __init__(self, root):
        self.root = root
        self.root.title("Place Your Ship - Battleship Game")

        self.root.geometry("350x350")

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
                self.buttons[i][j].grid(row=i, column=j, sticky="nsew")

        for i in range(self.board_size):
            self.root.grid_rowconfigure(i, weight=1)
            self.root.grid_columnconfigure(i, weight=1)

    def button_click(self, x, y):
        if self.placing_ship:
            self.place_ship(x, y)
        else:
            self.play_game(x, y)

    def place_ship(self, x, y):
        if len(self.ship_positions) == 0:
            self.ship_positions.append((x, y))
            self.buttons[x][y].config(bg='green')
        elif len(self.ship_positions) < 3:
            if self.valid_ship_position(x, y):
                self.ship_positions.append((x, y))
                self.buttons[x][y].config(bg='green')
            else:
                messagebox.showwarning("Invalid Placement", "Ship must be placed in a straight line.")
        if len(self.ship_positions) == 3:
            for x, y in self.ship_positions:
                self.buttons[x][y].config(bg='blue')

            messagebox.showinfo("Ship Placed", "Your ship has been placed! Start the game.")
            self.placing_ship = False
            self.root.title("Battleship Game")

    def valid_ship_position(self, x, y):
        if (x, y) in self.ship_positions:
            return False

        existing_positions = self.ship_positions
        first_x, first_y = existing_positions[0]

        if len(existing_positions) == 1:
            return (abs(x - first_x) == 1 and y == first_y) or (abs(y - first_y) == 1 and x == first_x)

        if len(existing_positions) == 2:
            second_x, second_y = existing_positions[1]
            if first_x == second_x:
                return x == first_x and (abs(y - first_y) == 1 or abs(y - second_y) == 1)
            elif first_y == second_y:
                return y == first_y and (abs(x - first_x) == 1 or abs(x - second_x) == 1)

        return False

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
