import tkinter as tk
from PIL import Image, ImageTk
import os
import sys

def get_resource_path(relative_path):
    """Get the absolute path to the resource (image) bundled with the executable."""
    if hasattr(sys, "_MEIPASS"):
        # Running as a PyInstaller bundle
        return os.path.join(sys._MEIPASS, relative_path)
    return os.path.join(os.path.abspath("."), relative_path)

def create_app():
    # Initialize the main window
    root = tk.Tk()
    root.title("Fun Fact Application")
    root.geometry("600x400")  # Set the size of the window
    root.configure(bg="white")  # Set background color

    # Create a frame to hold the content
    frame = tk.Frame(root, bg="white")
    frame.pack(fill="both", expand=True, padx=20, pady=20)

    # Add a label for the fun fact text
    text_label = tk.Label(
        frame,
        text="Fun Fact: I submitted this image with my college application to Rice",
        font=("Arial", 14, "bold"),
        bg="white",
        wraplength=500,  # Limit the width of the text
        justify="center",
    )
    text_label.pack(pady=10)

    # Load and display the image using Pillow
    try:
        image_path = get_resource_path("assets/me.png")
        image = Image.open(image_path)  # Correct path to your image
        image = image.resize((300, 300))  # Resize the image if necessary        
        photo = ImageTk.PhotoImage(image)
        image_label = tk.Label(frame, image=photo, bg="white")
        image_label.image = photo  # Keep a reference to the image
        image_label.pack(pady=20)
    except Exception as e:
        error_label = tk.Label(
            frame,
            text=f"Error loading image: {e}",
            font=("Arial", 12),
            fg="red",
            bg="white",
        )
        error_label.pack(pady=20)

    # Run the Tkinter event loop
    root.mainloop()

if __name__ == "__main__":
    create_app()