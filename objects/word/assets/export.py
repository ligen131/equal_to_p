from PIL import Image

step = 16

# row = 6
# col = 6

# num = 30
# for frame in range(3):
#     img = Image.new('RGBA', (col * step, row * step), (0, 0, 0, 0))
#     for i in range(num):
#         x = i % col
#         y = i // col
#         img.paste(Image.open(f'sprite{i + 1 + frame * num}.png'), (x * step, y * step))
#     img.save(f'frame{frame + 1}.png')

img = Image.open("word_sprite_sheet.png")
for i in range(img.size[0] // step):
    img.crop((i * step, 0, (i + 1) * step, step)).save(f"exports/sprite{i + 1}.png")