---
  title: "multivariada"
output:
  pdf_document: default
html_document: default
date: "2024-11-12"
---
  
  # Pacotes 
  
library(spotifyr)
library(dplyr)
library(ggplot2)
library(car)
library(corrplot)
library(dplyr)
library(ggplot2)
#Dataframe
library(knitr)
library(DT)
#Data Manipulation
library(tidyverse)
library(dplyr)
library(tidyr)
#Data Viz
library(ggplot2)
library(GGally)
library(RColorBrewer)
library(viridis)
library(gridExtra)
library(ggdendro)
#K-Means
library(cluster)
library(factoextra)
library(fpc)
#disc 
library(heplots)
library(clusterSim)

# Obter e limpar os dados 

### Credenciais
# Get your own credentials from https://developer.spotify.com/dashboard

Sys.setenv(SPOTIFY_CLIENT_ID = 'YOUR_CLIENT_ID')
Sys.setenv(SPOTIFY_CLIENT_SECRET = 'YOUR_CLIENT_SECRET')
access_token <- get_spotify_access_token()


### Obtendo os dados 


ts <- get_artist_audio_features('taylor swift', include_groups =  c("album"))

glimpse(ts)


### Selecionando apenas algumas variáveis 

dados <- ts %>%
  dplyr::select(track_name,
                album_name,
                album_release_year,
                danceability,
                energy,
                key,
                loudness,
                mode,
                acousticness,
                valence,
                tempo,
                key_mode,
                duration_ms)



# as vezes eu baixo os dados e o álbum Taylor Swift [Deluxe]
#vem com esse nome e as vezes vem só como 'Taylor Swift'
dados <- dados %>%
  mutate(album_name = ifelse(album_name == "Taylor Swift (Deluxe Edition)",
                             "Taylor Swift", album_name))



### Selecionando apenas a versão mais recente de cada álbum 


ts_albuns <-  c("THE TORTURED POETS DEPARTMENT: THE ANTHOLOGY",
                "Midnights (The Til Dawn Edition)",
                "evermore (deluxe version)",
                "folklore (deluxe version)",
                "Lover",
                "reputation",
                "1989 (Taylor's Version) [Deluxe]",
                "Red (Taylor's Version)",
                "Speak Now (Taylor's Version)",
                "Fearless (Taylor's Version)",
                "Taylor Swift")



dados <-  dados %>% filter(album_name %in% ts_albuns)


### Renomeando o TTPD pq ele é mt longo 

dados <- dados %>%
  mutate(album_name = ifelse(album_name == "THE TORTURED POETS DEPARTMENT: THE ANTHOLOGY",
                             "TTPD: THE ANTHOLOGY", album_name))


### Transformando os álbuns em fatores e adicionando cores

album_colors <- c(
  "Taylor Swift" = "green",
  "Fearless (Taylor's Version)" = "gold",
  "Speak Now (Taylor's Version)" = "purple",
  "Red (Taylor's Version)" = "red",
  "1989 (Taylor's Version) [Deluxe]" = "skyblue",
  "reputation" = "black",
  "Lover" = "pink",
  "folklore (deluxe version)" = "grey70",
  "evermore (deluxe version)" = "brown",
  "Midnights (The Til Dawn Edition)" = "navy",
  "TTPD: THE ANTHOLOGY" = "beige"
)
dados <- dados %>%
  mutate(album_name = factor(album_name, levels = names(album_colors)),
         mode = as.factor(mode))

# Análise Exploratória 

### Gráficos de acusticidade 


ggplot(dados, aes(x = acousticness)) +
  geom_histogram(binwidth = 0.1, fill = "blue", color = "black", alpha = 0.7) +
  labs(x = "Acousticness", y = "Frequência", title = "Distribuição de Acousticness das Faixas") +
  theme_minimal()

###


ggplot(dados, aes(x = album_name, y = acousticness, fill = album_name)) +
  geom_violin() +
  scale_fill_manual(values = album_colors) +
  labs(x = "Álbum", y = "Acousticness", title = "Distribuição e Densidade de Acousticness por Álbum") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

### versão dos dados tirando variáveis descorrelacionadas 

