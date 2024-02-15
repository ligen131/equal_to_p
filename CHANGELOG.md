# Changelog

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
