import pandas as pd
import os
import spotipy
from spotipy.oauth2 import SpotifyClientCredentials
from dotenv import load_dotenv
load_dotenv()

from requests import post
from requests import get
import json

import pandas as pd

client_id = os.getenv("CLIENT_ID")
client_secret = os.getenv("CLIENT_SECRET")


sp = spotipy.Spotify(auth_manager=SpotifyClientCredentials(client_id=client_id,
                                                           client_secret=client_secret))

d = []

total = 1 # temporary variable
offset = 0

while offset < total:
    results = sp.search(q="artist:guns n' roses",  type='track', offset=offset, limit=50)
    total = results['tracks']['total']
    offset += 100 # increase the offset
    for idx, track in enumerate(results['tracks']['items']):
        d.append (
            {
                'Track' : track['name'],
                'Album' : track['album']['name'],
                'Artist' : track['artists'][0]['name'],
                'Release Date' : track['album']['release_date'],            
                'Track Number' : track['track_number'],
                'Popularity' : track['popularity'],
                'Track Number' : track['track_number'],
                'Explicit' : track['explicit'],
                'Duration' : track['duration_ms'],
                'Audio Preview URL' : track['preview_url'],
                'Album URL' : track['album']['external_urls']['spotify']
            }
        )

data = pd.DataFrame(d)
print(len(data))