dados_numericos <-  dados %>% dplyr::select(danceability,
                                            energy,
                                            key,
                                            loudness,
                                            acousticness,
                                            valence,
                                            tempo,
                                            duration_ms
)

# Normalizado com minmax
dados2 <- dados %>%
  mutate(
    loudness = (loudness - min(loudness)) / (max(loudness) - min(loudness)),
    tempo = scale(tempo, center = min(tempo), scale = max(tempo) - min(tempo)),
    duration_ms = scale(duration_ms, center = min(duration_ms), scale = max(duration_ms) - min(duration_ms))
  ) %>%
  dplyr::select(-c(key_mode, album_release_year, key)) %>%
  dplyr::select(track_name, album_name, danceability, valence, energy, loudness, acousticness, tempo, duration_ms)




### Densidade conjunta das variáveis normalizadas 


ggplot(dados2) +
  geom_density(aes(energy, fill ="energy", alpha = 0.1)) +
  geom_density(aes(danceability, fill ="danceability", alpha = 0.1)) +
  geom_density(aes(valence, fill ="valence", alpha = 0.1)) +
  geom_density(aes(acousticness, fill ="acousticness", alpha = 0.1)) +
  geom_density(aes(loudness, fill ="loudness", alpha = 0.1)) +
  scale_x_continuous(name = "Energy, Danceability, Valence, Acousticness, Loudness") +
  scale_y_continuous(name = "Density") +
  ggtitle("Density plot of Energy, Danceability, Valence, Acousticness, and Loudness") +
  theme_bw() +
  theme(plot.title = element_text(size = 10, face = "bold", colour = "#1DB954"),
        text = element_text(size = 10)) +
  theme(legend.title=element_blank()) +
  scale_fill_brewer(palette="Accent")


### Boxplot
# valencia 

ggplot(dados2, aes(x = album_name, y = valence, fill = album_name)) +
  geom_boxplot() +
  scale_fill_manual(values = album_colors) +
  labs(x = "Álbum", y = "Valência") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# energia

ggplot(dados2, aes(x = album_name, y = energy, fill = album_name)) +
  geom_boxplot() +
  scale_fill_manual(values = album_colors) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Nome do Álbum", y = "Energia") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# dançabilidade

ggplot(dados2, aes(x = album_name, y = danceability, fill = album_name)) +
  geom_boxplot() +
  scale_fill_manual(values = album_colors) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Nome do Álbum", y = "dançabilidade") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

###

ggplot(dados2, aes(x = album_name, y = loudness, fill = album_name)) +
  geom_boxplot() +
  scale_fill_manual(values = album_colors) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Nome do Álbum", y = "Volume") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

##

ggplot(dados2, aes(x = album_name, y = tempo, fill = album_name)) +
  geom_boxplot() +
  scale_fill_manual(values = album_colors) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Nome do Álbum", y = "Tempo") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
###


###

ggplot(dados2, aes(x = album_name, y = acousticness, fill = album_name)) +
  geom_boxplot() +
  scale_fill_manual(values = album_colors) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  labs(x = "Nome do Álbum", y = "Acusticidade") +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

## boxplot tudo

# se nao for foi pq o library(tidyr) nao carregou la em cima (nao sei pq as vezes ele pula no meu pc)

dados_long <- dados2 %>%
  pivot_longer(cols = 3:9, names_to = "Variável", values_to = "Valor")

ggplot(dados_long, aes(x = Variável, y = Valor, fill = Variável)) +
  geom_boxplot(outlier.shape = 16, outlier.size = 1) +
  scale_fill_brewer(palette = "Set3") + 
  theme_minimal() + 
  theme(
    legend.position = "none", 
    axis.text.x = element_text(angle = 45, hjust = 1) 
  ) +
  labs(
    title = "Distribuição das Variáveis Selecionadas",
    x = "Variável",
    y = "Valor"
  )


#### Correlação 

ggcorr(dados2, 
       use = "pearson",
       low = "blue3", 
       high = "red", label = TRUE) + 
  ggtitle("Correlation Plot (Pearson)") + 
  theme(plot.title = element_text(hjust = 0.5))



