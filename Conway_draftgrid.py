import pygame
import random

pygame.init()

BG_COLOR = (128, 128, 128)
BLACK = (0, 0, 0)
CELL_COLOR = (255, 19, 240)

WIDTH, HEIGHT = 600, 600
SIZE = 20
GRID_WIDTH = WIDTH // SIZE
GRID_HEIGHT = HEIGHT // SIZE
FPS = 60

screen = pygame.display.set_mode((WIDTH, HEIGHT))

clock = pygame.time.Clock()

def draw_grid(positions):
    for position in positions:
        col, row = position
        top_left = (col * SIZE, row * SIZE)
        pygame.draw.rect(screen, CELL_COLOR, (*top_left, SIZE, SIZE))

    for row in range(GRID_HEIGHT):
        pygame.draw.line(screen,BLACK, (0, row * SIZE), (WIDTH, row * SIZE))

    for col in range(GRID_WIDTH):
        pygame.draw.line(screen, BLACK, (col * SIZE, 0), (col * SIZE, HEIGHT))

def main():
    running = True

    positions = set()
    while running:
        clock.tick(FPS)

        pygame.display.set_caption("Conway's Game of Life")

        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                running = False
            
            if event.type == pygame.MOUSEBUTTONDOWN:
                x, y = pygame.mouse.get_pos()
                col = x // SIZE
                row = y // SIZE
                pos = (col, row)

                if pos in positions:
                    positions.remove(pos)
                else:
                    positions.add(pos)
            
        screen.fill(BG_COLOR)
        draw_grid(positions)
        pygame.display.update()


    pygame.quit()

if __name__ == "__main__":
    main()