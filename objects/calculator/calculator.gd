extends Node


func is_alpha(ch: String) -> bool: ## 判断字符 ch 是否为字母。
	return (ch >= 'A' and ch <= 'Z') or (ch >= 'a' and ch <= 'z')
func is_eye(ch: String) -> bool: ## 判断字符 ch 是否为眼睛。
	return ch == "X" or ch == "="
func is_left_mouth(ch: String) -> bool: ## 判断字符 ch 是否为左边的嘴巴。
	return ch == "q" or ch == "d" or ch == "<"
func is_right_mouth(ch: String) -> bool:  ## 判断字符 ch 是否为右边的嘴巴。
	return ch == "P" or ch == "b" or ch == "D" or ch == ">"
func is_smile(string: String) -> bool:  ## 判断长度为 2 的字符串 string 是否为笑脸。
	return (is_left_mouth(string[0]) and is_eye(string[1])) or (is_eye(string[0]) and is_right_mouth(string[1]))

"""
op: *+
comp: <=>
bracl: (
bracr: )
val: Q/0/1

左/右	*	<	(	)	Q
*		0	0	1	0	1
<		0	1	1	0	1
(		0	0	1	1	1
)		1	1	1	1	1
Q		1	1	1	1	1
"""

const IS_PAIR_VALID := [[0, 0, 1, 0, 1], [0, 1, 1, 0, 1], [0, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 1, 1, 1, 1]]

enum {OP, COMP, BRAC_L, BRAC_R, VAL}

func get_char_type(ch: String) -> int:
	if ch == "*" or ch == "+":
		return OP
	elif ch == "<" or ch == "=" or ch == ">":
		return COMP
	elif ch == "(":
		return BRAC_L
	elif ch == ")":
		return BRAC_R
	else:
		return VAL

func get_priority(ch: String) -> int:
	if ch == "*":
		return 4
	elif ch == "+":
		return 3
	elif ch == "<" or ch == "=" or ch == ">":
		return 2
	elif ch == "(" and ch == ")":
		return 1
	else:
		assert(false, "get_priority error")
		return -1



## 将中缀表达式 expr 转为后缀表达式并返回（不判断 expr 的合法性）。
func infix_to_suffix(expr: String) -> String:
	var opt_stack: Array = []
	var res := ""
	
	for ch in expr:
		if get_char_type(ch) == VAL:
			res += ch
		elif ch == "(":
			opt_stack.push_back(ch)
		elif ch == ")":
			while not opt_stack.is_empty() and opt_stack.back() != "(":
				res += opt_stack.back()
				opt_stack.pop_back()
			opt_stack.pop_back()
		else:
			if not opt_stack.is_empty() and (get_char_type(ch) != COMP or get_char_type(opt_stack.back()) != COMP):
				while not opt_stack.is_empty() and get_priority(ch) <= get_priority(opt_stack.back()):
					res += opt_stack.back()
					opt_stack.pop_back()
			opt_stack.push_back(ch)
			
	while not opt_stack.is_empty():
		res += opt_stack.back()
		opt_stack.pop_back()

	return res
	


## 计算后缀表达式 expr 的值，其中变量的值给定，放在字典 var_values 中（不判断 expr 的合法性）。
func calculate_value(expr: String, var_values: Dictionary) -> bool:
	var stack: Array = []
	var val: bool
	var is_holding := false

	for ch in expr:
		if get_char_type(ch) != COMP and is_holding:
			is_holding = false
			stack.pop_back()
			stack.pop_back()
			stack.push_back(val)
			val = false
		
		if get_char_type(ch) == VAL:
			if is_alpha(ch):
				stack.push_back(var_values[ch])
			else:
				stack.push_back(ch == "1")
		elif get_char_type(ch) == COMP:
			is_holding = true
			if ch == "<":
				val = val or (stack[len(stack) - 2] < stack[len(stack) - 1])
			elif ch == "=":
				val = val or (stack[len(stack) - 2] == stack[len(stack) - 1])
			elif ch == ">":
				val = val or (stack[len(stack) - 2] > stack[len(stack) - 1])
		else:
			if ch == "+":
				val = stack[len(stack) - 2] or stack[len(stack) - 1]
			elif ch == "*":
				val = stack[len(stack) - 2] and stack[len(stack) - 1]
			stack.pop_back()
			stack.pop_back()
			stack.push_back(val)
			val = false
	
	if is_holding:
		is_holding = false
		stack.pop_back()
		stack.pop_back()
		stack.push_back(val)
		val = false
		
	assert(stack.size() == 1, "suffix expr is invalid.")
	return stack[0]
	
## 判断表达式 expr 是否合法（不检查括号匹配）。
##
## 合法返回 -1，否则返回“与该字符右侧相邻字符相邻不合法”的最小字符下标。
func check_valid(expr: String) -> int:
	for i in range(len(expr) - 1):
		if not IS_PAIR_VALID[get_char_type(expr[i])][get_char_type(expr[i + 1])]:
			return i
	return -1
	
	
## 判断表达式 expr 是否满足笑脸要求。
##
## 合法返回 -1，否则返回不为笑脸的最小字符下标。
func check_smile(expr: String, req_pos: Array) -> int:
	for i in req_pos:
		if (i == 0 or not is_smile(expr.substr(i - 1, 2))) and (i == len(expr) - 1 or not is_smile(expr.substr(i, 2))):
			return i
	return -1
	
	
## 判断表达式 expr 是否恒为真（不检查是否合法）。
##
## 合法返回空字典，否则一种使得表达式为假的变量取值。
func check_always_true(expr: String) -> Dictionary:
	var var_values: Dictionary = {} # var_values[var] 获取 var 的值。类型：Dictionary[String, bool]
	var var_names := [] # 变量名称列表
	
	# 中缀转后缀
	expr = infix_to_suffix(expr)
	
	for ch in expr:
		if is_alpha(ch) and not var_names.has(ch):
			var_names.push_back(ch)
	
	
	for s in range(0, 1 << len(var_names)):
		for i in range(len(var_names)):
			var_values[var_names[i]] = bool(s >> i & 1)
		if not calculate_value(expr, var_values):
			return var_values
	
	return {}

## 测试表达式 expr 是否符合通关要求，并返回相关信息。
## 
## 返回的是 [msg, additional_info]: [String, *]，
## 若表达式不合法，返回 ["INVALID", pos]，其中 pos: int 是出错的位置（即 pos, pos+1 相邻不合法）。
## 若不满足笑脸要求，返回 ["SMILE_UNSATISFIED", pos]，其中 pos: int 是没有笑脸的位置。
## 若表达式不恒为正，返回 ["NOT_ALWAYS_TRUE", var_values]，其中 var_values: Dictionary[String, bool] 是一种使得表达式为假的变量取值。
## 否则符合要求，返回 ["OK", 200]。

func check(expr: String, req_pos: Array) -> Array:	
	var tmp := 0

	
	# 判断合法性
	tmp = check_valid(expr)
	if tmp != -1:
		return ["INVALID", tmp]
	
	# 判断笑脸要求
	tmp = check_smile(expr, req_pos)
	if tmp != -1:
		return ["SMILE_UNSATISFIED", tmp]
	
	# 判断是否恒为正
	var tmp_dict := check_always_true(expr)
	if not tmp_dict.is_empty():
		return ["NOT_ALWAYS_TRUE", tmp_dict]
	
	return ["OK", 200]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
