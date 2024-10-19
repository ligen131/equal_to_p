# Changelog

## [1.5.0](https://github.com/ligen131/equal_to_p/compare/v1.4.0...v1.5.0) (2024-10-19)


### Features

* **addons:** 添加 AespriteWizard ([c891353](https://github.com/ligen131/equal_to_p/commit/c89135375a4aba789e3fc192021645ec9bdb6f4f))
* **expr_validator:** 修改相邻比较符号合法性判断 ([7ad61f1](https://github.com/ligen131/equal_to_p/commit/7ad61f1b3d1c96a99100744b5a09257cfe546c30))
* **font:** 将字体改为 Fusion Pixel 10px ([d3ed6d2](https://github.com/ligen131/equal_to_p/commit/d3ed6d23620ace84a10a5794795ca34eda8046e4))
* **i18n:** 新增本地化 ([0456f25](https://github.com/ligen131/equal_to_p/commit/0456f25aad78e59f276b8fcf93293f9568c6998d))
* **sound_manager:** 添加 Sound Manager 类 ([fd27fa5](https://github.com/ligen131/equal_to_p/commit/fd27fa515b166394e095debf206c98b2128c67b9))
* 更改分辨率和字体 ([97c200c](https://github.com/ligen131/equal_to_p/commit/97c200c77fb98dc59f9034f3eab1ff7987c895ae))
* 添加 'M ([#89](https://github.com/ligen131/equal_to_p/issues/89)) ([9bcb3af](https://github.com/ligen131/equal_to_p/commit/9bcb3afa192e92a7e9c97b494545de0a6a49b801))
* 添加动态改变颜色的功能  ([#84](https://github.com/ligen131/equal_to_p/issues/84)) ([beceb8e](https://github.com/ligen131/equal_to_p/commit/beceb8e588105e90aa69ac92323707352544519d))
* 添加存档系统和关卡解锁系统 ([#88](https://github.com/ligen131/equal_to_p/issues/88)) ([b1f863d](https://github.com/ligen131/equal_to_p/commit/b1f863dbfb457957afdee7080469b43376f27b60))


### Bug Fixes

* 修复下一章节按钮逻辑问题 ([b1f863d](https://github.com/ligen131/equal_to_p/commit/b1f863dbfb457957afdee7080469b43376f27b60))

## [1.4.0](https://github.com/ligen131/equal_to_p/compare/v1.3.0...v1.4.0) (2024-02-28)


### Features

* **image_lib.gd:** 添加新主题 ([7891fef](https://github.com/ligen131/equal_to_p/commit/7891feface1b2e5695baf79f6d3f36793055c47c))
* **level_data:** 添加新关卡和设计说明 ([e77d2ee](https://github.com/ligen131/equal_to_p/commit/e77d2ee4256be8419973a03d8983562c942d5323))


### Bug Fixes

* **base_level.gd:** 修复无法前往下一关的问题 ([e4cdf63](https://github.com/ligen131/equal_to_p/commit/e4cdf6394778b7d8bd97697d7ac73b9c01def9a7))
* **dynamic_bg.gd:** 修复初始配色不为 blue 的问题 ([ce83c1e](https://github.com/ligen131/equal_to_p/commit/ce83c1e692486a0ca868125a8b138e2eb2994e38))
* 修复卡牌交换时位置可能重合的 bug ([732f587](https://github.com/ligen131/equal_to_p/commit/732f587b3a2552c847afb782e65fca425d838096))

## [1.3.0](https://github.com/ligen131/equal_to_p/compare/v1.2.0...v1.3.0) (2024-02-19)


### ⚠ BREAKING CHANGES

* **chapter_menu:** 删除章节菜单
* **level_menu:** LevelMenu 的场景结构发生变化。
* **level_button:** 修改了 LevelButton 的大小，删除设置罗马数字功能。

### Features

* **level_button:** 修改按钮大小并添加两位数显示 ([1d741ea](https://github.com/ligen131/equal_to_p/commit/1d741ea9c6cc9ff63cb3938f8978978924ad7f36))
* **level_menu:** 修改场景结构，添加选择章节功能 ([b026348](https://github.com/ligen131/equal_to_p/commit/b02634880b0e317e531001b48ff6159c77fc3ee4))
* **scroll_area, base_level:** 添加 scroll_area ([718306c](https://github.com/ligen131/equal_to_p/commit/718306c8a0cac0eae7b03631781e55b4a43b489d))
* **smooth_movement:** 添加 smooth_movement 类 ([277dd06](https://github.com/ligen131/equal_to_p/commit/277dd0692f7c493dce3aec12eb3c94737219743c))


### Bug Fixes

* **base_level.gd:** 废除罗马数字；修正元素位置 ([9d42479](https://github.com/ligen131/equal_to_p/commit/9d4247918d2e478789adde326d92e63320f05f6a))
* **expr_validator.gd:** 修复乘法相邻规则 ([170d74c](https://github.com/ligen131/equal_to_p/commit/170d74c44a3d37f060e30b63e244159e3e985d77))
* **expr_validator.gd:** 修正错误时返回值不合法 ([8e0e901](https://github.com/ligen131/equal_to_p/commit/8e0e90156c3461922cc8bce854003dd302bc8e8b))
* **level_menu.gd:** 修复 CHAP_NAMES 和按钮初始化 ([3a1f52c](https://github.com/ligen131/equal_to_p/commit/3a1f52c336fb476ff7cd0e6b6a222297ee5a7da2))
* **main_menu.gd:** 删除未使用的 ChapterMenu ([18dddba](https://github.com/ligen131/equal_to_p/commit/18dddbadb0aea58499237de3de44996dbcfb3643))
* **next_level_button.tscn:** 修复箭头字符位置 ([672b1fc](https://github.com/ligen131/equal_to_p/commit/672b1fc5711a259425442db702c502d02464a8ec))


### Miscellaneous Chores

* release 1.3.0 ([708f3f3](https://github.com/ligen131/equal_to_p/commit/708f3f3d6e6b1f9e148417eb3625369b8851c0cb))


### Code Refactoring

* **chapter_menu:** 删除章节菜单 ([41de333](https://github.com/ligen131/equal_to_p/commit/41de333be68a85f96829678cdb22d0cc906a3e8b))

## [1.2.0](https://github.com/ligen131/equal_to_p/compare/v1.1.0...v1.2.0) (2024-02-16)


### ⚠ BREAKING CHANGES

* **main:** $Bg 节点删除，原 $Bg/DynamicBg 节点移至 $DynamicBg。
* **dynamic_bg:** DynamicBg 现改为 ColorRect 类型。
* **image_lib.gd:** 原 PALETTE 废用，update_animation 函数更改。

### Features

* **dynamic_bg:** 添加背景色和更改配色功能 ([7951dd6](https://github.com/ligen131/equal_to_p/commit/7951dd601ce0d19c2cc5f0e513dfd1c3d49dd0c8))
* **golden_cloth.png:** 去除棕黄色内框 ([af326e3](https://github.com/ligen131/equal_to_p/commit/af326e382d83762bcb3e1a91fde00f90c244d3f8))
* **image_lib.gd:** 添加主题、配色版和相关函数 ([c1575a9](https://github.com/ligen131/equal_to_p/commit/c1575a9a8b9b85e0f728d4bdcb32f811242d9118))
* **styled_button:** 添加 disabled 和更改颜色功能 ([ecfddb6](https://github.com/ligen131/equal_to_p/commit/ecfddb64263078d1a49e6a86fe1dbd1662b47c8f))
* 添加根据主题更改配色功能 ([7a1fc70](https://github.com/ligen131/equal_to_p/commit/7a1fc70d2dbebb2d6bf32a393072d7ee279965ac))


### Bug Fixes

* **card_base.tscn:** 修复 Sprite 路径错误问题 ([7fd6d3e](https://github.com/ligen131/equal_to_p/commit/7fd6d3efb64afc41306073ba68fe0f8bcf114d54))


### Miscellaneous Chores

* release 1.2.0 ([1a5589e](https://github.com/ligen131/equal_to_p/commit/1a5589e2a5deb3f2bc42b673d5081fa91f661c70))


### Code Refactoring

* **main:** 将 $Bg/DynamicBg 移到根节点下 ([ed1327a](https://github.com/ligen131/equal_to_p/commit/ed1327a03556b81ad57d9d813a23e2112c0b360a))

## [1.1.0](https://github.com/ligen131/equal_to_p/compare/v1.0.0...v1.1.0) (2024-02-15)


### ⚠ BREAKING CHANGES

* **card.gd:** get_top_prior_entered_block() 会选择占有 Card 的 Block。

### Features

* **card_base.gd:** 添加 get_card_count() 函数 ([0e441f9](https://github.com/ligen131/equal_to_p/commit/0e441f9629c038f8bc7f6edf71a4f7803cab2ef8))
* **card.gd:** 添加交换两个卡槽 Card 的功能 ([c1a40fc](https://github.com/ligen131/equal_to_p/commit/c1a40fcaa15331053542602c546f575883daff34))
* **cursor_manager:** 添加鼠标指针动画管理 ([0e86a48](https://github.com/ligen131/equal_to_p/commit/0e86a48cecb3032c43c7c71787532cb3895591dd))
* **main.tscn:** 添加 CursorManager ([b7ba5d5](https://github.com/ligen131/equal_to_p/commit/b7ba5d5deabccac93a2aa7a16ef0c95f7e7ef482))


### Bug Fixes

* **card_base.gd:** 删除鼠标指针处理 ([27598eb](https://github.com/ligen131/equal_to_p/commit/27598eb6eeffcbbd59d408cb7a0ca3d96c591ee8))
* **card.gd:** 修复交换导致的通关可能引起震动的 bug ([1b20ad9](https://github.com/ligen131/equal_to_p/commit/1b20ad90054782f33b70309b1d29293412aefd05))
* **card.gd:** 删除鼠标指针处理 ([6cfe64f](https://github.com/ligen131/equal_to_p/commit/6cfe64f9010a46701b0c7411468abc87586655ab))
* **main.gd:** 删除空 _ready() 函数导致的错误 ([d25a015](https://github.com/ligen131/equal_to_p/commit/d25a015aa5b9f0ed9b1d4d63de9086dacd8aa771))
* **main.gd:** 删除鼠标指针处理 ([7faa392](https://github.com/ligen131/equal_to_p/commit/7faa392eacdb94881f7c719310d7dfb69d64d574))


### Miscellaneous Chores

* release 1.1.0 ([616c740](https://github.com/ligen131/equal_to_p/commit/616c7404cd4387874169f08f94709b8d876ad705))

## 1.0.0 (2024-02-14)


### ⚠ BREAKING CHANGES

* **block.gd:** void set_block_type(value: String) 被移除。
* **card_base:** 重构 Card Base 代码。
* **block:** 对 Block 进行若干重构
* **card:** 对 Card 重大重构
* **word.gd:** Word 的第一个字符从下划线 "_" 改为空格 " "。

### Features

* **base_level.gd:** 更新关卡 ([e846aee](https://github.com/ligen131/equal_to_p/commit/e846aeec74ddc72164014cd342bfe30556623a35))
* **block, card:** 添加震动、改变边框颜色、改变文字颜色的功能 ([7be6967](https://github.com/ligen131/equal_to_p/commit/7be69670e17ffae332a8d7ea0f529d16ddc5b553))
* **block.gd:** 添加 is_golden_frame 属性和方法 ([0036966](https://github.com/ligen131/equal_to_p/commit/0036966a1ee6d4cdf0e0686281491c3db5230172))
* **card_base.gd:** 添加改变卡背颜色功能 ([f049ab1](https://github.com/ligen131/equal_to_p/commit/f049ab1df2b20b96bc81028cb9cbf37895247c1c))
* **card:** 添加自动修改卡背颜色的功能 ([b95ca39](https://github.com/ligen131/equal_to_p/commit/b95ca390f3de614acaaefa2e9150193f50d63fe5))
* **expr_validator.gd:** 添加 VAR 和 CONST ([d6581cc](https://github.com/ligen131/equal_to_p/commit/d6581cc659c8190d606f242bd40db899481d41f3))
* **goal_frame:** 添加红框素材，重命名 goal_frame2.png 到 goal_frame.png ([104b475](https://github.com/ligen131/equal_to_p/commit/104b4751a9adcc72d872714a459493f499081bc9))
* **image_lib.gd:** 新配色及 update_animation 功能 ([826cd41](https://github.com/ligen131/equal_to_p/commit/826cd41f307361a0666ce55d5c320e1c4a6904f7))
* **word.gd:** 对 Word 进行重要修改 ([1e41c38](https://github.com/ligen131/equal_to_p/commit/1e41c380aa38e5057f8a99d85334527c5920733a))
* **word.gd:** 添加 class_name ([a107e96](https://github.com/ligen131/equal_to_p/commit/a107e96b886b42fd4903608113d27d6c75e383cf))
* 使指针在 card 和 card_base 上会发生改变 ([edad156](https://github.com/ligen131/equal_to_p/commit/edad1563636067669224bbea51b4a055c30a1d44))


### Bug Fixes

* **base_level.gd:** 将 preload 改为 load ([2015ae9](https://github.com/ligen131/equal_to_p/commit/2015ae9a3f8caa29090f62aba974c078a7c97258))
* **base_level.gd:** 适配 block.gd 新接口 ([2a08458](https://github.com/ligen131/equal_to_p/commit/2a084580f7ecc4831b752ae180d71a7bef98b43b))
* **card.gd:** 修正震动时高亮边框不动的 bug ([c7c8470](https://github.com/ligen131/equal_to_p/commit/c7c84707febc8c0dd868e20752ed472dad217667))
* **card.gd:** 删去未使用的 cardback_color 变量 ([41fde44](https://github.com/ligen131/equal_to_p/commit/41fde44eef1c05691f18da1c15576e5917ff1a83))
* **card.png:** 修复 Card 素材与 Block 间隙不匹配的问题 ([a0b4f04](https://github.com/ligen131/equal_to_p/commit/a0b4f04ac381f09e6be6018ba0aa33bef64420c9))


### Code Refactoring

* **block:** 对 Block 进行若干重构 ([3f750e8](https://github.com/ligen131/equal_to_p/commit/3f750e8c9728a8e6f32837db6199f674ce44f925))
* **card_base:** 重构 Card Base 代码。 ([6b9f1ee](https://github.com/ligen131/equal_to_p/commit/6b9f1ee1860e37f86d0eab8be898ec9d9b63ad04))
* **card:** 对 Card 重大重构 ([b0ace12](https://github.com/ligen131/equal_to_p/commit/b0ace12c02936680d6984e93edf698ecebbcae9a))
* **word.gd:** 更改 Word 的默认字符为空格 ([30adff0](https://github.com/ligen131/equal_to_p/commit/30adff0245109a81d7836a1a64bc84e92eb2b70c))
