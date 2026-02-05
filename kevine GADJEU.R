read.csv2("data_tidy/joueurs.csv") -> joueur
head(joueur)
dim(joueur)
library(tidyr)
joueur
library(tidyverse)
# 1. On supprime la première ligne (celle avec 'but', 'pasD'...)
joueur_propre <- joueur[-1, ] 

# 2. On convertit les colonnes en nombres pour pouvoir faire des stats
joueur_propre$Buts.marqués <- as.numeric(joueur_propre$Buts.marqués)
joueur_propre$Passes.décisives <- as.numeric(joueur_propre$Passes.décisives)
joueur_propre$Minutes.jouées <- as.numeric(joueur_propre$Minutes.jouées)

# 3. Maintenant, ton pivot va enfin marcher !
joueurs_wide <- joueur_propre %>%
  pivot_wider(names_from = X, values_from = Buts.marqués)
# On vérifie le résultat
View(joueurs_wide)
# Installation et chargement de la bibliothèque si nécessaire
if(!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# Création du graphique
ggplot(joueurs_wide, aes(x = Minutes.jouées, y = Passes.décisives)) +
  # Ajout des points
  geom_point(color = "steelblue", size = 3, alpha = 0.7) +
  # Ajout d'une ligne de tendance pour voir la moyenne de décisivité
  geom_smooth(method = "lm", se = FALSE, color = "red", linetype = "dashed") +
  # Titres et labels
  labs(title = "Décisivité des joueurs : Passes décisives vs Temps de jeu",
       x = "Minutes jouées",
       y = "Nombre de passes décisives",
       caption = "Source : Données joueurs_wide") +
  # Thème visuel propre
  theme_minimal()
# Installer et charger le tidyverse si ce n'est pas déjà fait
# install.packages("tidyverse")
library(tidyverse)

# Supposons que ton fichier est un CSV exporté à partir du tableau
# Remplace "ton_fichier.csv" par le vrai nom de ton fichier
df <- read.csv("/mnt/data/af496ed6-8169-4263-9327-8ff9f0e00c7a.csv")

# Vérifier les premières lignes
head(df)

# Graphe : Passes décisives en fonction du temps de jeu
ggplot(df, aes(x = Minutes.jouées, y = Passes.décisives)) +
  geom_point(color = "blue", size = 3) +            # points
  geom_smooth(method = "lm", se = FALSE, color = "red") +  # tendance linéaire
  labs(
    title = "Décisivité des joueurs selon le temps de jeu",
    x = "Minutes jouées",
    y = "Passes décisives"
  ) +
  theme_minimal()
library(ggplot2)
library(tidyverse)

# On s'assure que les colonnes sont bien numériques avant le graph
joueur_propre$Buts.marqués <- as.numeric(joueur_propre$Buts.marqués)
joueur_propre$Tirs.cadrés <- as.numeric(joueur_propre$Tirs.cadrés)

joueur_propre %>% 
  drop_na(Buts.marqués, Tirs.cadrés) %>% # Nettoyage des données vides
  ggplot() + 
  aes(
    x = Tirs.cadrés, 
    y = Buts.marqués, 
    color = Buts.marqués, # Couleur selon le succès
    fill = Buts.marqués
  ) + 
  
  # Couches (Layers)
  geom_point(size = 1.5) +  
  geom_smooth(method = "lm", size = 0.8, alpha = 0.2) + 
  geom_density2d(size = 0.3, alpha = 0.5) + 
  
  # Échelles (Scales)
  # On adapte les limites à tes données de foot (0 à 30 buts environ)
  scale_color_viridis_c(option = "plasma") + 
  scale_fill_viridis_c(option = "plasma") + 
  scale_x_continuous(limits = c(0, 110)) + # Max tirs environ 109 pour Balotelli
  scale_y_continuous(limits = c(0, 30)) +  # Max buts environ 28 pour Cavani
  
  # Étiquettes et Titres (Options)
  xlab("Précision (Tirs cadrés)") + 
  ylab("Finition (Buts marqués)") + 
  ggtitle("Analyse de la Performance Offensive", subtitle = "Adaptation du modèle Penguins") + 
  
  # Thème et Coordonnées
  coord_cartesian() + 
  theme_bw() +
  theme(aspect.ratio = 1/1.5)
