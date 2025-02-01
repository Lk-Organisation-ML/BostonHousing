
# Installer les packages nécessaires (à exécuter une seule fois)
 install.packages('dplyr')
 install.packages('ggplot2')
 install.packages('caret')
 install.packages('ggcorrplot')

# Charger les packages nécessaires
library(dplyr)
library(ggplot2)
library(caret)
library(ggcorrplot)

# Charger les données
data <- read.csv('../Data/BostonHousing.csv')

# Exploration initiale des données
print(head(data))
print(summary(data))
print(str(data))

# Gestion des valeurs manquantes
print(colSums(is.na(data)))
data <- na.omit(data)  # Suppression des lignes contenant des valeurs manquantes

# Détection et gestion des valeurs aberrantes (exemple pour CRIM)
ggplot(data, aes(y = CRIM)) + 
  geom_boxplot() + 
  ggtitle('Boxplot de CRIM')

# Suppression des valeurs aberrantes pour la colonne 'CRIM'
Q1 <- quantile(data$CRIM, 0.25)
Q3 <- quantile(data$CRIM, 0.75)
IQR <- Q3 - Q1
data <- data %>% filter(CRIM >= (Q1 - 1.5 * IQR) & CRIM <= (Q3 + 1.5 * IQR))

# Transformation des données (normalisation des prédicteurs numériques)
numeric_vars <- c('CRIM', 'RM', 'LSTAT')
data[numeric_vars] <- scale(data[numeric_vars])

# Encodage des variables catégorielles
data$CHAS <- as.factor(data$CHAS)
data <- as.data.frame(model.matrix(~.-1, data = data))

# Création des ensembles d'entraînement et de validation
set.seed(1)
trainIndex <- createDataPartition(data$MEDV, p = 0.8, list = FALSE)
trainData <- data[trainIndex,]
valData <- data[-trainIndex,]

# Vérification des corrélations
corr_matrix <- cor(trainData)
ggcorrplot(corr_matrix, lab = TRUE)

# Sauvegarder les ensembles de données nettoyés
write.csv(trainData, '/home/bryan/Documents/cloud_cours/TP/trainData_clean.csv', row.names = FALSE)
write.csv(valData, '/home/bryan/Documents/cloud_cours/TP/valData_clean.csv', row.names = FALSE)

# Charger les données
data <- read.csv('/home/bryan/Documents/cloud_cours/TP/BostonHousing.csv')

# Exploration initiale des données
print(head(data))
print(summary(data))
print(str(data))

# Charger les données
data <- read.csv('/home/bryan/Documents/cloud_cours/TP/BostonHousing.csv')

# Installer et charger le package caret
install.packages('caret')
library(caret)

# Séparer les données en ensembles d'entraînement et de validation
set.seed(1)
trainIndex <- createDataPartition(data$MEDV, p = 0.8, list = FALSE)
trainData <- data[trainIndex,]
valData <- data[-trainIndex,]

# Afficher les dimensions des ensembles
cat("Dimensions de l'ensemble d'entraînement : ", dim(trainData), "\n")
cat("Dimensions de l'ensemble de validation : ", dim(valData), "\n")



# Installer les packages nécessaires (à exécuter une seule fois)
install.packages('dplyr')
install.packages('ggplot2')
install.packages('caret')
install.packages('ggcorrplot')

# Charger les packages nécessaires
library(dplyr)
library(ggplot2)
library(caret)
library(ggcorrplot)

# Charger les données
data <- read.csv('/home/bryan/Documents/cloud_cours/TP/BostonHousing.csv')

# Exploration initiale des données
print(head(data))
print(summary(data))
print(str(data))

# Gestion des valeurs manquantes
print(colSums(is.na(data)))
data <- na.omit(data)  # Suppression des lignes contenant des valeurs manquantes

# Détection et gestion des valeurs aberrantes (exemple pour CRIM)
ggplot(data, aes(y = CRIM)) + 
  geom_boxplot() + 
  ggtitle('Boxplot de CRIM')

# Suppression des valeurs aberrantes pour la colonne 'CRIM'
Q1 <- quantile(data$CRIM, 0.25)
Q3 <- quantile(data$CRIM, 0.75)
IQR <- Q3 - Q1
data <- data %>% filter(CRIM >= (Q1 - 1.5 * IQR) & CRIM <= (Q3 + 1.5 * IQR))

# Transformation des données (normalisation des prédicteurs numériques)
numeric_vars <- c('CRIM', 'RM', 'LSTAT')
data[numeric_vars] <- scale(data[numeric_vars])

# Encodage des variables catégorielles
data$CHAS <- as.factor(data$CHAS)
data <- as.data.frame(model.matrix(~.-1, data = data))

# Création des ensembles d'entraînement et de validation
set.seed(1)
trainIndex <- createDataPartition(data$MEDV, p = 0.8, list = FALSE)
trainData <- data[trainIndex,]
valData <- data[-trainIndex,]

# Vérification des corrélations
corr_matrix <- cor(trainData)
ggcorrplot(corr_matrix, lab = TRUE)

# Sauvegarder les ensembles de données nettoyés
write.csv(trainData, '/home/bryan/Documents/cloud_cours/TP/trainData_clean.csv', row.names = FALSE)
write.csv(valData, '/home/bryan/Documents/cloud_cours/TP/valData_clean.csv', row.names = FALSE)
