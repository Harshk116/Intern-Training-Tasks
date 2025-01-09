import pygame
import random

pygame.init()

BG_COLOR = (255, 255, 255)
GRAY = (128, 128, 128)
CELL_COLOR = (0, 255, 0)

WIDTH, HEIGHT = 600, 600
SIZE = 20
GRID_WIDTH = WIDTH // SIZE
GRID_HEIGHT = HEIGHT // SIZE
FPS = 60

screen = pygame.display.set_mode((WIDTH, HEIGHT))

clock = pygame.time.Clock()

font = pygame.font.Font(None, 36)

def generaterandompattern(num):
    return set([(random.randrange(0, GRID_HEIGHT), random.randrange(0, GRID_WIDTH)) for _ in range(num)])

def draw_grid(positions):
    for position in positions:
        col, row = position
        top_left = (col * SIZE, row * SIZE)
        pygame.draw.rect(screen, CELL_COLOR, (*top_left, SIZE, SIZE))

    for row in range(GRID_HEIGHT):
        pygame.draw.line(screen,GRAY, (0, row * SIZE), (WIDTH, row * SIZE))

    for col in range(GRID_WIDTH):
        pygame.draw.line(screen, GRAY, (col * SIZE, 0), (col * SIZE, HEIGHT))

def updategeneration(positions):
    all_neighbors = set()
    new_positions = set()

    for position in positions:
        neighbors = get_neighbors(position)
        all_neighbors.update(neighbors)

        neighbors = list(filter(lambda x: x in positions, neighbors))

        if len(neighbors) in [2, 3]:
            new_positions.add(position)
    
    for position in all_neighbors:
        neighbors = get_neighbors(position)
        neighbors = list(filter(lambda x: x in positions, neighbors))

        if len(neighbors) == 3:
            new_positions.add(position)
    
    return new_positions

def get_neighbors(pos):
    x, y = pos
    neighbors = []
    for posx in [-1, 0, 1]:
        if x + posx < 0 or x + posx > GRID_WIDTH:
            continue
        for posy in [-1, 0, 1]:
            if y + posy < 0 or y + posy > GRID_HEIGHT:
                continue
            if posx == 0 and posy == 0:
                continue

            neighbors.append((x + posx, y + posy))
    
    return neighbors

def generation_count_label(screen, generation_count):
    text = font.render(f"Generations: {generation_count}", True, (0, 0, 0))
    screen.blit(text, (10, 10))

def main():
    running = True
    playing = False
    step = 0
    update_freq = 30
    generation_count = 0

    positions = set()
    while running:
        clock.tick(FPS)

        if playing:
            step += 1
        
        if step >= update_freq:
            step = 0
            positions = updategeneration(positions)
            generation_count += 1

        pygame.display.set_caption("Conway's Game of Life ON" if playing else "Conway's Game of Life Paused")

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
            
            if event.type == pygame.KEYDOWN:
                if event.key == pygame.K_SPACE:
                    playing = not playing
                
                if event.key == pygame.K_e:
                    positions = set()
                    playing = False
                    step = 0
                    generation_count = 0
                
                if event.key == pygame.K_r:
                    positions = generaterandompattern(random.randrange(2, 10) * GRID_WIDTH)
                    generation_count = 0
    
        screen.fill(BG_COLOR)
        draw_grid(positions)
        generation_count_label(screen, generation_count)
        pygame.display.update()


    pygame.quit()

if __name__ == "__main__":
    main()    