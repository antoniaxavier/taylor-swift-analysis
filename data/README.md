# Data Documentation

## Overview

This folder contains datasets used in both clustering and NLP analyses. **All data is 
open and publicly available**; no restricted data is included.

---

## Datasets

### 1. `taylor_swift_genius_data.csv`

**Source:** Genius API (via GitHub repository: adashofdata/taylor_swift_data)

**Content:**
- Song lyrics for 147 Taylor Swift songs
- 4 columns: `index`, `Album`, `Song Name`, `Lyrics`

**Albums included:**
- Taylor Swift (14 songs)
- Fearless (13)
- Speak Now (14)
- Red (16)
- 1989 (13)
- Reputation (15)
- Lover (18)
- Folklore (16)
- Evermore (15)
- Midnights (13)

**Note:** Original versions only (no Deluxe, no Taylor's Versions, no Anthology)

**Size:** ~2.6 MB (271 KB CSV)

---

### 2. `musicas_classificadas.csv`

**Source:** Manual annotation (100 songs randomly sampled from dataset)

**Content:**
- 2 columns: `Música` (song name), `Sentimento` (emotion label)
- Sentiment labels: Joy, Sadness, Anger, Fear, Surprise, Disgust, Trust, Anticipation

**Protocol:**
1. Randomly sample 100 songs from corpus
2. Listen to full track (Spotify)
3. Read complete lyrics
4. Assign primary emotion based on overall mood/theme
5. One label per song

**Distribution:**
- Sadness: 28%
- Joy: 19%
- Anticipation: 17%
- Anger: 12%
- Others: 24%

**Size:** 2.6 KB

---

## Getting Audio Features (Clustering)

For clustering analysis, you need **Spotify audio features** (not included in this repo).

### Setup

1. **Get Spotify credentials:**
   - Visit https://developer.spotify.com/dashboard
   - Create a new app
   - Copy `Client ID` and `Client Secret`

2. **Authenticate in R:**
   ```r
   library(spotifyr)
   
   Sys.setenv(SPOTIFY_CLIENT_ID = 'YOUR_CLIENT_ID')
   Sys.setenv(SPOTIFY_CLIENT_SECRET = 'YOUR_CLIENT_SECRET')
   access_token <- get_spotify_access_token()
   ```

3. **Fetch audio features:**
   ```r
   ts <- get_artist_audio_features('taylor swift', include_groups = c("album"))
   ```

**Note:** This requires internet connection and valid Spotify credentials.

---

## Data Licenses

| Dataset | Source | License | Notes |
|---------|--------|---------|-------|
| **Genius lyrics** | Genius.com | [User Agreement](https://genius.com/app-agreement) | Non-commercial use recommended |
| **Spotify features** | Spotify API | [TOS](https://developer.spotify.com/terms) | Free tier (rate limits apply) |
| **Manual annotations** | Original work | CC BY-SA 4.0 | Shared under Creative Commons |

---

## Data Access for Reproducibility

### Option 1: Use Included CSV (Lyrics only)
```python
import pandas as pd

# Load lyrics
lyrics_df = pd.read_csv('taylor_swift_genius_data.csv')

# Load manual annotations
manual_labels = pd.read_csv('musicas_classificadas.csv', sep=';')

# Merge
data = pd.merge(lyrics_df, manual_labels, left_on='Song Name', right_on='Música')
```

### Option 2: Fetch Spotify Features (Full analysis)
```r
library(spotifyr)

# Set credentials (see Setup section)
ts <- get_artist_audio_features('taylor swift', include_groups = c("album"))

# Features included:
# - danceability, energy, acousticness, valence
# - loudness, tempo, duration_ms
# - key, mode (major/minor)
```

---

## Data Processing Notes

### Lyrics Preprocessing
- Converted to lowercase
- Tokenized with NLTK (English)
- Removed punctuation, numbers
- Removed English stopwords
- Lemmatized (WordNetLemmatizer)
- **Result:** 2,844 unique tokens

### Spotify Features Normalization
- Min-max scaling (0–1 range)
- Applied to: loudness, tempo, duration
- Ensures equal feature weighting in clustering

### Missing Values
- Genius: No missing lyrics
- Spotify: No missing audio features (public API provides complete data)
- Manual annotation: ~31% of songs unlabeled (100/147); treated separately as test set

---

## Data Quality

### Known Issues
1. **Genius data:** Some songs may have intro/outro chatter mixed with lyrics
2. **Spotify:** Rerecorded versions have different audio profiles than originals
3. **Manual labels:** Single annotator (author); potential bias toward album themes
4. **Missing versions:** No TV (Taylor's Versions) or deluxe editions

### Recommendations
- For production use, validate against multiple annotators
- Consider album metadata (release date, producer) in final analysis
- Use multiple emotion classification methods (triangulation)

---

## Citation

**Lyrics data:**
```
adashofdata. (2020). Taylor Swift Data. Retrieved from 
https://github.com/adashofdata/taylor_swift_data
```

**Spotify API:**
```
Spotify. (2024). Spotify Web API. Retrieved from 
https://developer.spotify.com/documentation/web-api
```

**Manual annotations:**
```
Xavier, A. (2024). Taylor Swift Sentiment Annotations. 
Retrieved from [this repository]
```

---

**Last updated:** 2024-09-09  
**Data version:** 1.0
