import os
import sys
import math
import time

def clear_screen():
    """Clears the terminal screen."""
    os.system('cls' if os.name == 'nt' else 'clear')

def rotate(point, angle_x, angle_y, angle_z):
    """Rotates a point in 3D space around the X, Y, and Z axes."""
    x, y, z = point

    # Rotation around X-axis
    cos_x = math.cos(angle_x)
    sin_x = math.sin(angle_x)
    y, z = y * cos_x - z * sin_x, y * sin_x + z * cos_x

    # Rotation around Y-axis
    cos_y = math.cos(angle_y)
    sin_y = math.sin(angle_y)
    x, z = x * cos_y + z * sin_y, -x * sin_y + z * cos_y

    # Rotation around Z-axis
    cos_z = math.cos(angle_z)
    sin_z = math.sin(angle_z)
    x, y = x * cos_z - y * sin_z, x * sin_z + y * cos_z

    return x, y, z

def project(point, width, height, fov, viewer_distance):
    """Projects a 3D point onto a 2D plane."""
    x, y, z = point
    factor = fov / (viewer_distance + z)
    x = int(x * factor + width / 2)
    y = int(-y * factor + height / 2)
    return x, y

def main():
    # Scaling factor to make the cube smaller
    scale = 0.1  # Adjusted scale to make the cube a bit smaller

    # Define the cube's vertices and scale them down
    vertices = [
        (-1 * scale, -1 * scale, -1 * scale),
        (1 * scale, -1 * scale, -1 * scale),
        (1 * scale, 1 * scale, -1 * scale),
        (-1 * scale, 1 * scale, -1 * scale),
        (-1 * scale, -1 * scale, 1 * scale),
        (1 * scale, -1 * scale, 1 * scale),
        (1 * scale, 1 * scale, 1 * scale),
        (-1 * scale, 1 * scale, 1 * scale)
    ]

    # Define the edges that connect the vertices
    edges = [
        (0, 1), (1, 2), (2, 3), (3, 0),  # Back face
        (4, 5), (5, 6), (6, 7), (7, 4),  # Front face
        (0, 4), (1, 5), (2, 6), (3, 7)   # Connecting edges
    ]

    angle_x = angle_y = angle_z = 0

    width = 80   # Width of the terminal
    height = 24  # Height of the terminal
    fov = 256    # Field of view
    viewer_distance = 4

    try:
        while True:
            # Create a buffer to store the screen contents
            screen = [[' ' for _ in range(width)] for _ in range(height)]

            # List to hold projected points
            projected_points = []

            # Rotate and project each vertex
            for vertex in vertices:
                rotated = rotate(vertex, angle_x, angle_y, angle_z)
                projected = project(rotated, width, height, fov, viewer_distance)
                projected_points.append(projected)

            # Draw the edges
            for edge in edges:
                start, end = edge
                x1, y1 = projected_points[start]
                x2, y2 = projected_points[end]

                # Draw lines between the points
                dx = x2 - x1
                dy = y2 - y1
                steps = max(abs(dx), abs(dy))
                if steps == 0:
                    continue
                x_increment = dx / steps
                y_increment = dy / steps
                x = x1
                y = y1
                for _ in range(int(steps)):
                    if 0 <= int(x) < width and 0 <= int(y) < height:
                        screen[int(y)][int(x)] = '#'
                    x += x_increment
                    y += y_increment

            # Clear the screen before printing the new frame
            clear_screen()

            # Print the screen
            for row in screen:
                print(''.join(row))

            # Update the angles for rotation
            angle_x += 0.03
            angle_y += 0.05
            angle_z += 0.02

            time.sleep(0.05)
    except KeyboardInterrupt:
        clear_screen()
        sys.exit()

if __name__ == '__main__':
    main()
