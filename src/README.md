# Projet d'UE Ouverture MU4IN511

Étude sur la compression d'arbre de décision en Zero-suppressed Decision Diagram (ZDD) en OCAML

# Compiling

Pour tout compiler et éxecuter:

`make runAll`

Pour compiler `main` et éxecuter:

`make runMain`

Pour compiler `experiment` et éxecuter:

`make runExperiment`

Pour utiliser l'interprèteur, il faut d'abord compiler et puis mettre les #load
en ligne `4-18` de `main.ml` et `experiment.ml`
hors de commentaires et exécuter le fichier avec `#use "main.ml"` ou `#use "experiment.ml"`

# Generate PNG

## Préquisites:

Sous Linux: \
`sudo apt-get install graphviz`\
Sous Mac: \
`brew install graphviz`

Pour générer les PNG à partir des fichiers dot, exécute:

`make png`

# Jupyter Notebook

## Préquisites:

Python 3

Packages: \
`pandas`\
`matplotlib`\
`seaborn`\
`spicy`

La partie Étude est codé en Python, ce qui trace des graphes à partir de \
`random.csv`\
`random2.csv`\
`random_updated.csv`
