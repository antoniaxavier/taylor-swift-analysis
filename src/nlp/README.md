# NLP Sentiment & Emotion Analysis

**Emotion classification of Taylor Swift's lyrics using BERT + lexicon-based methods**

---

## Overview

Multi-model NLP approach to classify emotions in 147 Taylor Swift song lyrics.

**Question:** What emotions dominate Taylor's discography, and how have they shifted over time?

**Answer:** Clear progression — Joy (early) → Sadness (mid/late), with recent introspection.

---

## Data

- **Source:** Genius API (public lyrics database)
- **Scope:** 147 songs, 10 albums (original versions)
- **Annotations:** 100 songs manually labeled for validation

---

## Emotions Detected

8 Plutchik basic emotions:
Joy, Sadness, Anger, Fear, Surprise, Disgust, Trust, Anticipation

---

## Methods (Simplified)

1. **Preprocess:** Tokenize → lowercase → remove stopwords → lemmatize
2. **Extract features:** TF-IDF vectorization
3. **Classify (two approaches):**
   - **NRCLex:** Word-list based (27,000 terms, NRC Canada lexicon)
   - **BERT:** Fine-tuned transformer (110M parameters, emotion corpus)
4. **Validate:** Compare with manual annotations (100 songs)

**Best model: BERT ensemble** (F1 = 0.64)

---

## Key Findings

✅ **Sadness dominates (28%)** — heartbreak/introspection theme

✅ **Era shift clear:**
- Early (2006–2010): Joy 40%, Anticipation 20%
- Mid (2012–2017): Sadness ↑, Anger ↑, Joy ↓
- Recent (2020+): Sadness 38%, Anticipation 30%

✅ **Album profiles distinct:**
- Fearless: upbeat (joy-driven)
- Red: emotional spectrum (all emotions present)
- folklore/evermore: introspective (sadness, contemplation)
- Midnights: anxiety-driven (anticipation, fear)

---

## Visualizations

Emotion distributions, album heatmaps, word clouds

See `results/nlp/figures/`

---

## Full Results & Interpretation

**→ [See `results/nlp/analysis.md`](../../results/nlp/analysis.md)**

(Detailed findings, album profiles, model comparison, limitations, future work)

---

## Code & Data

**Notebook:** `analise_sentimentos.ipynb` (Jupyter, fully reproducible)

**Data:**
- `data/taylor_swift_genius_data.csv` — 147 lyrics
- `data/musicas_classificadas.csv` — 100 manual emotion labels

**Setup:**
```bash
pip install transformers torch nltk pandas scikit-learn nrclex
jupyter notebook analise_sentimentos.ipynb
```

---

## Technical Methods

For in-depth NLP methodology (preprocessing, feature extraction, model architecture):

**→ [See `docs/nlp-methods.md`](../../docs/nlp-methods.md)**

---

## Challenges & Insights

**Models struggle with:**
- Sarcasm ("Better Than Revenge," "Shake It Off")
- Bittersweet emotions (sadness + joy simultaneously)
- Context from production (audio tone vs. lyrical sentiment)

**Solution:** Ensemble approach (BERT + NRCLex) captures more nuance

---

**Navigation:**
- [← Back to main](../../README.md)
- [Results](../../results/nlp/analysis.md)
- [Methods](../../docs/nlp-methods.md)
- [Data](../../data/README.md)
