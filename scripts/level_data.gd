class_name LevelData

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
    }
]

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
            "choices": "= + d 1"
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
            "name-en": "Make Me Laugh",
            "question": "1 {} {} = []",
            "choices": "XDD"
        },
        {
            "name-en": "Reset",
            "question": "0 [] [] {} []",
            "choices": "XD=0"
        },
        {
            "name-en": "Not Necessary",
            "question": "[] {} {} {} {} []",
            "choices": "QQQQQQ DDXX="
        },
        {
            "name-en": "[EX] Not Really Challenging",
            "question": "1 [] [] [] {} [] [] [] {} [] {} [] []",
            "choices": "== ++++++ 11 P q b R"
        },
        {
            "name-en": "[EX] Golden Experience",
            "question": "{} {} {} {} {} {} {} {} {} {}",
            "choices": "PP DD qq dd question XXX ="
        }
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
        {
            "name-en": "[EX] Really Challenging",
            "question": "[] [] [] [] [] {} {} [] [] [] [] {} {} + [] []",
            "choices": "PPP QQ DD (()) ++ = X"
        }
    ],

    [
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
    ]
]

static func get_chapter_level_count(chapter_id: int) -> int:
    return len(LEVEL_DATA[chapter_id])

static func get_chapter_count() -> int:
    return len(LEVEL_DATA)