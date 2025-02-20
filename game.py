from tkinter import messagebox

class BattleshipGame:
    def __init__(self, board_size=6):
        self.board_size = board_size
        self.placing_ship = True
        self.ship_positions = []

    def place_ship(self, x, y, update_ui_callback):
        if len(self.ship_positions) == 0:
            self.ship_positions.append((x, y))
            update_ui_callback(x, y, 'green')
        elif len(self.ship_positions) < 3:
            if self.valid_ship_position(x, y):
                self.ship_positions.append((x, y))
                update_ui_callback(x, y, 'green')
            else:
                messagebox.showwarning("Invalid Placement", "Ship must be placed in a straight line.")

        if len(self.ship_positions) == 3:
            for x, y in self.ship_positions:
                update_ui_callback(x, y, 'blue')
            messagebox.showinfo("Ship Placed", "Your ship has been placed! Start the game.")
            self.placing_ship = False

    def valid_ship_position(self, x, y):
        if (x, y) in self.ship_positions:
            return False

        first_x, first_y = self.ship_positions[0]

        if len(self.ship_positions) == 1:
            return (abs(x - first_x) == 1 and y == first_y) or (abs(y - first_y) == 1 and x == first_x)

        second_x, second_y = self.ship_positions[1]
        if first_x == second_x:
            return x == first_x and (abs(y - first_y) == 1 or abs(y - second_y) == 1)
        elif first_y == second_y:
            return y == first_y and (abs(x - first_x) == 1 or abs(x - second_x) == 1)

        return False   

    def attack_position(self, x, y, update_ui_callback):
        if (x, y) in self.ship_positions:
            update_ui_callback(x, y, 'red', disabled=True)
            self.ship_positions.remove((x, y))
            if not self.ship_positions:
                messagebox.showinfo("Congratulations!", "You sunk the ship!")
                return True
        else:
            update_ui_callback(x, y, 'white', disabled=True)
        return False

    def reset_game(self, reset_ui_callback):
        self.placing_ship = True
        self.ship_positions = []
        reset_ui_callback()
