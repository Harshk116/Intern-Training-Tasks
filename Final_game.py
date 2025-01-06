import tkinter as tk
from tkinter import ttk, messagebox
from ttkbootstrap import Style

def play_move(row, col):
    global current_player

    if game[row][col] == '':
        game[row][col] = current_player
        buttons[row][col].configure(text=current_player)
        check_winner()
        current_player = "O" if current_player == "X" else "X"

def check_winner():
    # Check rows, columns and diagonals
    winning_combinations = (game[0], game[1], game[2],
                            [game[i][0] for i in range(3)],
                            [game[i][1] for i in range(3)],
                            [game[i][2] for i in range(3)],
                            [game[i][i] for i in range(3)],
                            [game[i][2 - i] for i in range(3)])
    
    for combination in winning_combinations:
        if combination[0] == combination[1] == combination[2] != '':
            declare_winner(combination[0])
    
    if all(game[i][j] != '' for i in range(3) for j in range(3)):
        declare_winner("Draw")

def declare_winner(player):
    if player == "Draw":
        message = "It's a draw!"
    else:
        message = f"Congrats Player {player} wins!"
    messagebox.showinfo("Game Over", message)
    restart_game()

def restart_game():
    global game, current_player
    game = [['', '', ''] for _ in range(3)]
    current_player = "X"
    for row in buttons:
        for button in row:
            button.configure(text='')

# Creating the main GUI
root = tk.Tk()
root.title("Tic-Tac-Toe")
style = Style(theme="flatly")
root.geometry("265x320")

# buttons for tic tac toe

buttons = []
for i in range(3):
    row = []
    for j in range(3):
        button = tk.Button(root, text='', width=10,height = 6,
                            command=lambda i=i, j=j: play_move(i,j))
        button.grid(row=i, column=j, padx=5, pady=5)
        row.append(button)
    buttons.append(row)

# Initializing the grid and player
game = [['', '', ''] for _ in range(3)]
current_player = "X"

root.mainloop()
