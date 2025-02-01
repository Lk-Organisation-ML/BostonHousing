# Installer les packages nécessaires s'ils ne sont pas déjà installés
# if (!require(MASS)) install.packages("MASS", dependencies = TRUE)
# if (!require(ggplot2)) install.packages("ggplot2", dependencies = TRUE)
# if (!require(caret)) install.packages("caret", dependencies = TRUE)

# Charger les packages nécessaires
library(ggplot2)
library(dplyr)
library(MASS)
library(caret)

# Charger les données
data <- read.csv('../Data/BostonHousing.csv')

# Exploration initiale des données
print("head")
print(head(data)) #visualiser les données

print("\n Sumary")
print(summary(data)) #voir la description des donnée min max les equart interquatile , le moyenne la médiane

print("\n data")

print(str(data)) # voir dimension et type des variables 

# Gestion des valeurs manquantes
print(colSums(is.na(data))) #voir igne ou ils y a de valeur manquante 
data <- na.omit(data)  # Suppression des lignes contenant des valeurs manquantes (étant donnée valeur manquante minime)

# Détection et gestion des valeurs aberrantes (exemple pour CRIM)

# Affichage aptes gestion des valeurs aberrantes (exemple pour CRIM)


# Fonction pour générer un boxplot

creer_boxplot <- function(data, variable) {
  ggplot(data, aes(y = !!rlang::sym(variable))) +
    geom_boxplot() +
    ggtitle(paste('Boxplot de', variable))
}
# Exemple d'utilisation de la fonction
creer_boxplot(data, "CRIM")
creer_boxplot(data, "CHAS")
creer_boxplot(data, "RM")

# Suppression des valeurs aberrantes pour la colonne 'CRIM'
Q1 <- quantile(data$CRIM, 0.25)
Q3 <- quantile(data$CRIM, 0.75)
IQR <- Q3 - Q1
data <- data %>% filter(CRIM >= (Q1 - 1.5 * IQR) & CRIM <= (Q3 + 1.5 * IQR))


#  gestion des valeurs aberrantes
remove_outliers <- function(data, col_name) {
  # Calcul des quantiles et de l'IQR
  Q1 <- quantile(data[[col_name]], 0.25)
  Q3 <- quantile(data[[col_name]], 0.75)
  IQR <- Q3 - Q1
  
  # Filtrage des valeurs aberrantes
  data_filtered <- data %>%
    filter({{ col_name }} >= (Q1 - 1.5 * IQR) & {{ col_name }} <= (Q3 + 1.5 * IQR))
  
  return(data_filtered)
}

# Exemple d'utilisation : supprimer les outliers pour plusieurs colonnes
# Supposez que vous avez plusieurs colonnes pour lesquelles vous souhaitez supprimer les outliers

columns_to_filter <- c("CRIM", "CHAS", "RM")  # Liste des noms de colonnes

for (col in columns_to_filter) {
  data <- remove_outliers(data, col)
}


#+++++++++++++++ Partitionner les données en ensembles d'entraînement et de validation +

# Définir un seed pour la reproductibilité
+
set.seed(123)
n <- nrow(data)
train_indices <- sample(1:n, round(0.7*n), replace = FALSE)
boston_train <- data[train_indices, ]
boston_test <- data[-train_indices, ]
# Vérifier les dimensions des ensembles
dim(boston_train)
dim(boston_test)


#++++++++++++ Ajuster un modèle de régression linéaire multiple ++++++++
# Ajuster le modèle de régression linéaire multiple
model <- lm(MEDV ~ CRIM + CHAS + RM, data = boston_train)

# Afficher le résumé du modèle
summary(model)

# Équation du modèle : MEDV = intercept + coef(CRIM) * CRIM + coef(CHAS) * CHAS + coef(RM) * RM
coefficients(model)


#++++++++++Faire des prédictions avec le modèle ajusté+++++++++++

# Faire des prédictions sur le jeu de test
predictions <- predict(model, newdata = boston_test)

# Ajouter les prédictions au jeu de données de test
boston_test$Predicted_MEDV <- predictions

# Calculer l'erreur de prédiction
RMSE <- sqrt(mean((boston_test$MEDV - boston_test$Predicted_MEDV)^2))
RMSE


# Prédiction pour un secteur spécifique
new_data <- data.frame(CRIM = 0.1, CHAS = factor(0, levels = levels(boston_data$CHAS)), RM = 6)
predicted_value <- predict(model, newdata = new_data)
predicted_value



#+++++++Analyser les relations entre les prédicteurs++++++++

# Calculer la matrice de corrélation pour les prédicteurs numériques
cor_matrix <- cor(boston_data[,sapply(boston_data, is.numeric)])

# Afficher la matrice de corrélation
print(cor_matrix)

# Identifier les paires fortement corrélées (corrélation absolue > 0.7 par exemple)
high_corr <- findCorrelation(cor_matrix, cutoff = 0.7)
high_corr



# +++++Régression pas à pas++++++

# Définir le contrôle pour la régression pas à pas
control <- trainControl(method="cv", number=10)

# Régression pas à pas rétrograde
stepwise_model_backward <- train(MEDV ~ ., data = boston_train, method = "leapBackward", trControl = control)
stepwise_model_backward$finalModel

# Régression pas à pas progressive
stepwise_model_forward <- train(MEDV ~ ., data = boston_train, method = "leapForward", trControl = control)
stepwise_model_forward$finalModel

# Régression pas à pas bidirectionnelle
stepwise_model_both <- train(MEDV ~ ., data = boston_train, method = "leapSeq", trControl = control)
stepwise_model_both$finalModel

# Comparer les RMSE des modèles
predictions_backward <- predict(stepwise_model_backward, newdata = boston_test)
RMSE_backward <- sqrt(mean((boston_test$MEDV - predictions_backward)^2))

predictions_forward <- predict(stepwise_model_forward, newdata = boston_test)
RMSE_forward <- sqrt(mean((boston_test$MEDV - predictions_forward)^2))

predictions_both <- predict(stepwise_model_both, newdata = boston_test)
RMSE_both <- sqrt(mean((boston_test$MEDV - predictions_both)^2))

cat("RMSE Backward: ", RMSE_backward, "\n")
cat("RMSE Forward: ", RMSE_forward, "\n")
cat("RMSE Both: ", RMSE_both, "\n")
