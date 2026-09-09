# NLP Sentiment & Emotion Analysis Results

## Summary

Classification of 147 Taylor Swift song lyrics into 8 emotions (Plutchik) reveals 
**systematic emotional progression across eras, with sadness as dominant theme.**

---

## Emotion Distribution

### Overall Corpus (n = 100 manually annotated)

```
Sadness       28    ████████████████████████░░░  28%
Joy           19    ███████████████░░░░░░░░░░░░░░ 19%
Anticipation  17    ████████████░░░░░░░░░░░░░░░░░ 17%
Anger         12    █████████░░░░░░░░░░░░░░░░░░░  12%
Disgust        9    ███████░░░░░░░░░░░░░░░░░░░░░░  9%
Fear           8    ██████░░░░░░░░░░░░░░░░░░░░░░░  8%
Trust          4    ███░░░░░░░░░░░░░░░░░░░░░░░░░░  4%
Surprise       3    ██░░░░░░░░░░░░░░░░░░░░░░░░░░░  3%
```

**Key finding:** Melancholic theme (Sadness + Fear + Anger = 48%)

---

## Album-by-Album Emotion Profiles

### Early Era (2006–2010)

#### Taylor Swift (2006)
- **Dominant:** Joy (40%), Anticipation (20%)
- **Theme:** Youthful, romantic, discovery
- **Sample lyrics:** "Tim McGraw," "Our Song," "Invisible"
- **Interpretation:** First album exuberance; wide-eyed about love

#### Fearless (2008)
- **Dominant:** Joy (38%), Anticipation (23%)
- **Theme:** Fearless love despite consequences
- **Sample lyrics:** "Love Story," "White Horse"
- **Interpretation:** Confidence, risk-taking, still hopeful

#### Speak Now (2010)
- **Dominant:** Anger (25%), Disgust (20%), Anticipation (18%)
- **Theme:** Betrayal, confrontation, speaking truth
- **Sample lyrics:** "Dear John," "Better Than Revenge"
- **Interpretation:** Shift from naïve to confrontational; calling out behavior

---

### Transitional Era (2012–2017)

#### Red (2012)
- **Dominant:** Sadness (45%), Anger (20%), Fear (15%)
- **Theme:** Love as spectrum (red = all colors of emotion)
- **Sample lyrics:** "All Too Well," "We Are Never Ever Getting Back Together"
- **Interpretation:** Emotional complexity; raw heartbreak

#### 1989 (2014)
- **Dominant:** Joy (42%), Anticipation (22%), Trust (18%)
- **Theme:** Embrace of pop, reinvention, city life
- **Sample lyrics:** "Shake It Off," "Style"
- **Interpretation:** Rebirth narrative; confident pop persona

#### Reputation (2016)
- **Dominant:** Anger (35%), Disgust (30%), Fear (18%)
- **Theme:** Responding to criticism, armor-building
- **Sample lyrics:** "Look What You Made Me Do," "The Story of Us"
- **Interpretation:** Defensive, confrontational response to media scrutiny

---

### Introspective Era (2020+)

#### Folklore (2020)
- **Dominant:** Sadness (40%), Anticipation (25%), Fear (15%)
- **Theme:** Storytelling, nostalgia, introspection
- **Sample lyrics:** "cardigan," "august," "illicit affairs"
- **Interpretation:** Retreat from public narrative; narrative-driven

#### Evermore (2020)
- **Dominant:** Sadness (38%), Disgust (22%), Anticipation (20%)
- **Theme:** Sister to folklore; continued storytelling
- **Sample lyrics:** "willow," "'tis the damn season"
- **Interpretation:** Same introspective mode; sustained contemplation

#### Midnights (2022)
- **Dominant:** Anticipation (30%), Sadness (28%), Fear (18%)
- **Theme:** Sleep-deprived reflection, obsession, circular thinking
- **Sample lyrics:** "Anti-Hero," "Mastermind"
- **Interpretation:** Anxiety-driven; theme of (un)sleeping mind

---

## Temporal Trends

### Emotion Trajectory Across Albums

```
JOY      ▲▲▲ (early)   → ● (mid)   → ▼▼ (late)   [trend: declining]
SADNESS  ▼ (early)    → ▲▲ (mid)  → ▲▲▲ (late)  [trend: increasing]
ANGER    ▼▼ (early)   → ▲▲ (mid)  → ●● (late)   [trend: stable-declining]
FEAR     ▼ (early)    → ▲ (mid)   → ▲▲ (late)   [trend: increasing]
TRUST    ▲ (early)    → ● (mid)   → ▼ (late)    [trend: declining]
```

**Narrative:** Shift from youthful optimism → mature heartbreak → introspective vulnerability

---

## Lexical Analysis

### Most Frequent Words by Emotion

