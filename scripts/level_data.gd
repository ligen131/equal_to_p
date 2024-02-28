## 章节和关卡数据。
class_name LevelData


 
## 各章节的名称。
## [br][br] 
## [code]CHAP_NAMES[chapter_id]["name-en"][/code] 返回第 [param chapter_id] 章节的英文名称（包含 [code]Ch.[/code] 前缀）。
const CHAP_NAMES := [
	{
		"name-en": "Ch. 1  =P",
	},
	{
		"name-en": "Ch. 2  Add and Multiply",
	},
	{
		"name-en": "Ch. 3  ()",
	},
	{
		"name-en": "Ch. 4  Equal?",
	},
	{
		"name-en": "Ch. 5  <>",
	},
	{
		"name-en": "Ch. EX Challenge Levels",
	}
]


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
			"name-en": "=P",
			"question": "P [] []",
			"choices": "= P"
		},
  		{
			"name-en": "Smile",
			"question": "P {} {}",
			"choices": "= P P"
		},
		{
			"name-en": "Another Smile",
			"question": "[] = {}",
			"choices": "R R P D D"
		},
  		{
			"name-en": "Reverse",
			"question": "{} [] []",
			"choices": "D D = d d"
		},
  		{
			"name-en": "Reverse Again",
			"question": "[] {} {}",
			"choices": "d d = R R b b"
		},
  		{
			"name-en": "Snake",
			"question": "[] = {} = {} = [] = {} = {}",
			"choices": "dddddd QQQQQQ RRRRRR DDDDDD PPPPPP qqqqqq"
		}
	],
	
	[
		{
			"name-en": "0+0=0, 0+1=1",
			"question": "[] [] {} {} d",
			"choices": "= + 0 d"
		},
		{
			"name-en": "1+1=1",
			"question": "[] [] {} {} 1",
			"choices": "= + 1 d"
		},
		{
			"name-en": "Swap",
			"question": "Q + [] = {} + []",
			"choices": "P P P P Q Q Q Q"
		},
		{
			"name-en": "Always True",
			"question": "1 [] {} = {} [] []",
			"choices": "1++PPdd"
		},
		{
			"name-en": "Paper Tiger",
			"question": "1 [] [] [] {} [] [] [] {} [] {} [] []",
			"choices": "== ++++++ 11 P q b R"
		},
		{
			"name-en": "Make Me Laugh",
			"question": "1 {} {} = []",
			"choices": "XDD"
		},
		{
			"name-en": "Reset",
			"question": "0 [] [] {} []",
			"choices": "XP=0"
		},
		{
			"name-en": "Not Necessary",
			"question": "[] {} {} {} {} []",
			"choices": "QQQQQQ DDXX="
		},
		{
			"name-en": "True Reset",
			"question": "[] + [] [] [] [] {} = {} [] [] [] [] [] []",
			"choices": "0 0 1 d d q P P b R R Q +"
		},
		{
			"name-en": "Gold Experience",
			"question": "{} {} {}   {} {} {}   {} {} {} {}   {} {} {}   {} {} {}",
			"choices": "PP DD bb   qq dd   XXXXX ="
		},
	],

	[
		{
			"name-en": "He Goes First",
			"question": "[] [] + [] = ( [] {} {} ) [] []",
			"choices": "PP QQ RR X +"
		},
		{
			"name-en": "Still, He Goes First",
			"question": "[] + [] [] = [] [] ( [] {} {} )",
			"choices": "PP QQ RR X +"
		},
		{
			"name-en": "It's My Turn",
			"question": "P ([] [] []) = {} [] [] [] []",
			"choices": "PP QQ RR ++"
		},
	],

	[
		{
			"name-en": "Missing Equation",
			"question": "[] + [] {} {}",
			"choices": "P P P 1 X",
		},
		{
			"name-en": "Why?",
			"question": "[] [] {} = {} [] {} = []",
			"choices": "PP qq ++ 1"
		},
		{
			"name-en": "Where is the Equation?",
			"question": "[] [] {} {} [] + [] [] {} {} []",
			"choices": "(())==01PP"
		},

		{
			"name-en": "Untitled",
			"question": "[] [] {} {} [] [] [] []",
			"choices": "=PPQQ+()"
		}
	],

	[
		{
			"name-en": "<",
			"question": "0 {} {} [] 1",
			"choices": "XD<"
		},
		{
			"name-en": "<=",
			"question": "[] X [] {} {} [] + []",
			"choices": "QQPP<="
		},
		{
			"name-en": "<>",
			"question": "0 {} P [] [] []",
			"choices": "<>=P"
		}
	],
	[
		{
			"name-en": "[EX]Erase Which?",
			"question": "[] {} {}   [] [] []   [] {} {}   {} {} {}  [] [] []  [] [] []",
			"choices": "0 X D + P + P d = P X P + 0 d + P d",
		},
		{
			"name-en": "[EX] Really Challenging",
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
