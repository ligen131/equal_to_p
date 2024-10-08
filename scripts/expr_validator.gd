## 用于判定表达式 [code]expr[/code] 是否满足通关要求的脚本。
class_name ExprValidator


static func is_alpha(ch: String) -> bool: ## 判断字符 [param ch] 是否为字母。
	return (ch >= 'A' and ch <= 'Z') or (ch >= 'a' and ch <= 'z')
static func is_eye(ch: String) -> bool: ## 判断字符 [param ch] 是否为眼睛。
	return ch == "*" or ch == "="
static func is_left_mouth(ch: String) -> bool: ## 判断字符 [param ch] 是否为左边的嘴巴。
	return ch == "q" or ch == "d" or ch == "<"
static func is_right_mouth(ch: String) -> bool: ## 判断字符 [param ch] 是否为右边的嘴巴。
	return ch == "P" or ch == "b" or ch == "D" or ch == ">"
static func is_smile(string: String) -> bool: ## 判断长度为 2 的字符串 [param string] 是否为笑脸。
	return (is_left_mouth(string[0]) and is_eye(string[1])) or (is_eye(string[0]) and is_right_mouth(string[1]))

"""
op: *+
comp: <=>
bracl: (
bracr: )
val: Q/0/1

左/右	*	<	(	)	Q	0
*		0	0	1	0	1	1
<		0	*	1	0	1	1
(		0	0	1	0	1	1
)		1	1	1	1	1	1
Q		1	1	1	1	1	1
0		1	1	1	1	1	1
"""

"""
左/右	*	<	(	)	Q/0
*		/	/	0	/	0
<		/	0	0	/	0
(		/	/	0	/	0
)		0	0	1	0	1
Q/0		0	0	1	0	1
"""

## 用于判断相邻字符是否合法。
## [br][br]
## [code]IS_PAIR_VALID[x][y][/code] 表示若表达式中 [enum CharType] 为 [code]x[/code] 的字符，右边相邻的字符 [enum CharType] 为 [code]y[/code] 的情况下是否合法。
const IS_PAIR_VALID := [
	[0, 0, 1, 0, 1, 1],
	[0, 0, 1, 0, 1, 1],
	[0, 0, 1, 0, 1, 1],
	[1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1],
	[1, 1, 1, 1, 1, 1]
]

const CODE_LEQ := "\u2264"
const CODE_GEQ := "\u2265"
const CODE_NEQ := "\u2260"

## 字符类型。
enum CharType {
	OP, ## 算术运算符，包括 [code]*[/code] 和 [code]+[/code]。
	COMP, ## 比较运算符，包括 [code]<[/code]，[code]=[/code] 和 [code]>[/code]。
	BRACL, ## 左括号。
	BRACR, ## 右括号。
	VAR, ## 变量，即字母。
	CONST ## 常量，0 或 1。
}

static func is_pair_valid(ch1: String, ch2: String) -> bool: ## 判断相邻字符 [param ch1] 和 [param ch2] 是否合法。
	return (ch1 + ch2) in ["<=", ">=", "<>"] or IS_PAIR_VALID[get_char_type(ch1)][get_char_type(ch2)]

## 获取 [param ch] 的 [enum CharType]。
static func get_char_type(ch: String) -> CharType:
	if ch == "*" or ch == "+":
		return CharType.OP
	elif ch == "<" or ch == "=" or ch == ">" or ch == CODE_LEQ or ch == CODE_GEQ or ch == CODE_NEQ:
		return CharType.COMP
	elif ch == "(":
		return CharType.BRACL
	elif ch == ")":
		return CharType.BRACR
	elif ch == "0" or ch == "1":
		return CharType.CONST
	elif is_alpha(ch):
		return CharType.VAR
	else:
		push_error("get_char_type(%s) is undefined" % ch)
		return CharType.CONST
	

## 获取值等于 [param value] 的 [enum CharType] 名称。
static func get_char_type_enum_name(value: CharType) -> String:
	if value == CharType.OP:
		return "OP"
	elif value == CharType.COMP:
		return "COMP"
	elif value == CharType.BRACL:
		return "BRACL"
	elif value == CharType.BRACR:
		return "BRACR"
	elif value == CharType.VAR:
		return "VAR"
	elif value == CharType.CONST:
		return "CONST"
	else:
		push_error("get_char_type_enum_name(%d) is undefined" % value)
		return "ERR"


## 获取 [param ch] 的 [enum CharType] 名称。
static func get_char_type_as_str(ch: String) -> String:
	return get_char_type_enum_name(get_char_type(ch))
	