```
# Definindo o numero de clusters 

### Distância

dm<-dist(dados2[,3:9],upper=T)
glimpse(dm)


### Dendogramas


### Dendrogramas por diferentes tipo de ligação 
par(mfrow=c(1,3))
plot(cs <- hclust(dm, method = "single"))
plot(cc <- hclust(dm, method = "complete"))
plot(ca <- hclust(dm, method = "average"))




par(mfrow=c(1,2))
plot(centroide <- hclust(dm,method = 'centroid'))
plot(ward <- hclust(dm,method = 'ward.D'))


# preferi a ligação completa 

ca <- hclust(dm, method= "complete")

plot(ca, labels = dados2$track_name, cex = 0.7)  # Ajuste 'cex' para controlar o tamanho da fonte


# Plotando o dendrograma com o factoextra
fviz_dend(ca, 
          k = 5,                 # Número de clusters para colorir
          cex = 0.5,             
          k_colors = "ucscgb",      # Paleta de cores
          color_labels_by_k = TRUE,  # Colorir rótulos de acordo com o cluster
          rect = TRUE,           # Desenhar retângulos ao redor dos clusters
          rect_fill = TRUE,      # Preencher retângulos com cor
          rect_border = "ucscgb",   # Cor da borda dos retângulos
          lwd = 0.2,              # Espessura das linhas
          main= "Dendrograma com 5 clusters"
          
) + theme_minimal()              # Tema minimalista para um visual limpo



### Gráfico passo x distancia 




k  = 11 (numero de albuns da taylor)

plot(ca)
rect.hclust(cc, k = 11, border = 2:5)


# Plotando o dendrograma com o factoextra
fviz_dend(ca, 
          k = 11,                 # Número de clusters para colorir
          cex = 0.5,             # Tamanho do texto das labels
          k_colors = "simpsons",      # Paleta de cores
          color_labels_by_k = TRUE,  # Colorir rótulos de acordo com o cluster
          rect = TRUE,           # Desenhar retângulos ao redor dos clusters
          rect_fill = TRUE,      # Preencher retângulos com cor
          rect_border = "simpsons",   # Cor da borda dos retângulos
          lwd = 0.2,              # Espessura das linhas
          main= "Dendrograma com 11 clusters"
          
) + theme_minimal()    


### Gráfico do cotovelo

# Calcular WSS
wss <- numeric(12)  # Armazena os valores de WSS para diferentes valores de k
for (k in 1:12) {
  clusters <- cutree(ca, k)
  wss[k] <- sum(sapply(1:k, function(i) {
    sum(dist(dados[clusters == i, ])^2)
  }))
}

# Calcular a segunda diferença
second_diff <- diff(diff(wss))
cotovelo <- which.min(second_diff) + 1  # +1 ajusta para o índice correto

# Plot do gráfico do cotovelo com indicação visual do ponto
plot(1:12, wss, type = "b", pch = 19, frame = FALSE, 
     xlab = "Número de clusters", ylab = "Soma das distâncias dentro do cluster (WSS)")
abline(v = cotovelo, col = "red", lty = 2, lwd = 2)  # Linha vertical no ponto do cotovelo
text(cotovelo, wss[cotovelo], labels = paste("Cotovelo, k =", cotovelo), pos = 4, col = "red")

```

# Silhueta 



sil_width <- numeric(10)
for (k in 2:10) {
  clusters <- cutree(ca, k)
  sil_width[k] <- mean(silhouette(clusters, dist(dados))[, 3])
}

# Plotando o índice de silhueta
plot(2:10, sil_width[2:10], type = "b", pch = 19, frame = FALSE,
     xlab = "Número de clusters", ylab = "Índice de Silhueta")

O que maximiza é k = 2 



dunn_index <- numeric(10)
for (k in 2:10) {
  clusters <- cutree(ca, k)
  dunn_index[k] <- cluster.stats(dist(dados), clusters)$dunn
}

# Plotando o índice de Dunn (sei la o que é isso)
plot(2:10, dunn_index[2:10], type = "b", pch = 19, frame = FALSE,
     xlab = "Número de clusters", ylab = "Índice de Dunn")


# O índice de Dunn é uma medida que tenta identificar clusters bem separados. 
# O maior valor do índice de Dunn geralmente indica a melhor separação entre os clusters. 

k = 9 




# Agrupamento por método não hierarquico (K-Means)


#### k = 4 

