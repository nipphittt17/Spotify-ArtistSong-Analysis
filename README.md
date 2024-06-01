# Spotify-ArtistSong-Analytics

## Overview
This project aims to gain insights into the characteristics and trends of the artist's songs. By leveraging the Spotify API, the track data of the artist is extracted, transformed, and analyzed to uncover interesting patterns and information. The extractation and transformation processes are implemented in Python, while the analysis process is performed in SQL. The discovered insights are visualized with Tableau. Below are the links to each component of the project:

- [Spotify API functions](myFunctions.py)
- [Extract & Transform](extract_transform_track.ipynb)
- [Analysis](analyze_track.sql)
- [Data visualization](https://public.tableau.com/views/draft_song/Dashboard22?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

In this case study, the artist of focus is Fujii Kaze, a Japanese singer-songwriter and musician under Universal Music Japan. By analyzing his songs, I aim to gain deeper insights into his musical style, trends in his song releases, and the preferences of his audience. Nevertheless, the [Spotify API functions](myFunctions.py) can be leveraged to retrieve data on songs from other artists as well. Therefore, feel free to download and expand the analysis for the discography of your favorite artists.

## Spotify API
To proceed locally, follow these steps:

**1. Clone the repository**
```bash
git clone https://github.com/yourusername/spotify-artist-song-analytics.git
```

**2. Create and activate a virtual environment**
```bash
python3 -m venv venv
source venv/bin/activate
```
**3. Install the required packages**
```bash
pip install -r requirements.txt
```
**4. Set up Spotify API credentials**

Register on the Spotify Developer Dashboard to get client_id and client_secret. Create a .env file in the root directory of the project and add your credentials:
```bash
CLIENT_ID="your_client_id"
CLIENT_SECRET="your_client_secret"
```

## Data extraction and transformation

The Spotify API was used to retrieve four datasets along with some artist's information. Initially, **general data** about the artist's tracks was collected. Subsequently, the track IDs were utilized to obtain the **audio analysis** and **audio feature** data for these tracks. The maximum number of tracks that can be retrieved is 50, based on the artist's recent top tracks. After merging the track data, some information about their **albums** was also retrieved. Although these datasets contain numerous attributes, the project focuses on the following selected attributes from each dataset. The selection criteria prioritize simplicity and the developer's familiarity with the attributes.

**1. Track data: general information of the track.**

| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| track_id          | The unique id of each track.                                                                                   |
| track_name        | The name of each track.                                                                                        |
| href              | A link to the Web API endpoint providing full details of the track.                                            |
| popularity        | The popularity of the track. [0, 00], calculated by the Spotify's algorithm.                                   |
| uri               | The Spotify URI for the album.                                                                                 |
| album_id          | The album's id of each track.                                                                                  |

**2. Track's analysis data: a low-level audio analysis of the track.**

| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| duration          | Length of the track in seconds.                                                                                |
| loudness          | The overall loudness of a track in decibels (dB).                                                              |
| tempo             | The overall estimated tempo of a track in beats per minute (BPM).                                              |
| time_signature    | The estimated time signature.                                                                                  |
| key               | The key the track is in. Integers map to pitches using standard Pitch Class notation.                          |
| mode              | Mode indicates the modality (major or minor) of a track                                                        |

**3. Track's features data: audio feature information of the track.**

| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| track_id          | The unique id of each track.                                                                                   |
| acousticness      | A confidence measure from 0.0 to 1.0 of whether the track is acoustic.                                         |
| energy            | Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.             |
| danceability      | How suitable a track is for dancing from 0.0 to 1.0 based on a combination of musical elements                 |

**4. Album data: .**

a[["album_id", "album_name", "album_type", "album_popularity", "release_date", "total_tracks", "album_uri", "album_href"]]

| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| album_id          | The unique id of each album.                                                                                   |
| album_name        | The name of each album.                                                                                        |
| album_type        | The type of the album (single, album, compilation).                                                            |
| album_popularity  | The popularity of the album. [0, 00], calculated by the Spotify's algorithm.                                   |
| release_date      | The date the album was first released.                                                                         |
| total_tracks      | The number of tracks in the album.                                                                             |
| album_uri         | The Spotify URI for the album.                                                                                 |
| album_href        | A link to the Web API endpoint providing full details of the album.                                            |


For more details on each attribute, please refer to the [Spotify for Developers official website](https://developer.spotify.com/documentation/web-api).

Following the extraction, the datasets were merged and transformed by 

1. Null Values and Duplications
- No null values or duplications in any entries.
3. Album Adjustments
- Dropped cover albums *HELP EVER HURT COVER* and *LOVE ALL COVER ALL* to focus on original songs.
- Removed the compilation album *Best of Fujii Kaze 2020-2024* as it contains duplicated versions of popular songs.
- Noted that *Kirari Remixes (Asia Edition)* should have 9 tracks, but only 2 were retrieved due to the API limitation.
- There are two *Hana* albums with the same name but different. One contains an original song while the other contains a ballad version. For simplicity, dropped the album with the track *Hana-Balad* as it should have 4 versions, but only 2 tracks were retrieved, so we are focusing on the original one.
4. Duplication tracks with Japanese titles
- *Matsuri* from the album *LOVE ALL COVER ALL* has a duplicated single version with a Japanese title (*まつり*). Since the audio analysis and features are very similar, we decided to keep the one with the English title due to its inclusion in the album and higher popularity.
- *Hademo Ne-Yo -LASA edit* has its original version titled in Japanese (*へでもねーよ*). As the audio analysis and features differ, we kept both versions and translated the Japanese title to English (*Hademo Ne-Yo*).
- *Kirari* from *Kirari Remixes (Asia Edition)* is titled in Japanese (*きらり*). However, there is also a Kirari track from the album LOVE ALL COVER ALL, so we renamed this one to *Kirari (Asia Edition)*.
5. Mapping Analysis Attributes
- Mapped the key and mode integers back to their original values (e.g. Major or Minor, and C to B).
- Converted the time signature format from x to x/4.

After extraction and transformation, **21 entries** were removed, resulting in a dataset containing **29 entries**. It's worth noting that some attributes, such as 'href' and 'uri', may not be immediately usable in the analysis process. However, they were retained for the purpose of referenced and further development.

The Python code for extraction and transformation can be found in [this notebook](extract_transform_track.ipynb).

## Data analysis
To derive the insights, the following analyses were performed.
1. Exploration of statistics of all numeric values in the dataset.
2. Identification of the most and least popular tracks.
3. Examination of the key, mode, and time signature used.
4. Inspection of the track analysis and features for each album.
5. Tracking the popularity of songs by release year.
6. Correlation analysis of each numeric attribute towards the popularity.

The Python code for this data analysis can be found in [this notebook](analyze_track.ipynb).

## Data visualization
The visualization was crafted using Tableau Public. It illustrates the ....
<br><br> <img src="/images/dashboard_1.png" alt="Data Summary"> <br>
The interactive dashboard can be found [here]().

## Key findings
- **Total Ride Distribution:**
