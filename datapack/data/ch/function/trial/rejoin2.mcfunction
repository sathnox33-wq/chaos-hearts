$execute if score #s$(s) ch.state matches 1.. if score #s$(s) ch.owner = @s ch.pid run function ch:trial/cleanup {s:$(s)}
function ch:core/msg/say {m:"You left your trial, so it ended.",c:"red"}
function ch:trial/return
