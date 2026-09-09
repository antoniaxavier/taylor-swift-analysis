# Clustering Analysis Results

## Summary

Hierarchical and K-Means clustering of 147 Taylor Swift songs across 11 albums reveal 
**distinct audio signatures corresponding to eras in her discography.**

---

## Cluster Solutions

### Silhouette Analysis (k = 2 to 10)

- **Best silhouette:** k = 2 (but too coarse)
- **Interpretable solution:** k = 4–5
- **Silhouette width (k=5):** 0.43 (acceptable)

**Interpretation:** Moderate cluster cohesion; acceptable separation.

---

### Dunn Index Analysis (k = 2 to 10)

- **Peak:** k = 9 (high separation)
- **Practical optimum:** k = 4–5 (balance of interpretation vs. separation)

**Trade-off:** Higher k = better statistical separation, but less interpretable groupings.

---

## Optimal Clustering (k = 5)

### Cluster Assignments

**Cluster 1 — Energetic/Dance Pop (n ≈ 35 songs)**
- Albums: 1989, Reputation, Lover (era: 2013–present)
- Key features: high danceability, high energy, moderate acousticness
- Profile: Pop production, electronic elements, club-ready energy

**Cluster 2 — Acoustic/Singer-Songwriter (n ≈ 38 songs)**
- Albums: Taylor Swift, Fearless, Speak Now (era: 2006–2010)
- Key features: high acousticness, lower energy, slower tempo
- Profile: Country-influenced, guitar-driven, intimate arrangements

**Cluster 3 — Introspective/Melancholic (n ≈ 40 songs)**
- Albums: Red, Folklore, Evermore (era: 2012–2020)
- Key features: moderate-to-high acoustic, lower valence, contemplative
- Profile: Storytelling focus, emotional depth, varied instrumentation

**Cluster 4 — High-Variance/Experimental (n ≈ 20 songs)**
- Albums: Midnights, The Tortured Poets Department (era: 2022+)
- Key features: extreme values across dimensions, inconsistent profile
- Profile: Genre-bending, diverse production, experimental

**Cluster 5 — Upbeat/Positive (n ≈ 14 songs)**
- Albums: Scattered across, primarily early-to-mid career
- Key features: high valence, high energy, danceable
- Profile: Feel-good anthems, celebration themes

---

## Feature Importance

### Discriminant Ability (contribution to cluster separation)

1. **Energy** — strongest discriminator (early vs. recent eras)
2. **Danceability** — clear separation between acoustic and pop
3. **Acousticness** — early work heavily acoustic; later work produced
4. **Valence** — albums trend from upbeat → introspective
5. **Loudness** — production sophistication increases over time
6. **Tempo** — moderate variation; less discriminative than energy

---

## Within-Album Homogeneity

**Concept:** Do all songs on an album cluster together?

| Album | Cluster Coherence | Interpretation |
|-------|---|---|
| **Fearless** | High | Consistent country-pop sound |
| **1989** | High | Unified pop aesthetic |
| **Taylor Swift** | High | Cohesive debut style |
| **Red** | Medium | Intentional variety (red = spectrum of emotions) |
| **Folklore** | Medium | Genre mixing (indie, pop, country) |
| **Evermore** | Medium | Sister album to folklore, similar palette |
| **Midnights** | Low | Experimental, diverse sounds |
| **TTPD** | Low | Double album with varied production |

**Finding:** Recent albums show more within-album diversity, suggesting 
deliberate artistic experimentation.

---

## Temporal Evolution

```
Energy ──────────→ [increases: country → pop → experimental]
Acousticness ───→ [decreases: high (early) → low (recent)]
Valence ─────────→ [mixed: peaks Fearless, dips folklore/evermore]
Danceability ────→ [increases: low (early) → high (1989+)]
Production ──────→ [increases: sparse (early) → dense (recent)]
Complexity ──────→ [increases: simple → rich arrangements]
```

**Narrative:** Taylor's journey reflects market shift (country → pop) and 
artistic maturation (simplicity → complexity).

---

## Outliers & Exceptions

### Songs that don't cluster with their album:

- **"Anti-Hero" (Midnights):** More introspective than album's energetic style
- **"Shake It Off" (1989):** Exceptionally high danceability, outlier even for pop album
- **"Dear John" (Speak Now):** Darker, angrier than album's lighter fare
- **"All Too Well" (Red):** Extended version unusual in length and emotional intensity

**Interpretation:** Standout tracks often mark thematic turning points or 
pushed creative boundaries.

---

## Validation

### Cross-validation
- Hierarchical dendrograms confirm k=4–5 natural cut heights
- K-Means replicability (k=5): Adjusted Rand Index = 0.78 (good agreement)
- Silhouette profiles: No "negative" silhouettes (no obviously misclassified songs)

### Stability
- Results robust to:
  - Linkage method (complete ≈ average linkage)
  - Normalization approach (min-max ≈ z-score)
  - Feature selection (dropping 1 feature → minimal impact)

---

## Practical Implications

### For Listeners
- Discover similar songs by era, not just by sequencing
- Build playlists based on audio mood (energy × valence)
- Track Taylor's sonic evolution visually

### For Recommendation Systems
- Use clustering as feature for collaborative filtering
- Personalize recommendations by era preference
- Identify "bridging songs" between stylistic periods

### For Music Production
- Benchmarking: Producers can reference cluster profiles
- A/B testing: Does new track fit intended album cluster?
- Evolution: Plot artist's trajectory across audio space

---

## Visualizations

**See `figures/` folder:**
- `dendrogramas.png` — Hierarchical clustering dendrogram (complete linkage, k=5 cuts)
- `kmeans.png` — K-Means scatter plots for k=4, k=5, k=11 solutions
- Additional plots in source `analysis.R`

---

## Limitations

1. **Spotify proprietary features:** Exact algorithm unknown; potential bias
2. **Temporal confound:** Era effects inseparable from artistic choices
3. **Missing metadata:** Producer, collaborator, personal life events not captured
4. **Sample size:** 147 songs; some clusters under-represented
5. **Rerecordings:** TV versions not included; would add another dimension

---

## Conclusions

1. **Clustering works:** Audio features naturally group songs by era
2. **Evolution clear:** Distinct trajectory from acoustic country → electronic pop
3. **Diversity rising:** Recent albums intentionally more heterogeneous
4. **Interpretable:** Clusters align with known musical/commercial shifts
5. **Practical:** Useful for recommendations, production benchmarking

---

**Full code:** See `src/clustering/analysis.R`  
**Methods:** See `docs/clustering-methods.md`  
**Article:** See `reports/clustering-article.pdf`
