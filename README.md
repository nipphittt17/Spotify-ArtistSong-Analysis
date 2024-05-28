# Spotify-ArtistSong-Analytics

## Overview
The Spotify Artist Song Analytics Case Study is my personal project 

This project aims to to gain insights into the characteristics and trends of the artist's songs. By leveraging the Spotify API, the project extracts track data, track analysis data, and track features data, which are then transformed and analyzed to uncover interesting patterns and information. The processes are implemented on Python, and the visualizations are created with Tableau. Below are the links to each component of the project.

- [Sppotify API functions](myFunctions.py)
- [Extract & Transform](extract_transform_track.ipynb)
- [Analysis](analyze_track.ipynbl)
- [Data visualization](....)

## Sppotify API
The myFunctions.py file can be used to extract the othet artists' tracks data. To proceed locally, follow these steps:

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


## Data preparation
In this case study, the arttributes shown here are those selected ....
| Variable          | Description                                                                                                    |
|-------------------|----------------------------------------------------------------------------------------------------------------|
| ride_id           | The unique id of each ride                                                                                     |
| rideable_type     | Type of bicycles, including classic, electric, and docked bikes                                                |
| started_at        | The start time of the trip                                                                                     |
| ended_at          | The end time of the trip                                                                                       |
| start_station_name| The name of the station where the ride started                                                                 |
| start_station_id  | The unique identifier for the station where the ride started                                                   |
| end_station_name  | The name of the station where the ride ended                                                                   |
| end_station_id    | The unique identifier for the station where the ride ended                                                     |
| start_lat         | The latitude coordinate of the starting station                                                                |
| start_lng         | The longitude coordinate of the starting station                                                               |
| end_lat           | The latitude coordinate of the ending station                                                                  |
| end_lng           | The longitude coordinate of the ending station                                                                 |
| member_casual     | Indicates whether the rider is a member or a casual rider                                                      |


## Data exploration
R programming was used for this step. Initially, the datasets from January to June 2023 were merged, **resulting in a total of 2,390,459 entries**. Subsequently, the **skim_without_charts** function was used to generate a data summary, as shown in the figure below.

<img src="/images/skim_without_charts.png" alt="Data Summary"> <br>

Referring to the figure, it's evident that there are **null values** present in the following variables: start_station_id, start_station_name, end_station_id, end_station_name, end_lat, and end_lng.
Following this observation, **duplications** and **spelling errors** within string datatype columns, including rideable_type, start_station_name, and end_station_name, was checked. No errors were detected.

## Data cleaning

Following exploration, the dataset was cleaned by:

1. Entries with null values in start_station_id, start_station_name, end_station_id, and end_station_name were removed. (In this personal case study, despite their potential utility for future analysis, latitude and longitude were not used to avoid misleading analysis. For example, while displacement based on latitude and longitude may seem shorter, it doesn't consider real-world factors like buildings and roads that can make actual travel distances longer. Therefore, the null values in end_lat and end_lng were ignored.)
2. Three new columns were added: ride_length (ended_at - started_at), day_of_week (Sunday - Saturday), and month.
3. Entries where the ended time preceded the started time were excluded.
4. Entries with ride durations longer than a day or less than a minute were excluded.

After cleaning, **613,050 entries were removed**, resulting in **a total of 1,777,409 entries** in the dataset.
The cleaned data was saved as a .csv file, making it readily available for analysis.

The R code for data exploration and data cleaning can be found [here](bike_2023_clean_data.Rmd).

## Data analysis
To address the key findings, the following analyses were performed using SQL.
1. The number of casual riders vs annual members contributed to total rides.
2. Average duration of all trips for casual riders and annual members.
3. The number of casual riders and annual members for each type of bike.
4. The number of casual riders and annual members per day of the week, alongside the average trip duration.
5. The distribution of casual riders and annual members across each hour of the day.
6. The number of casual riders and annual members in each month, along with the average trip duration.
7. The top 10 popular routes for annual members, including the total number of rides.
8. The top 10 popular routes for casual riders, including the total number of rides.
9. The top 10 round-trip routes, including the number of rides by both members and casual riders.

The SQL queries used for this data analysis can be found [here](bike_2023_analyze_data.sql).

## Data visualization
The visualization was crafted using Tableau Public, featuring two pages: **Ride Distribution** and **Duration & Routes**.
The first page illustrates the total number of rides compared between annual members and casual riders across six months, each bike type, weekdays, and hourly intervals. 
<br><br> <img src="/images/dashboard_1.png" alt="Data Summary"> <br>

The second page displays the average ride length (in minutes) across weekdays and months, alongside the top 10 popular routes for annual members, casual riders, and round trips.
<br><br><img src="/images/dashboard_2.png" alt="Data Summary"> <br>


The interactive dashboard can be found [here](https://public.tableau.com/views/bike_data_17111672299010/Dashboard1?:language=en-US&onFirstInteraction=function()%20%7B%0A%20%20%20%20%20%20%20%20workbook%20%3D%20viz.getWorkbook();%0A%20%20%20%20%20%20%20%20activeSheet%20%3D%20workbook.getActiveSheet();%0A%20%20%20%20%20%20%20%20console.log(%22My%20dashboard%20is%20interactive%22);%0A%20%20%20%20%7D&:embed=y&:display_count=n&:sid=&:origin=viz_share_link). Some of the visualizations can be filtered by month, day of week, and rideable type for specific examination. 

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
