## 章节和关卡数据。
class_name LevelData


## 各关卡的关卡数据。
## [br][br]
## [code]LEVEL_DATA[chapter_id][level_id] : Dictionary[/code] 返回第 [param chapter_id] 章节的第 [param level_id] 关卡的关卡数据，以下记为 [code]data[/code]。其中：
## [br][br]
## [code]data["question"][/code] 为关卡表达式，用 [code][][/code] 表示无要求的空槽，用 [code]{}[/code] 表示要求为笑脸的空槽。
## [br][br]
## [code]data["choices"][/code] 为关卡选项。
## [br][br]
## [code]data["level_code"][/code] 为关卡唯一标识符，只需唯一即可，无其他约束。用于保证游戏更新时存档能正确更新。
const LEVEL_DATA := [
	[
		{
			"question": "P [] []",
			"choices": "= P",
			"level_code": 0,
		},
  		{
			"question": "P {} {}",
			"choices": "= P P",
			"level_code": 1,
		},
  		{
			"question": "{} [] []",
			"choices": "D D R R = d d",
			"level_code": 2,
		},
  		{
			"question": "[] {} {}",
			"choices": "d d = R R b b",
			"level_code": 3,
		},
  		{
			"question": "[] = {} = {} = [] = {} = {}",
			"choices": "dddddd QQQQQQ RRRRRR DDDDDD PPPPPP qqqqqq",
			"level_code": 4,
		}
	],
	
	[
		{
			"question": "[] [] {} {} d",
			"choices": "= + 0 d",
			"level_code": 5,
		},
		{
			"question": "[] [] {} {} 1",
			"choices": "= + 1 d",
			"level_code": 6,
		},
		{
			"question": "Q + [] = {} + []",
			"choices": "P P P P Q Q Q Q",
			"level_code": 7,
		},
		{
			"question": "1 [] {} = {} [] []",
			"choices": "1++PPdd",
			"level_code": 8,
		},
		{
			"question": "1 [] [] [] {} [] [] [] {} [] {} [] []",
			"choices": "== ++++++ 11 P q b R",
			"level_code": 9,
		},
		{
			"question": "1 {} {} = []",
			"choices": "XDD",
			"level_code": 10,
		},
		{
			"question": "0 [] [] {} []",
			"choices": "XP=0",
			"level_code": 11,
		},
		{
			"question": "[] {} {} {} {} []",
			"choices": "QQQQQQ DDXX=",
			"level_code": 12,
		},
		{
			"question": "[] + [] [] [] [] {} = {} [] [] [] [] [] []",
			"choices": "0 0 1 d d q P P b R R Q +",
			"level_code": 13,
		},
		{
			"question": "{} {} {}   {} {} {}   {} {} {} {}   {} {} {}   {} {} {}",
			"choices": "PP DD bb   qq dd   XXXXX =",
			"level_code": 14,
		},
	],

	[
		{
			"question": "[] [] + [] = ( [] {} {} ) [] []",
			"choices": "PP QQ RR X +",
			"level_code": 15,
		},
		{
			"question": "[] + [] [] = [] [] ( [] {} {} )",
			"choices": "PP QQ RR X +",
			"level_code": 16,
		},
		{
			"question": "P ([] [] []) = {} [] [] [] []",
			"choices": "PP QQ RR ++",
			"level_code": 17,
		},
	],

	[
		{
			"question": "[] + [] {} {}",
			"choices": "P P P 1 X",
			"level_code": 18,
		},
		{
			"question": "[] [] {} = {} [] {} = []",
			"choices": "PP qq ++ 1",
			"level_code": 19,
		},
		{
			"question": "[] [] {} {} [] + [] [] {} {} []",
			"choices": "(())==01PP",
			"level_code": 20,
		},

		{
			"question": "[] [] {} {} [] [] [] []",
			"choices": "=PPQQ+()",
			"level_code": 21,
		}
	],

	[
		{
			"question": "0 {} {} [] 1",
			"choices": "XD<",
			"level_code": 22,
		},
		{
			"question": "[] X [] {} {} [] + []",
			"choices": "QQPP<=",
			"level_code": 23,
		},
		{
			"question": "0 {} P [] [] []",
			"choices": "<>=P",
			"level_code": 24,
		}
	],

	# Matrix
	[
		{
			"question": "M {} {} [] [] []",
			"choices": "MMMM MMMM   1 0 + < =",
			"level_code": 29,
		}
	],

	# Extra
	[
		{
			"question": "[] {} {}   [] [] []   [] {} {}   {} {} {}  [] [] []  [] [] []",
			"choices": "0 X D + P + P d = P X P + 0 d + P d",
			"level_code": 25,
		},
		{
			"question": "[] [] [] [] [] {} {} [] [] [] [] {} {} + [] []",
			"choices": "PPP QQ DD (()) ++ = X",
			"level_code": 26,
		},
		{
			"question": "P < [][][][] [] d {} {} {}",
			"choices": "PP qq << = +",
			"level_code": 27,
		},
		{
			"question": "[][][]{}{}  {}[]P=(    {}{}{}[][]   )",
			"choices": "PP qq DD < >>> ==",
			"level_code": 28,
		},
	],
]

## 章节的唯一标识符。
const CHAPTER_CODE := [0, 1, 2, 3, 4, 5, 6]

## 章节解锁所需要前一个章节通关的关卡数量。
const CHAPTER_UNLOCK_REQUIRE := [-1, 1, 1, 1, 1, 1, 1] 
# [][][][] {}{}{} []

# pp   qqq   <>=


## 获取第 [param chapter_id] 章节的关卡数量。
static func get_chapter_level_count(chapter_id: int) -> int:
	return len(LEVEL_DATA[chapter_id])


## 获取章节数量。
static func get_chapter_count() -> int:
	return len(LEVEL_DATA)

## 获取第 [param chapter_id] 章节的第 [param level_id] 关卡的关卡标识符。
static func get_level_code(chapter_id: int, level_id: int) -> int:
	return LEVEL_DATA[chapter_id][level_id]["level_code"]

## 获取第 [param chapter_id] 章节的章节标识符。
static func get_chapter_code(chapter_id: int) -> int:
	return CHAPTER_CODE[chapter_id]

## 获取第 [param chapter_id] 章节的解锁要求关卡数。
static func get_chapter_unlock_require(chapter_id: int) -> int:
	return CHAPTER_UNLOCK_REQUIRE[chapter_id]

## 获取第 [param chapter_id] 章节是否解锁。
static func is_chapter_unlocked(chapter_id: int) -> bool:
	if chapter_id == 0:
		return true
	else:
		var require := get_chapter_unlock_require(chapter_id)
		var count := 0
		for i in range(get_chapter_level_count(chapter_id - 1)):
			if SaveLib.is_level_cleared(chapter_id - 1, i):
				count += 1
		return count >= require