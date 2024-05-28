import os
import base64
from dotenv import load_dotenv
load_dotenv()

from requests import post
from requests import get
import json

import pandas as pd

client_id = os.getenv("CLIENT_ID")
client_secret = os.getenv("CLIENT_SECRET")

def get_token():
    auth_string = client_id + ":" +  client_secret
    auth_bytes = auth_string.encode("utf-8")
    auth_base64 = str(base64.b64encode(auth_bytes), "utf-8")

    url = "https://accounts.spotify.com/api/token"

    headers = {
    "Authorization": "Basic " + auth_base64,
    "Content-Type": "application/x-www-form-urlencoded"
    }

    data = {"grant_type": "client_credentials"}

    result = post(url, headers=headers, data=data)
    json_result = json.loads(result.content)
    token = json_result["access_token"]
    return token


def get_auth_header(token):
    return {"Authorization" : "Bearer " + token}


def get_song(token, artist_name):
    url = f"https://api.spotify.com/v1/search"
    headers = get_auth_header(token)
    query = f"?q=artist:{artist_name}&type=track&market=TH&limit=50"
    query_url = url + query
    result = get(query_url, headers=headers)
    json_result = json.loads(result.content)["tracks"]["items"]
    return json_result

def get_album(token, album_id):
    url = f"https://api.spotify.com/v1/albums/{album_id}"
    headers = get_auth_header(token)
    result = get(url, headers=headers)
    json_result = json.loads(result.content)
    return json_result

def get_track_analysis(token, track_id):
    url = f"https://api.spotify.com/v1/audio-analysis/{track_id}"
    headers = get_auth_header(token)
    result = get(url, headers=headers)
    json_result = json.loads(result.content)["track"]
    return json_result

def get_track_feature(token, track_id):
    url = f"https://api.spotify.com/v1/audio-features/{track_id}"
    headers = get_auth_header(token)
    result = get(url, headers=headers)
    json_result = json.loads(result.content)
    return json_result

token = get_token()
results = get_album(token, "4aawyAB9vmqN3uQ7FjRGTy")
print(results)