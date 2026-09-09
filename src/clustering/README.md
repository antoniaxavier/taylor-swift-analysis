# Clustering Analysis

**Hierarchical and K-Means clustering of Taylor Swift's Spotify audio features**

---

## Overview

Unsupervised learning on 8 audio features from 147 Taylor Swift songs across 11 albums.

**Question:** Do Taylor's songs naturally group by era based on sound alone?

**Answer:** Yes — clusters align strongly with album timelines and stylistic shifts.

---

## Data

- **Source:** Spotify API (via `spotifyr`)
- **Scope:** 147 tracks, 11 albums, 2006–2024
- **Features:** danceability, energy, acousticness, valence, loudness, tempo, duration, key/mode

---

## Methods (Simplified)

1. **Normalize** audio features (min-max scaling, 0–1)
2. **Calculate distances** (Euclidean)
3. **Hierarchical clustering** with complete linkage
4. **K-Means** for comparison
5. **Validate** using silhouette width + Dunn index

**Optimal k = 4–5 clusters**

---

## Key Findings

✅ **Clear era-based clustering:**
- Early albums (Taylor Swift, Fearless, Speak Now) — acoustic, coherent
- Pop era (1989, Reputation, Lover) — high energy, danceability
- Introspective (folklore, evermore, Midnights) — lower energy, varied

✅ **Feature rankings (importance for clustering):**
1. Energy (separates eras most)
2. Danceability
3. Acousticness
4. Valence (happiness)

✅ **Album diversity increasing:** Recent albums show more within-album variety

---

## Visualizations

- **dendrogramas.png** — Full dendrogram (complete linkage, k=5 cuts)
- **kmeans.png** — K-Means scatter plots (k=4, 5, 11)

See `results/clustering/figures/`

---

## Full Results & Interpretation

**→ [See `results/clustering/analysis.md`](../../results/clustering/analysis.md)**

(Detailed findings, cluster profiles, temporal trends, outliers, implications)

---

## Code

**`analysis.R`** — Full reproducible pipeline (268 lines)

To run:
```r
# Set Spotify credentials
Sys.setenv(SPOTIFY_CLIENT_ID = 'YOUR_ID')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'YOUR_SECRET')

# Execute
source("analysis.R")
```

---

## Technical Methods

For in-depth methodology (distance metrics, linkage methods, validation):

**→ [See `docs/clustering-methods.md`](../../docs/clustering-methods.md)**

---

## Article

**→ [See `reports/clustering-article.pdf`](../../reports/clustering-article.pdf)** (full research article, Portuguese)

---

**Navigation:**
- [← Back to main](../../README.md)
- [Results](../../results/clustering/analysis.md)
- [Methods](../../docs/clustering-methods.md)
