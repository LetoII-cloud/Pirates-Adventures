import os
from PIL import Image

# Get all PNG files in current folder
paths = [f for f in os.listdir(".") if f.lower().endswith(".png")]

# Optional: sort files (important for correct frame order)
paths.sort()

# Load images
images = [Image.open(p).convert("RGBA") for p in paths]

# Find max size
max_w = max(img.width for img in images)
max_h = max(img.height for img in images)

# Normalize sizes (center each image)
normalized = []
for img in images:
    new_img = Image.new("RGBA", (max_w, max_h), (0, 0, 0, 0))
    offset = ((max_w - img.width) // 2, (max_h - img.height) // 2)
    new_img.paste(img, offset)
    normalized.append(new_img)

# Create spritesheet (1 row)
sheet = Image.new("RGBA", (max_w * len(normalized), max_h))

for i, img in enumerate(normalized):
    sheet.paste(img, (i * max_w, 0))

sheet.save("spritesheet.png")

print(f"Done! {len(normalized)} images packed into spritesheet.png")