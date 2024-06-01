# Spotify-ArtistSong-Analytics

## Overview
This project aims to gain insights into the characteristics and trends of the artist's songs. By leveraging the Spotify API, the track data of the artist is extracted, transformed, and analyzed to uncover interesting patterns and information. The extractation and transformation processes are implemented in Python, while the analysis process is performed in SQL. The discovered insights are visualized with Tableau. Below are the links to each component of the project:

- [Spotify API functions](myFunctions.py)
- [Extract & Transform](extract_transform_track.ipynb)
- [Analysis](analyze_track.sql)
- [Visualization](https://public.tableau.com/views/draft_song/Dashboard22?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

In this case study, the artist of focus is Fujii Kaze, a Japanese singer-songwriter and musician under Universal Music Japan. By analyzing his songs, I aim to gain deeper insights into his musical style, trends in his song releases, and the preferences of his audience. Nevertheless, the [Spotify API functions](myFunctions.py) can be leveraged to retrieve data on songs from other artists as well. Therefore, feel free to utilize the code and expand the analysis for the discography of your favorite artists.

## Data extraction and transformation

The functions to retrieved data from Spotify API were written in [myFunctions.py](myFunctions.py) file. In [extract_transform_track.ipynb](extract_transform_track.ipynb), those functions were called to get four datasets along with some artist's information. Initially, **general data** about the artist's tracks was collected. Subsequently, the track IDs were utilized to obtain the **audio analysis** and **audio feature** data for these tracks. The maximum number of tracks that can be retrieved is **50**, based on the artist's recent top tracks. After merging the track data, some information about their **albums** was also retrieved. Although these datasets contain numerous attributes, the project focuses on the following selected attributes from each dataset. The selection criteria prioritize simplicity and the developer's familiarity with the attributes.

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

**4. Album data: general information of the album.**

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

**1. Checking null values and duplications**
- No null values or duplications in any entries.

**2. Adjusting albums**
- Dropped cover albums *HELP EVER HURT COVER* and *LOVE ALL COVER ALL* to focus on original songs.
- Removed the compilation album *Best of Fujii Kaze 2020-2024* as it contains duplicated versions of popular songs.
- Noted that *Kirari Remixes (Asia Edition)* should have 9 tracks, but only 2 were retrieved due to the API limitation.
- There are two *Hana* albums with the same name but different version. One contains an original song while the other contains a ballad version. For simplicity, focused on the original songe and dropped the album with the track *Hana-Balad* as it should have four versions, but only two were retrieved.

**3. Addressing duplication tracks with Japanese titles**
- *Matsuri* from the album *LOVE ALL COVER ALL* has a duplicated single version with a Japanese title (*まつり*). Since the audio analysis and features are very similar, we decided to keep the one with the English title due to its inclusion in the album and higher popularity.
- *Hademo Ne-Yo -LASA edit* has its original version titled in Japanese (*へでもねーよ*). As the audio analysis and features differ, we kept both versions and translated the Japanese title to English (*Hademo Ne-Yo*).
- *Kirari* from *Kirari Remixes (Asia Edition)* is titled in Japanese (*きらり*). However, there is also a Kirari track from the album LOVE ALL COVER ALL, so we renamed this one to *Kirari (Asia Edition)*.

**4. Mapping analysis attributes**
- Mapped the key and mode integers back to their original values (e.g. Major or Minor, and C, C#/Db, D, ..., B).
- Converted the time signature format from x to x/4.

After extraction and transformation, **21 entries** were removed, resulting in a dataset containing **29 entries**. It's worth noting that some attributes, such as 'href' and 'uri', may not be immediately usable in the analysis process. However, they were retained for the purpose of references and further development.

The Python code for extraction and transformation can be found in [this notebook](extract_transform_track.ipynb).

## Data analysis
To derive the insights, the following analyses were performed.
1. Identifying the Top 10 Popular Tracks.
2. Album Details: Including name, release year, total tracks, and the most popular track in the album.
3. Tracking Song Popularity by Release Year: This includes average values and the top song for each year.
4. Analyzing Key, Mode, and Time Signature Distributions: This is done for all tracks and for each album.
5. Examining Average Duration, Loudness, and Tempo: This analysis is conducted for all tracks and for each album.
6. Inspecting Acousticness, Energy, and Danceability: This analysis is conducted for all tracks and for each album.

The Python code for this data analysis can be found in [this notebook](analyze_track.ipynb).

## Data visualization
The visualization was crafted using Tableau Public. It illustrates the ....
<br><br> <img src="/images/dashboard_1.png" alt="Data Summary"> <br>
The interactive dashboard can be found [here]().

## Key findings
- **Total Ride Distribution:**
