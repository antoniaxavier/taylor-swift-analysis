# 🎵 Taylor Swift Analysis

**Advanced statistical and NLP methods applied to Taylor Swift's discography**

---

## 🎨 Visual Overview

**→ [Interactive Canva Presentation](https://canva.link/38t4cvu6be8yynr)** (includes dendrograms, cluster visualizations, era comparisons)

---

## 📊 Two Complementary Analyses

### 1️⃣ **Clustering Analysis**
*Audio feature segmentation — how Spotify sees Taylor's evolution*

- **Data:** Spotify API (147 tracks, 11 albums)
- **Method:** Hierarchical clustering + K-Means
- **Finding:** 4–5 natural clusters aligned with **album eras** (country → pop → introspective)
- **Output:** Dendrograms, cluster profiles, audio fingerprints

**→ [Full Results](results/clustering/analysis.md) | [Code](src/clustering/analysis.R) | [Visualizations](results/clustering/figures/)**

---

### 2️⃣ **NLP Sentiment Analysis**
*Lyric classification — what Taylor's songs are actually about*

- **Data:** Genius lyrics (147 songs, manually labeled 100 for validation)
- **Method:** NLP preprocessing + BERT emotion classifier + NRCLex
- **Finding:** Clear emotional arc: **Joy (early) → Sadness (mid/late)**
- **Output:** Emotion distributions by album, word frequency, model performance

**→ [Full Results](results/nlp/analysis.md) | [Notebook](src/nlp/analise_sentimentos.ipynb) | [Data](data/)**

---

## 🎯 Key Findings

| Aspect | Discovery |
|--------|-----------|
| **Audio Evolution** | Taylor shifted from sparse (early) → dense production (recent) |
| **Dominant Emotions** | Sadness peaks in Red/folklore/evermore; Joy peaks in early work |
| **Album Coherence** | Earlier albums unified style; recent albums intentionally diverse |
| **Cluster Sweet Spot** | k=4–5 clusters balance statistical separation + interpretability |
| **Lexical Themes** | "never," "know," "love," "like" across all eras; album-specific words mark themes |

**All findings:**
- **Clustering:** See `results/clustering/analysis.md`
- **NLP:** See `results/nlp/analysis.md`

---

## 🛠 Stack

```
R (Spotify + Clustering)
├── spotifyr (API auth + audio features)
├── ggplot2 (visualization)
├── factoextra + cluster (hierarchical + K-Means)
└── dplyr (data wrangling)

Python (NLP)
├── transformers (BERT)
├── nltk (tokenization, lemmatization)
├── scikit-learn (TF-IDF, evaluation)
└── pandas (data handling)

Version Control: Git + GitHub
Data: Open public sources only (Spotify, Genius, manual annotation)
```

---

## 📁 Repository Map

```
taylor-swift-analysis/
├── README.md                          ← You are here
│
├── src/
│   ├── clustering/analysis.R         ← Run this for cluster analysis
│   └── nlp/analise_sentimentos.ipynb ← Run this for NLP
│
├── results/
│   ├── clustering/
│   │   ├── analysis.md               ← FULL RESULTS (dendrograms, findings, interpretation)
│   │   └── figures/                  ← PNG visualizations
│   └── nlp/
│       ├── analysis.md               ← FULL RESULTS (emotion distributions, album profiles)
│       └── figures/
│
├── data/
│   ├── taylor_swift_genius_data.csv  ← 147 songs, 10 albums
│   ├── musicas_classificadas.csv     ← Manual labels (100 songs)
│   └── README.md                     ← Data access & setup
│
├── docs/
│   ├── clustering-methods.md         ← Technical deep-dive
│   └── nlp-methods.md                ← Technical deep-dive
│
└── reports/
    ├── clustering-article.pdf        ← Full research article
    └── canva-visualizations.md       ← Link to interactive presentation
```

---

## 🚀 Quick Start

### Run Clustering
```r
# Install packages first
install.packages(c("spotifyr", "dplyr", "ggplot2", "factoextra", "cluster"))

# Authenticate with Spotify (needs API credentials)
Sys.setenv(SPOTIFY_CLIENT_ID = 'YOUR_ID')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'YOUR_SECRET')

# Run analysis
source("src/clustering/analysis.R")
```

### Run NLP
```python
# Install packages
pip install transformers torch nltk pandas scikit-learn nrclex

# Run notebook
jupyter notebook src/nlp/analise_sentimentos.ipynb
```

---

## 📚 Methodology

### Clustering
- **Distance:** Euclidean (on normalized Spotify features)
- **Linkage:** Complete linkage (balanced sensitivity)
- **Validation:** Silhouette analysis, Dunn index, dendrograms
- **Selection:** k=4–5 (balance interpretation vs. statistical quality)

**→ [Technical details](docs/clustering-methods.md)**

### NLP
- **Preprocessing:** Tokenization → lemmatization → stopword removal → TF-IDF
- **Classification:** BERT (fine-tuned) + NRCLex (lexicon-based)
- **Validation:** 100 manually annotated songs + inter-model comparison

**→ [Technical details](docs/nlp-methods.md)**

---

## 💡 Interpretation

### What Taylor's Audio Tells Us
- **Early era (2006–2010):** Acoustic, singer-songwriter, lower energy
- **Pop transition (2014–2016):** Danceability ↑, acousticness ↓, production sophistication ↑
- **Introspective (2020+):** Lower energy, higher variety, experimental mixing

### What Taylor's Lyrics Tell Us
- **Early:** Romantic, discovering love ("beautiful," "smile," "dance")
- **Mid:** Confrontational, processing heartbreak ("never," "liar," "trouble")
- **Recent:** Reflective, self-aware ("time," "would," "know")

**Full interpretation:** See results/

---

## 🎬 How to Explore

1. **Start here:** This README (overview + navigation)
2. **Visual first:** [Canva interactive presentation](https://canva.link/38t4cvu6be8yynr)
3. **Results-focused:** [Clustering results](results/clustering/analysis.md) | [NLP results](results/nlp/analysis.md)
4. **Technical:** [Code](src/) | [Methods](docs/) | [Article](reports/clustering-article.pdf)
5. **Data:** [Get lyrics + labels](data/README.md)

---

## 📄 License

MIT — Free to use, modify, distribute with attribution.

---

## 🚧 This Is Growing

Future analyses planned:
- Time-series evolution of emotions across eras
- Collaborator impact on sound/themes
- Topic modeling of lyrical motifs
- Audio generation in Taylor's style

**Want to contribute?** Fork and submit a PR.

---

**Last updated:** 2024-09-09 | **Data version:** 1.0