## 判断长度为 2 的字符串 [param string] 中间是否有隐含的乘号。
## [br][br]
## 如 [code]A([/code] 中有隐含的乘号，等价于 [code]A*([/code]。
## [br][br]
## 示例：
## [codeblock]
## has_implict_prod("A(") # true
## has_implict_prod(")(") # true
## has_implict_prod("AB") # true
## has_implict_prod("A+") # false
## has_implict_prod("+1") # false
## [/codeblock]
static func has_implict_prod(string: String) -> bool:
	return get_char_type(string[0]) in [CharType.BRACR, CharType.VAR, CharType.CONST] and get_char_type(string[1]) in [CharType.BRACL, CharType.VAR, CharType.CONST]


## 获取 [param ch] 在后缀运算中的优先级。
static func get_priority(ch: String) -> int:
	if ch == "*":
		return 4
	elif ch == "+":
		return 3
	elif ch == "<" or ch == "=" or ch == ">":
		return 2
	elif ch == "(" or ch == ")":
		return 1
	elif ch == "@":
		return 0
	else:
		assert(false, "get_priority error when ch=" + ch)
		return -1


## 将中缀表达式 [param expr] 转为后缀表达式并返回（不判断 [param expr] 的合法性）。
static func infix_to_suffix(expr: String) -> String:
	var opt_stack: Array = []
	var res := ""
	var pre_ch := "@"
	
	for ch in expr:
		if pre_ch != "@" and has_implict_prod(pre_ch + ch):
			if not opt_stack.is_empty() and (get_char_type("*") != CharType.COMP or get_char_type(opt_stack.back()) != CharType.COMP):
				while not opt_stack.is_empty() and get_priority("*") <= get_priority(opt_stack.back()):
					res += opt_stack.back()
					opt_stack.pop_back()
			opt_stack.push_back("*")
			
			
		#print("ch=", ch, " stk=", opt_stack, " res=", res)
		if get_char_type(ch) in [CharType.VAR, CharType.CONST]:
			res += ch
		elif ch == "(":
			opt_stack.push_back(ch)
		elif ch == ")":
			while not opt_stack.is_empty() and opt_stack.back() != "(":
				res += opt_stack.back()
				opt_stack.pop_back()
			opt_stack.pop_back()
		else:
			if get_char_type(pre_ch) != CharType.COMP or get_char_type(ch) != CharType.COMP:
				while not opt_stack.is_empty() and get_priority(ch) <= get_priority(opt_stack.back()):
					res += opt_stack.back()
					opt_stack.pop_back()
			opt_stack.push_back(ch)

		if len(res) >= 2 and get_char_type(res[len(res) - 1]) == CharType.COMP and get_char_type(res[len(res) - 2]) == CharType.COMP:
			match res.substr(len(res) - 2, 2):
				"=<":
					res = res.substr(0, len(res) - 2) + CODE_LEQ
				"<>":
					res = res.substr(0, len(res) - 2) + CODE_NEQ
				"=>":
					res = res.substr(0, len(res) - 2) + CODE_GEQ
				_:
					push_error("infix_to_suffix error when res=" + res)
		pre_ch = ch
			
	while not opt_stack.is_empty():
		res += opt_stack.back()
		
		if len(res) >= 2 and get_char_type(res[len(res) - 1]) == CharType.COMP and get_char_type(res[len(res) - 2]) == CharType.COMP:
			match res.substr(len(res) - 2, 2):
				"=<":
					res = res.substr(0, len(res) - 2) + CODE_LEQ
				"<>":
					res = res.substr(0, len(res) - 2) + CODE_NEQ
				"=>":
					res = res.substr(0, len(res) - 2) + CODE_GEQ
				_:
					push_error("infix_to_suffix error when res=" + res)

		opt_stack.pop_back()
	#prints(expr, res)
	
	return res
	

## 计算 [param opt]([param a], [param b]) 的值。
static func calc_bool(a: bool, opt: String, b: bool) -> bool:
	match opt:
		'+':
			return a or b
		'*':
			return a and b
		'<':
			return not a and b
		'=':
			return a == b
		'>':
			return a and not b
		CODE_LEQ:
			return not a or b
		CODE_GEQ:
			return a or not b
		CODE_NEQ:
			return a != b
		_:
			push_error("calc_bool error when opt=" + opt)
			return false

## 计算  [param opt]([param a], [param b]) 的值。
static func calc(a: Variant, opt: String, b: Variant) -> Variant:
	var res: Array[bool] = []
	if a is bool and b is bool:
		return calc_bool(a, opt, b)
	else:
		if a is bool:
			res = [calc_bool(a, opt, false), calc_bool(a, opt, true)]
		elif b is bool:
			res = [calc_bool(false, opt, b), calc_bool(true, opt, b)]
		else:
			res = [
				calc_bool(false, opt, false), calc_bool(false, opt, true), 
				calc_bool(true, opt, false), calc_bool(true, opt, true)
			]
		
		if res.all(func (x): return x == true):
			return true
		elif res.all(func (x): return x == false):
			return false
		else:
			return 'M'