## Método não-hierárquico
cluster4<-kmeans(dados2[,3:9],centers=4)
cluster4

# Médias por grupos
cluster4$centers

# Soma dos quadrados dentro dos grupos
cluster4$withinss

# Soma total dos quadrados dentro dos grupos
cluster4$tot.withinss

# Tamanho dos grupos
cluster4$size

# Entre grupos
round(cluster4$betweenss,2)

# SST

cluster4$totss


#### k = 5

## Método não-hierárquico
cluster5<-kmeans(dados2[,3:9],centers=5)
cluster5

# Médias por grupos
cluster5$centers

# Soma dos quadrados dentro dos grupos
cluster5$withinss

# Soma total dos quadrados dentro dos grupos
cluster5$tot.withinss

# Tamanho dos grupos
cluster5$size

# SST

cluster5$totss

# Entre grupos
round(cluster5$betweenss,2)

##### k = 11

## Método não-hierárquico
cluster11<-kmeans(dados2[,3:9],centers=11)
cluster11

# Médias por grupos
cluster11$centers

# Soma dos quadrados dentro dos grupos
cluster11$withinss

# Soma total dos quadrados dentro dos grupos
cluster11$tot.withinss

# Tamanho dos grupos
cluster11$size

round(cluster11$betweenss,2)


#### gráficos 


par(mfrow=c(1,3))

fviz_cluster(cluster4, 
             geom = c("point"),        # Apenas pontos
             data = dados2[,3:9],         # Use apenas dados numéricos
             palette = "Set1", 
             main = "K Means Clustering with 4 Centers", 
             alpha = 0.9) + 
  geom_text(aes(label = dados$track_name), # Adiciona os rótulos (nomes das músicas)
            color = "black",              # Cor do texto
            size = 3,                    # Tamanho do texto
            check_overlap = TRUE) +      # Evita sobreposição de texto
  theme(plot.title = element_text(hjust = 0.5))


fviz_cluster(cluster5, 
             geom = c("point"),        # Apenas pontos
             data = dados2[,3:9],         # Use apenas dados numéricos
             palette = "Set1", 
             main = "K Means Clustering with 5 Centers", 
             alpha = 0.9) + 
  geom_text(aes(label = dados$track_name), # Adiciona os rótulos (nomes das músicas)
            color = "black",              # Cor do texto
            size = 3,                    # Tamanho do texto
            check_overlap = TRUE) +      # Evita sobreposição de texto
  theme(plot.title = element_text(hjust = 0.5))


fviz_cluster(cluster11, 
             geom = c("point"),        # Apenas pontos
             data = dados2[,3:9],         # Use apenas dados numéricos
             palette = "Set3", 
             main = "K Means Clustering with 11 Centers", 
             alpha = 0.9) + 
  geom_text(aes(label = dados$track_name), # Adiciona os rótulos (nomes das músicas)
            color = "black",              # Cor do texto
            size = 3,                    # Tamanho do texto
            check_overlap = TRUE) +      # Evita sobreposição de texto
  theme(plot.title = element_text(hjust = 0.5))

dados2$cluster4 <-  as.factor(cluster4$cluster)
dados2$cluster5 <-  as.factor(cluster5$cluster)
dados2$cluster11 <-  as.factor(cluster11$cluster)


### plot


kmedias = kmeans(dados2[,3:9], centers = 5,algorithm = "MacQueen")
kmedias
plot(dados2[,3:9], col = kmedias$cluster, pch = 19)

### silhueta e csm


silhueta_4 =  silhouette(cluster4$cluster,dm)
plot(silhueta_4, col = 2:5) #silhueta para cada cluster
(silh_media_grupo_k = tapply(silhueta_4[ ,3],
                             kmedias$cluster,
                             mean))
CSM_4 = mean(silhueta_4[, 3])

CSM_4



silhueta_5 =  silhouette(cluster5$cluster,dm)
plot(silhueta_5, col = 2:5) #silhueta para cada cluster
(silh_media_grupo_k = tapply(silhueta_5[ ,3],
                             kmedias$cluster,
                             mean))
CSM_5 = mean(silhueta_5[, 3])

CSM_5

#write.csv(dados2, "clusters.csv")

# 4 ficou melhor q o 5



