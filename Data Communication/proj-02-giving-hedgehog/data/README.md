# Dataset Description

This dataset contains daily snapshot data of the Top songs on Spotify globally. Each entry includes metadata, ranking information, and audio features for a song.
- **Source**: [Kaggle - Top Spotify Songs in 73 Countries (Daily Updated)](https://www.kaggle.com/datasets/asaniczka/top-spotify-songs-in-73-countries-daily-updated)
- **Rows**: ~20,000+
- **Columns**: 20+
- **License**: Creative Commons (check dataset page for terms)
- **Used File**: `universal_top_spotify_songs.csv.gz`

## Columns

- **spotify_id** (`str`): Unique identifier for the song on Spotify.
- **name** (`str`): Song title.
- **artists** (`str`): Artist(s) of the song (split by ', ' to convert to list).
- **daily_rank** (`int`): Rank in the daily Top 50 chart.
- **daily_movement** (`int`): Change in rank compared to the previous day.
- **weekly_movement** (`int`): Change in rank compared to the previous week.
- **country** (`str`): ISO country code of the playlist; `Null` for Global Top 50.
- **snapshot_date** (`str`): Date the data was collected.
- **popularity** (`int`): Spotify popularity score.
- **is_explicit** (`bool`): `True` if the song contains explicit lyrics.
- **duration_ms** (`int`): Duration of the song in milliseconds.
- **album_name** (`str`): Title of the album.
- **album_release_date** (`str`): Release date of the album.

### Audio Features

- **danceability** (`float`): Suitability for dancing (0.0–1.0).
- **energy** (`float`): Intensity and activity level (0.0–1.0).
- **key** (`int`): Estimated musical key (0 = C, 1 = C♯/D♭, ..., 11 = B).
- **loudness** (`float`): Loudness in decibels (typically -60 to 0).
- **mode** (`int`): 1 for major, 0 for minor.
- **speechiness** (`float`): Presence of spoken words (0.0–1.0).
- **acousticness** (`float`): Confidence measure of being acoustic (0.0–1.0).
- **instrumentalness** (`float`): Likelihood of no vocals (0.0–1.0).
- **liveness** (`float`): Presence of live audience (0.0–1.0).
- **valence** (`float`): Musical positivity (0.0–1.0).
- **tempo** (`float`): Estimated tempo in BPM.
- **time_signature** (`int`): Estimated time signature (beats per bar).

> Notice
- Due to Shiny App's 1GiB memory limit, we've done data cleaning -- removal of unused columns, truncating
earlier snapshot_dates.
- This new dataset is now `truncated.csv.gz`.
- New dataset includes the following columns: 
"spotify_id"       "name"             "artists"          "country"          "snapshot_date"    "popularity"       "duration_ms"      "danceability"     "energy"           "key"             
"loudness"         "mode"             "speechiness"      "acousticness"     "instrumentalness" "liveness"         "valence"          "tempo"    