**Sadness:**
- goodbye, broken, lost, cry, tears, rain, alone, leaving
- Context: Relationship endings, self-reflection

**Joy:**
- love, beautiful, smile, dance, shine, happy, night, stars
- Context: Romance, celebration, positive moments

**Anger:**
- liar, trouble, revenge, mistake, regret, hate, bad
- Context: Confrontation, betrayal, calling out

**Fear:**
- scared, afraid, running, falling, drowning, broken
- Context: Anxiety, loss, vulnerability

---

## Model Performance

### NRCLex (Lexicon-Based)

| Metric | Value |
|--------|-------|
| Accuracy | 0.19 |
| F1-score (macro) | 0.194 |
| Interpretability | High |

**Assessment:** Baseline method; low accuracy due to word-overlap and sarcasm issues

### BERT (Neural)

| Metric | Value |
|--------|-------|
| Accuracy | 0.64–0.65 (benchmark) |
| F1-score | 0.641 |
| Interpretability | Medium |

**Assessment:** Solid performance; captures context and nuance NRCLex misses

### Ensemble Approach

**Recommendation:** Combine NRCLex (interpretability) + BERT (accuracy)
- Use BERT primary label (confidence threshold = 0.7)
- Fall back to NRCLex when BERT uncertain
- Manual review for edge cases (sarcasm, irony)

---

## Misclassifications & Challenges

### High-Error Cases

**Example 1: "Better Than Revenge"**
- Manual label: Disgust
- BERT prediction: Anger
- NRCLex: Anger
- Issue: Sarcasm ("she's better than me"), aggressive delivery
- Fix: Context + audio tone needed

**Example 2: "Anti-Hero"**
- Manual label: Fear
- BERT prediction: Sadness
- NRCLex: Trust (due to "light" words)
- Issue: Self-critical (emotion about self), not other-directed
- Fix: Domain adaptation for introspective vs. relational emotions

**Example 3: "Cruel Summer"**
- Manual label: Joy (despite dark lyrics)
- BERT prediction: Sadness
- NRCLex: Sadness
- Issue: Production/tone contradicts lyrics; bittersweet
- Fix: Multi-label classification (joy + fear simultaneously)

---

## Key Findings

1. **Emotional arc is clear:** Joy → Sadness (with anger/disgust peaks)
2. **Album > song?:** Album themes dominate; tracks usually fit album emotion
3. **Lyrical consistency:** Manual annotation ≈ automated classification (ensemble)
4. **Sarcasm problematic:** Models struggle with intentional emotional misdirection
5. **Production matters:** Audio tone often contradicts lyrical sentiment

---

## Implications

### For Music Analysis
- Emotions in lyrics ≠ emotions expressed via production
- Taylor's music increasingly lyrics-driven (early) vs. sound-driven (recent)
- Introspective eras require multi-label classification

### For Fan Understanding
- Album themes are deliberate (not accidental clustering)
- Personal life events map onto emotional content
- Rerecordings may carry different emotional weight (vocal maturity)

### For NLP
- Sarcasm detection remains unsolved (especially in creative writing)
- Domain adaptation needed for music (non-standard language, metaphor)
- Audio-text fusion better than text alone for full emotion capture

---

## Limitations

1. **Single annotator bias:** Only one person (author) labeled 100 songs
2. **Culture-specific:** English-language models; may miss non-English wordplay
3. **Sarcasm/irony:** Models systematically misclassify intentional misdirection
4. **Rerecordings:** No Taylor's Versions (vocal differences may shift emotion)
5. **Album intent:** Known themes (Red, folklore) may bias classification
6. **Multi-emotions:** Songs often express multiple emotions; single label insufficient

---

## Future Work

- [ ] **Multi-label classification:** Allow joy + anticipation simultaneously
- [ ] **Aspect-based:** Emotion tied to lyrical topics (love, loss, growth, etc.)
- [ ] **Audio-text fusion:** Combine sentiment with production features
- [ ] **Temporal:** Track emotion progression within songs (verse → chorus)
- [ ] **Comparison:** Analyze other artists; is Taylor uniquely introspective?
- [ ] **Validation:** Add human annotators; compute inter-rater agreement

---

## Code & Reproducibility

**Main analysis:** `src/nlp/analise_sentimentos.ipynb`

**Key steps:**
1. Load lyrics from Genius
2. Preprocess (tokenize, lemmatize, remove stopwords)
3. TF-IDF vectorization
4. NRCLex emotion detection
5. BERT classification
6. Merge with manual annotations
7. Analysis & visualization

**Runtime:** ~5–10 minutes (depending on API rate limits)

---

**Methods:** See `docs/nlp-methods.md`  
**Full notebook:** See `src/nlp/analise_sentimentos.ipynb`
