class_name Utils

static func array_unique(arr: Array) -> Array:
    var res := []
    for i in arr:
        if i not in res:
            res.append(i)
    return res