## 计算后缀表达式 [param expr] 的值，其中变量的值给定，放在字典 [param var_values] 中（不判断 [param expr] 的合法性）。
static func calculate_value(expr: String, var_values: Dictionary) -> Variant:
	var stack: Array[Variant] = []

	for ch in expr:
		if get_char_type(ch) in [CharType.VAR, CharType.CONST]:
			if ch == 'M':
				stack.push_back(ch)
			elif is_alpha(ch):
				stack.push_back(var_values[ch])
			else:
				stack.push_back(ch == "1")
		else:
			var val = calc(stack[len(stack) - 2], ch, stack[len(stack) - 1])
			stack.pop_back()
			stack.pop_back()
			stack.push_back(val)
	assert(stack.size() == 1, "suffix expr is invalid.")
	return stack[0]
	

## 判断表达式 [param expr] 是否合法。
## [br][br]
## 返回不合法的下标列表。
static func check_invalid(expr: String) -> Array:
	var result: Array[int] = []

	# 特判开头及尾部是否合法
	if expr[0] != '_' and expr[0] != '(' and get_char_type(expr[0]) not in [CharType.VAR, CharType.CONST]:
		result.append(0)
	if expr[len(expr) - 1] != '_' and expr[len(expr) - 1] != ')' and get_char_type(expr[len(expr) - 1]) not in [CharType.VAR, CharType.CONST]:
		result.append(len(expr) - 1)

	# 测试相邻字符是否合法
	for i in range(len(expr) - 1):
		if expr[i] != '_' and expr[i + 1] != '_' and not is_pair_valid(expr[i], expr[i + 1]):
			result.append(i)
			result.append(i + 1)
	
	# 测试括号匹配
	var brac_sum := 0
	for i in range(len(expr)):
		if expr[i] == '(':
			brac_sum += 1
		elif expr[i] == ')':
			if brac_sum == 0:
				result.append(i)
			brac_sum -= 1
	if brac_sum > 0:
		for i in range(len(expr) - 1, -1, -1):
			if expr[i] == '(' and brac_sum > 0:
				brac_sum -= 1
				result.append(i)

	result.sort()
	# print(result)
	return Utils.array_unique(result)
	
	
## 判断表达式 [param expr] 是否满足笑脸要求。
## [br][br]
## 返回不为笑脸的字符下标列表。
static func check_smile(expr: String, req_pos: Array) -> Array:
	var res: Array[int] = []
	for i in req_pos:
		if (i == 0 or not is_smile(expr.substr(i - 1, 2))) and (i == len(expr) - 1 or not is_smile(expr.substr(i, 2))):
			res.append(i)
	return res
	
	
## 判断表达式 expr 是否恒为真（不检查是否合法）。
## [br][br]
## 合法返回 [code][true, {}][/code]，否则返回 [code][false, args][/code]，其中 [code]args[/code] 是一种使得表达式不为真的变量取值。
static func check_always_true(expr: String) -> Array:
	var var_values: Dictionary = {} # var_values[var] 获取 var 的值。类型：Dictionary[String, bool]
	var var_names := [] # 变量名称列表
	
	# 中缀转后缀
	expr = infix_to_suffix(expr)
	#print(expr)
	
	for ch in expr:
		if is_alpha(ch) and ch != 'M' and not var_names.has(ch):
			var_names.push_back(ch)
	
	
	for s in range(0, 1 << len(var_names)):
		for i in range(len(var_names)):
			var_values[var_names[i]] = bool(s >> i & 1)
		if calculate_value(expr, var_values) not in [true]:
			return [false, var_values]
	
	return [true, {}]



## 返回表达式字符串 [param expr] 中笑脸的下标列表。
static func get_smile_inds(expr: String) -> Array[int]:
	var res: Array[int] = []
	for i in range(len(expr) - 1):
		if expr[i] != '_' and expr[i + 1] != '_' and is_smile(expr.substr(i, 2)):
			if i not in res:
				res.append(i)
			res.append(i + 1)
	return res

# static func test():
	#check("q*Pq*bd*b=D", [])
	# check("0=P<>P", [])	
	#assert(check("(1=P)+(0=P)", []) == ["OK", 200], "9")
	#assert(check("Q+P=P+Q", [3, 4]) == ["OK", 200], "1")
	#assert(check("Q+P=P+Q", [4]) == ["OK", 200], "2")
	#assert(check("P+Q=Q+P", [3, 4]) == ["SMILE_UNSATISFIED", 3], "3")
	#
	#assert(check("1+R=P+1+q=b+1", [4, 8, 10]) == ["OK", 200], "5")
	#
	#assert(check("1+P=(0+)", [3]) == ["INVALID", [6, 7]], "4")
	#
	#assert(check("P+Q=P", [3]) == ["NOT_ALWAYS_TRUE", {"P": false, "Q": true}], "6")
