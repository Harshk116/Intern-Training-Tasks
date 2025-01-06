#!/usr/bin/env python
# coding: utf-8

# In[2]:


import tkinter as tk
from tkinter import ttk, messagebox
from ttkbootstrap import Style

def play_move():
    pass
root = tk.Tk()
root.title("Tic-Tac-Toe")
style = Style(theme="flatly")
buttons = []
for i in range(3):
    row = []
    for j in range(3):
        button = tk.Button(root, text='', width=5,
                            command=lambda i=i, j=j: play_move(i,j))
        button.grid(row=i, column=j, padx=5, pady=5)
        row.append(button)
    buttons.append(row)
game = [['', '', ''] for _ in range(3)]
current_player = "X"

root.mainloop()

