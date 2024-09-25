class_name SaveLib

const SAVE_FILEPATH = "user://save.cfg"

static var _save_config_file: ConfigFile = null


static func _set_prop(section: String, key: String, value: bool) -> void:
    if _save_config_file == null:
        _load()
    _save_config_file.set_value(section, key, value)

static func _get_prop(section: String, key: String, default_value: Variant) -> Variant:
    if _save_config_file == null:
        _load()
    if not _save_config_file.has_section_key(section, key):
        _set_prop(section, key, default_value)
    return _save_config_file.get_value(section, key)


static func _init_new_save() -> void:
    pass
    

static func _load() -> void:
    _save_config_file = ConfigFile.new()
    var error = _save_config_file.load(SAVE_FILEPATH)
    if error != OK:
        push_warning("Error loading file", error)
        push_warning("Creating new save file")
        _init_new_save()
        

static func _save() -> void:
    var error = _save_config_file.save(SAVE_FILEPATH)
    if error != OK:
        printerr("Error saving file", error)


static func is_level_cleared(chapter_id: int, level_id: int) -> bool:
    return _get_prop("level_cleared", str(LevelData.get_level_code(chapter_id, level_id)), false)

static func set_level_cleared(chapter_id: int, level_id: int, value: bool) -> void:
    _set_prop("level_cleared", str(LevelData.get_level_code(chapter_id, level_id)), value)