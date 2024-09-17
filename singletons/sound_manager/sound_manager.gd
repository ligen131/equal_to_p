extends Node

var base_sfx_db := 0.0
var base_bgm_db := 0.0

func play_sfx(sfx: AudioStream, db: float = 0.0):
    var sfx_player := AudioStreamPlayer.new()
    self.add_child(sfx_player)
    
    sfx_player.stream = sfx
    sfx_player.volume_db = db
    sfx_player.bus = "sfx"
    sfx_player.play()
    sfx_player.finished.connect(sfx_player.queue_free.bind())

func play_bgm(bgm: AudioStream, db: float = 0.0):
    var bgm_player := AudioStreamPlayer.new()
    self.add_child(bgm_player)
    
    bgm_player.stream = bgm
    bgm_player.volume_db = db
    bgm_player.bus = "bgm"
    bgm_player.play()
    bgm_player.loop = true