import tkinter as tk

class BattleshipUI:
    def __init__(self, root, game):
        self.root = root
        self.game = game
        self.board_size = 6
        self.root.title("Place Your Ship - Battleship Game")
        self.root.geometry("350x350")

        self.label = tk.Label(self.root, text="Place a 3-cell ship", font=("Arial", 12))
        self.label.grid(row=self.board_size, column=0, columnspan=self.board_size)
        self.create_battlefield()

    def create_battlefield(self):
        self.buttons = [[tk.Button(self.root, width=4, height=2, bg='blue',
                                   command=lambda x=i, y=j: self.select_cell(x, y))
                         for j in range(self.board_size)]
                        for i in range(self.board_size)]

        for i in range(self.board_size):
            for j in range(self.board_size):
                self.buttons[i][j].grid(row=i, column=j, sticky="nsew")

        for i in range(self.board_size):
            self.root.grid_rowconfigure(i, weight=1)
            self.root.grid_columnconfigure(i, weight=1)

    def select_cell(self, x, y):
        if self.game.placing_ship:
            self.game.place_ship(x, y, self.update_ui)
        else:
            game_over = self.game.attack_position(x, y, self.update_ui)
            if game_over:
                self.reset_game()

    def update_ui(self, x, y, color, disabled=False):
        self.buttons[x][y].config(bg=color)
        if disabled:
            self.buttons[x][y].config(state=tk.DISABLED)

    def reset_game(self):
        self.game.reset_game(self.clear_board)
        self.label.config(text="Place a 3-cell ship")
        self.root.title("Place Your Ship - Battleship Game")

    def clear_board(self):
        for i in range(self.board_size):
            for j in range(self.board_size):
                self.buttons[i][j].config(bg='blue', state=tk.NORMAL)
