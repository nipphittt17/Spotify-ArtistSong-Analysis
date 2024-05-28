# Spotify-ArtistSong-Analytics

## Overview
This project aims to gain insights into the characteristics and trends of the artist's songs. By leveraging the Spotify API, the track data of the artist is extracted, transformed, and analyzed to uncover interesting patterns and information. The processes are implemented in Python, and the visualizations are created with Tableau. Below are the links to each component of the project:

- [Spotify API functions](myFunctions.py)
- [Extract & Transform](extract_transform_track.ipynb)
- [Analysis](analyze_track.ipynbl)
- [Data visualization](....)

In this case study, the artist of focus is Fujii Kaze, a Japanese singer-songwriter and musician under Universal Music Japan. By analyzing his songs, I aim to gain deeper insights into his musical style, trends in his song releases, and the preferences of his audience. Nevertheless, the [Spotify API functions](myFunctions.py) can be leveraged to retrieve data on songs from other artists as well. Therefore, feel free to download and expand the analysis for the discography of your favorite artists.

## Spotify API
To proceed locally, follow these steps:

1. Clone the repository
```bash
git clone https://github.com/yourusername/spotify-artist-song-analytics.git
```

2. Create and activate a virtual environment
```bash
python3 -m venv venv
source venv/bin/activate
```
3. Install the required packages
```bash
pip install -r requirements.txt
```
4. Set up Spotify API credentials

Register on the Spotify Developer Dashboard to get client_id and client_secret. Create a .env file in the root directory of the project and add your credentials:
```bash
CLIENT_ID="your_client_id"
CLIENT_SECRET="your_client_secret"
```

## Data extraction and transformation

The Spotify API was used to retrieve three datasets. Initially, **general data** about the artist's tracks was collected. Subsequently, the track IDs were utilized to obtain the **audio analysis** and **feature** data for these tracks. The maximum number of tracks that can be retrieved is **50**, based on the artist's recent top tracks. Although these datasets contain numerous attributes, the project focuses on the following selected attributes from each dataset. The selection criteria prioritize simplicity and the developer's familiarity with the attributes.

**1. Track data: general information of the track.**

| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| track_id          | The unique id of each track.                                                                                    |
| track_name        | The name of each track.                                                                                         |
| href              | A link to the Web API endpoint providing full details of the track.                                            |
| popularity        | The popularity of the track. (0 and 100),calculated by the Spotify's algorithm.                                |
| uri               | The Spotify URI for the album.                                                                 |
| release_date      | The unique identifier for the station where the ride started.                                                   |
| album_id          | The album's id of each track.                                                                                   |
| album_name        | The album's name of each track.                                                                                |

**2. Track's analysis data: a low-level audio analysis of the track.**

| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| duration          | Length of the track in seconds.                                                                                |
| loudness          | The overall loudness of a track in decibels (dB).                                                              |
| tempo             | The overall estimated tempo of a track in beats per minute (BPM).                                              |
| time_signature    | The estimated time signature.                                                                                   |
| key               | The key the track is in. Integers map to pitches using standard Pitch Class notation.                          |
| mode              | Mode indicates the modality (major or minor) of a track                                                        |

**3. Track's features data: audio feature information of the track.**

| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| acousticness      | A confidence measure from 0.0 to 1.0 of whether the track is acoustic.                                         |
| energy            | Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity.             |
| danceability      | How suitable a track is for dancing based on a combination of musical elements                                 |

For more details on each attribute, please refer to the [Spotify for Developers official website](https://developer.spotify.com/documentation/web-api).

Following the extraction, the datasets were merged. Null values and duplications were observed, but no errors were detected. However, **duplications in track names** were identified, which could pose problems in analysis process. In this project, only the track data with the latest release date was retained, replacing the values of all numeric columns with the mean values calculated from all rows of the same track name.

After extraction and transformation, **2 entries** were removed, resulting in a dataset containing **48 entries**. It's worth noting that some attributes, such as 'href' and 'uri', may not be immediately usable in the analysis process. However, they were retained for the purpose of further development.

The Python code for extraction and transformation can be found in [this notebook](extract_transform_track.ipynb).

## Data analysis
To ....., the following analyses were performed.
1. Exploration of statistics of all numeric values in the dataset.
2. Identification of the most and least popular tracks.
3. Examination of the key, mode, and time signature used.
4. Inspection of the track analysis and features for each album.
5. Tracking the popularity of songs by release year.
6. Correlation analysis of each numeric attribute with respect to popularity.

The SQL queries used for this data analysis can be found [here](bike_2023_analyze_data.sql).

## Data visualization
The visualization was crafted using Tableau Public, featuring two pages: **Ride Distribution** and **Duration & Routes**.
The first page illustrates the total number of rides compared between annual members and casual riders across six months, each bike type, weekdays, and hourly intervals. 
<br><br> <img src="/images/dashboard_1.png" alt="Data Summary"> <br>

The second page displays the average ride length (in minutes) across weekdays and months, alongside the top 10 popular routes for annual members, casual riders, and round trips.
<br><br><img src="/images/dashboard_2.png" alt="Data Summary"> <br>


The interactive dashboard can be found [here](). Some of the visualizations can be filtered by month, day of week, and rideable type for specific examination. 

## Key findings
- **Total Ride Distribution:** Annual members contribute to around two times higher number of total rides, compared to casual riders.
 
- **Monthly Variation:** Both casual riders and annual members show increasing rides across six months. The number peaks in June, coinciding with the summer season in Chicago.

- **Bike Type:** Both annual members and casual riders preferred classic bikes over electric bikes. Only casual members utilized docked bikes, which contributed to the longest average ride durations.

- **Weekly Variation:** Annual members exhibit higher bike usage on weekdays, whereas casual riders show increased usage on weekends.

- **Hourly Usage:** Annual members peak in usage at 8 a.m. and 5 p.m., while casual riders have increased usage in the afternoon.

- **Ride Duration:** Casual riders typically experience longer average ride durations in comparison to annual members across all weekdays and months.

- **Popular Routes:** Casual riders and annual members have distinctively different routes with the highest ride frequencies. While annual members' preferred routes tend to be more directed towards specific destinations, 7 out of the top 10 favored routes for casual riders are round trips. 

According to the analysis, it appears that annual members primarily utilize Cyclistic bikes for daily commutes or errands. On the other hand, casual riders tend to use Cyclistic bikes more for leisure. The popular routes also provide further evidence supporting this assumption.

## Recommendations
- **Introduce customized membership plans** tailored for casual riders since they exhibit distinct ride patterns compared to annual members. One recommendation is a membership plan targeting weekend bike users, offering reduced costs compared to regular annual memberships with a limited number of uses throughout the year e.g. approximately matching the number of weekends annually. This necessitates further analysis of the average yearly cost spending by casual riders to present the benefits of such a plan.

- **Launch advertisements during peak hours particularly on weekends** through digital media. These advertisements could emphasize the advantages of annual membership, such as cost savings or additional benefits. This targeted approach aims to capture the attention of casual riders during their leisure time and persuade them to consider becoming long-term members.

- **Encourage casual riders who frequently use docked bikes**, as this group often has round trips with the longest average ride duration, around 40 minutes. This suggests usage for exercise. The company could consider developing an application to record ride duration and other health-related features. This application could offer exclusive features accessible only to members, serving as an incentive for casual riders to consider annual membership.

- **Mobile application for seamless user experience** can be used to encourage users to explore supplementary services, potentially fostering brand loyalty. The application can also serve as a channel to promote marketing campaigns and advertisements, showcasing the benefits of annual membership. 
