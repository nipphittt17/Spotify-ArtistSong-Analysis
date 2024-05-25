import pandas as pd

df = pd.read_csv("yao_songs_data.csv")
print(df.columns)

# 'album', 'artists', 'disc_number', 'duration_ms',
# 'explicit', 'external_ids', 'external_urls', 'href', 'id', 'is_local',
# 'is_playable', 'name', 'popularity', 'preview_url', 'track_number',
# 'type', 'uri'

#duration_ms #id #name #popularity
