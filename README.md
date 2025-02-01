# Prédiction des Prix des Maisons à Boston

## Description du Projet
Ce projet vise à prédire les prix des maisons à Boston en utilisant des techniques de régression. Nous utilisons un jeu de données contenant plusieurs caractéristiques des maisons (superficie, nombre de pièces, taux de criminalité, etc.) pour estimer leur valeur marchande.

## Données
Le jeu de données utilisé est **Boston Housing Dataset**, qui contient les informations suivantes :
- **CRIM** : Taux de criminalité par ville
- **ZN** : Proportion de terrains réservés à des habitations de plus de 25 000 pieds carrés
- **INDUS** : Proportion de surfaces commerciales non résidentielles par ville
- **CHAS** : Variable fictive (1 si bord de rivière, 0 sinon)
- **NOX** : Concentration d'oxyde d'azote
- **RM** : Nombre moyen de pièces par logement
- **AGE** : Proportion de logements occupés depuis 1940
- **DIS** : Distance aux centres d'emplois
- **RAD** : Indice d'accessibilité aux autoroutes
- **TAX** : Taux d'imposition foncière
- **PTRATIO** : Ratio élèves/professeurs
- **B** : Proportion de population noire
- **LSTAT** : Pourcentage de la population avec un faible statut socio-économique
- **MEDV** : Prix médian des maisons (en milliers de dollars)

## Technologies Utilisées
- **Python 3**
- **Pandas & NumPy** (Manipulation des données)
- **Matplotlib & Seaborn** (Visualisation)
- **Scikit-Learn** (Modélisation et évaluation)

## Prétraitement des Données
1. Nettoyage des données (gestion des valeurs manquantes, duplication)
2. Analyse exploratoire (corrélations, histogrammes, boîtes à moustaches)
3. Normalisation des variables
4. Division en jeu d'entraînement (80%) et de test (20%)

## Modèles Utilisés
- **Régression Linéaire**


## Résultats
Les performances des modèles sont évaluées avec :
- **MSE** (Erreur Quadratique Moyenne)
- **R² Score** (Coefficient de détermination)

résultats :
```
Modèle              | MSE   | R² Score 
------------------  |-------|---------
Régression Linéaire | 22.7 | 0.69    
``` 

## Installation et Exécution
### 1. Cloner le repository
```bash
git clonehttps://github.com/Lk-Organisation-ML/BostonHousing
cd BostonHousing
```
### 2. Installer les dépendances
```bash
pip install -r requirements.txt
```
### 3. Exécuter le script principal
```bash
python main.py
```

## Améliorations Possibles
- Test d'autres modèles avancés (XGBoost, LightGBM)
- Ajout d'une interface utilisateur avec **Streamlit**
- Optimisation des hyperparamètres avec **GridSearchCV**

## Auteur
👤 **Bryan LEKE**  
📧 Contact : bryanlkcontact0@gmail.com  
🔗 GitHub : [github.com/Bryan-lk4]

---

📌 **Note** : Ce projet est réalisé à des fins éducatives pour explorer la régression et l'analyse de données.