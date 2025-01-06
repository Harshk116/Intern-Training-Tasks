{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "4fbc7b96-a5b2-432b-b7c3-b769c1ab6af2",
   "metadata": {},
   "outputs": [],
   "source": [
    "import tkinter as tk\n",
    "from tkinter import ttk, messagebox\n",
    "from ttkbootstrap import Style\n",
    "\n",
    "def play_move(row, col):\n",
    "    global current_player\n",
    "\n",
    "    if game[row][col] == '':\n",
    "        game[row][col] = current_player\n",
    "        buttons[row][col].configure(text=current_player)\n",
    "        check_winner()\n",
    "        current_player = \"O\" if current_player == \"X\" else \"X\"\n",
    "\n",
    "def check_winner():\n",
    "    # Check rows, columns and diagonals\n",
    "    winning_combinations = (game[0], game[1], game[2],\n",
    "                            [game[i][0] for i in range(3)],\n",
    "                            [game[i][1] for i in range(3)],\n",
    "                            [game[i][2] for i in range(3)],\n",
    "                            [game[i][i] for i in range(3)],\n",
    "                            [game[i][2 - i] for i in range(3)])\n",
    "    \n",
    "    for combination in winning_combinations:\n",
    "        if combination[0] == combination[1] == combination[2] != '':\n",
    "            declare_winner(combination[0])\n",
    "    \n",
    "    if all(game[i][j] != '' for i in range(3) for j in range(3)):\n",
    "        declare_winner(\"Draw\")\n",
    "\n",
    "def declare_winner(player):\n",
    "    if player == \"Draw\":\n",
    "        message = \"It's a draw!\"\n",
    "    else:\n",
    "        message = f\"Congrats Player {player} wins!\"\n",
    "    messagebox.showinfo(\"Game Over\", message)\n",
    "    restart_game()\n",
    "\n",
    "def restart_game():\n",
    "    global game, current_player\n",
    "    game = [['', '', ''] for _ in range(3)]\n",
    "    current_player = \"X\"\n",
    "    for row in buttons:\n",
    "        for button in row:\n",
    "            button.configure(text='')\n",
    "\n",
    "# Creating the main GUI\n",
    "root = tk.Tk()\n",
    "root.title(\"Tic-Tac-Toe\")\n",
    "style = Style(theme=\"flatly\")\n",
    "root.geometry(\"265x320\")\n",
    "\n",
    "# buttons for tic tac toe\n",
    "\n",
    "buttons = []\n",
    "for i in range(3):\n",
    "    row = []\n",
    "    for j in range(3):\n",
    "        button = tk.Button(root, text='', width=10,height = 6,\n",
    "                            command=lambda i=i, j=j: play_move(i,j))\n",
    "        button.grid(row=i, column=j, padx=5, pady=5)\n",
    "        row.append(button)\n",
    "    buttons.append(row)\n",
    "\n",
    "# Initializing the grid and player\n",
    "game = [['', '', ''] for _ in range(3)]\n",
    "current_player = \"X\"\n",
    "\n",
    "root.mainloop()"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "4c2ea02f-1e7b-46bd-9434-3bc212684b71",
   "metadata": {},
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3 (ipykernel)",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "codemirror_mode": {
    "name": "ipython",
    "version": 3
   },
   "file_extension": ".py",
   "mimetype": "text/x-python",
   "name": "python",
   "nbconvert_exporter": "python",
   "pygments_lexer": "ipython3",
   "version": "3.12.4"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
