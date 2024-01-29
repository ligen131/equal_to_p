![:3](=P3.png "Magic Cat")

# Equal to P (=P)

**Try our online demo at <https://ligen131.github.io/equal_to_p/> now!**

A game made by Team 玩一个四字音游导致的 during [Global Game Jam](https://globalgamejam.org/) 2024. Participated [onsite](https://www.huodongxing.com/event/2732777803400?td=6303464850639) at [ChillyRoom](https://www.chillyroom.com/), Shenzhen, China.

- Coding: [@cutekibry](https://github.com/cutekibry), [@ligen131](https://github.com/ligen131), [@Bunnycxk](https://github.com/Bunnycxk)
- Art: [@IsaacTheMouse](https://github.com/IsaacTheMouse), [@Bunnycxk](https://github.com/Bunnycxk)
- Music: [@cutekibry](https://github.com/cutekibry)
- Planning: everyone

## Introduction

A puzzle game inspired by {Boolean expressions} =P 

Players solve the game by filling in different elements in the arithmetic expression, making the expression always true while also creating a smiley face emoticon with a part of the equation. ;-)

由{布尔运算式}启发的解谜游戏 =P 玩家通过在算数式中填入不同的元素 ;-) 让表达式恒为真的同时 :-> 式子中的某个部分能够构成一个笑脸的颜文字。

## Try Demo

The latest built artifacts can be found at [the latest actions](https://github.com/ligen131/ggj2024-game/actions).

Windows: [Download](https://github.com/ligen131/equal_to_p/actions/runs/7684305585/artifacts/1200398972)

Linux: [Download](https://github.com/ligen131/equal_to_p/actions/runs/7684305585/artifacts/1200398969)

MacOS: [Download](https://github.com/ligen131/equal_to_p/actions/runs/7684305585/artifacts/1200398970)

**You can also try our online demo at <https://ligen131.github.io/ggj2024-game/>.** Due to the rendering process requiring time to load, the webpage may take a while to load.

## TODO

- [x] 右键 card 返回 card_base
- [x] card_base：
  - 数字 ok
  - 灰色（剩下为 0 时变灰）toggle_color
  - card 回来吸附
- [x] 关卡跳转 UI
- [x] 关卡点击跳转
- [x] 录入数据
- [x] 算式框，备选框，关卡框纹理
- [x] card card_base 边框纹理
- [x] 音效
- [x] 关卡设计 `<` `>`- cxk
- [x] 背景颜色
- [x] 主页 MainMenu UI
- [x] 主页动画 - mouse
- [x] 主页跳转
- [x] 主页开始按钮动画
- [x] 通关后禁用鼠标操作 card
- [x] 选关页面返回按钮
- [x] 右上角重玩按钮
- [x] 通关之后高亮笑脸
- [x] 通关之后下一关底部浮现按钮
- [x] 金色框纹理统一
- [x] 关卡高亮动画 // 这是啥？
- [x] 章节标题
- [x] 卡片文字偏移
- [x] 瞎几把拖 card 有 bug
- [ ] 卡片被放置后继续动画会露馅
- [x] 主页笑脸乱飞动画
- [ ] 场景切换的过场动画
- [ ] 卡片替换交互逻辑

## Build

```shell
# Windows
$ godot --headless --verbose --export-release "Windows Desktop" equal_to_p.exe

# Linux
$ godot --headless --verbose --export-release "Linux/X11" equal_to_p.x86_64

# MacOS
$ godot --headless --verbose --export-release "mac" equal_to_p.zip

# Web
$ mkdir -v -p build/web
$ godot --headless --verbose --export-release "Web" build/web/index.html
$ cd build/web/
$ curl https://raw.githubusercontent.com/josephrocca/clip-image-sorter/92b108dc670d0b56bd6b72963b0e86c4c862412e/enable-threads.js --output enable-threads.js
$ sed -i 's|headers.set("Cross-Origin-Embedder-Policy", "credentialless")|headers.set("Cross-Origin-Embedder-Policy", "require-corp")|g'  enable-threads.js
$ sed -i 's|<script src="index.js"></script>|<script src="enable-threads.js"></script><script src="index.js"></script>|g' index.html
```

## Engine

[Godot 4.2](https://github.com/godotengine/godot)

## LICENSE

GNU General Public License v3.0
