class TicTacToeGame:
    def __init__(self):
        self.board = [['' for _ in range(3)] for _ in range(3)]
        self.current_player = "X"

    def make_move(self, row, col):
        if self.board[row][col] == '':
            self.board[row][col] = self.current_player
            return True
        return False

    def check_result(self):
        lines = (
            self.board[0], self.board[1], self.board[2],
            [self.board[i][0] for i in range(3)],
            [self.board[i][1] for i in range(3)],
            [self.board[i][2] for i in range(3)],
            [self.board[i][i] for i in range(3)],
            [self.board[i][2 - i] for i in range(3)]
        )

        for line in lines:
            if line[0] == line[1] == line[2] != '':
                return line[0]

        if all(self.board[i][j] != '' for i in range(3) for j in range(3)):
            return "Draw"

        return None

    def reset_game(self):
        self.board = [['' for _ in range(3)] for _ in range(3)]
        self.current_player = "X"
