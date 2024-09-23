## 用于存放一些通用函数的脚本。

class_name Utils

## 将数组元素去重后返回。
static func array_unique(arr: Array) -> Array:
    var res := []
    for i in arr:
        if i not in res:
            res.append(i)
    return res