# ジョブがエラーになった時の繰り返し回数
# 0は1と同じ
Delayed::Worker.max_attempts = 2

# ジョブがエラーになった時に、ジョブは残したままにする(削除しない)
Delayed::Worker.destroy_failed_jobs = false

# ジョブの実行時間
# Delayed::Worker.max_run_time = 2.seconds

# ジョブの先読み？よくわからない
Delayed::Worker.read_ahead = 3