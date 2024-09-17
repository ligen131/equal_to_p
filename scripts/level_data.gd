## 章节和关卡数据。
class_name LevelData


## 各关卡的关卡数据。
## [br][br]
## [code]LEVEL_DATA[chapter_id][level_id] : Dictionary[/code] 返回第 [param chapter_id] 章节的第 [param level_id] 关卡的关卡数据，以下记为 [code]data[/code]。其中：
## [br][br]
## [code]data["name-en"][/code] 为关卡英文名。
## [br][br]
## [code]data["question"][/code] 为关卡表达式，用 [code][][/code] 表示无要求的空槽，用 [code]{}[/code] 表示要求为笑脸的空槽。
## [br][br]
## [code]data["choices"][/code] 为关卡选项。
const LEVEL_DATA := [
	[
		{
			"question": "P [] []",
			"choices": "= P"
		},
  		{
			"question": "P {} {}",
			"choices": "= P P"
		},
		{
			"question": "[] = {}",
			"choices": "R R P D D"
		},
  		{
			"question": "{} [] []",
			"choices": "D D = d d"
		},
  		{
			"question": "[] {} {}",
			"choices": "d d = R R b b"
		},
  		{
			"question": "[] = {} = {} = [] = {} = {}",
			"choices": "dddddd QQQQQQ RRRRRR DDDDDD PPPPPP qqqqqq"
		}
	],
	
	[
		{
			"question": "[] [] {} {} d",
			"choices": "= + 0 d"
		},
		{
			"question": "[] [] {} {} 1",
			"choices": "= + 1 d"
		},
		{
			"question": "Q + [] = {} + []",
			"choices": "P P P P Q Q Q Q"
		},
		{
			"question": "1 [] {} = {} [] []",
			"choices": "1++PPdd"
		},
		{
			"question": "1 [] [] [] {} [] [] [] {} [] {} [] []",
			"choices": "== ++++++ 11 P q b R"
		},
		{
			"question": "1 {} {} = []",
			"choices": "XDD"
		},
		{
			"question": "0 [] [] {} []",
			"choices": "XP=0"
		},
		{
			"question": "[] {} {} {} {} []",
			"choices": "QQQQQQ DDXX="
		},
		{
			"question": "[] + [] [] [] [] {} = {} [] [] [] [] [] []",
			"choices": "0 0 1 d d q P P b R R Q +"
		},
		{
			"question": "{} {} {}   {} {} {}   {} {} {} {}   {} {} {}   {} {} {}",
			"choices": "PP DD bb   qq dd   XXXXX ="
		},
	],

	[
		{
			"question": "[] [] + [] = ( [] {} {} ) [] []",
			"choices": "PP QQ RR X +"
		},
		{
			"question": "[] + [] [] = [] [] ( [] {} {} )",
			"choices": "PP QQ RR X +"
		},
		{
			"question": "P ([] [] []) = {} [] [] [] []",
			"choices": "PP QQ RR ++"
		},
	],

	[
		{
			"question": "[] + [] {} {}",
			"choices": "P P P 1 X",
		},
		{
			"question": "[] [] {} = {} [] {} = []",
			"choices": "PP qq ++ 1"
		},
		{
			"question": "[] [] {} {} [] + [] [] {} {} []",
			"choices": "(())==01PP"
		},

		{
			"question": "[] [] {} {} [] [] [] []",
			"choices": "=PPQQ+()"
		}
	],

	[
		{
			"question": "0 {} {} [] 1",
			"choices": "XD<"
		},
		{
			"question": "[] X [] {} {} [] + []",
			"choices": "QQPP<="
		},
		{
			"question": "0 {} P [] [] []",
			"choices": "<>=P"
		}
	],
	[
		{
			"question": "[] {} {}   [] [] []   [] {} {}   {} {} {}  [] [] []  [] [] []",
			"choices": "0 X D + P + P d = P X P + 0 d + P d",
		},
		{
			"question": "[] [] [] [] [] {} {} [] [] [] [] {} {} + [] []",
			"choices": "PPP QQ DD (()) ++ = X"
		},
	],
]


## 获取第 [param chapter_id] 章节的关卡数量。
static func get_chapter_level_count(chapter_id: int) -> int:
	return len(LEVEL_DATA[chapter_id])


## 获取章节数量。
static func get_chapter_count() -> int:
	return len(LEVEL_DATA)
