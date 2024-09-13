# Génération et Compression de Zero-Suppressed Binary Decision Diagrams (ZDD) en OCaml

Ce projet consiste à générer et compresser des diagrammes de décision binaires particuliers, appelés Zero-Suppressed Binary Decision Diagrams (ZDD), en utilisant le langage de programmation OCaml. Ce projet a été réalisé dans le cadre de l'UE d'Ouverture du Master 1 STL 2023/2024 à Sorbonne Université.

## Introduction

L'objectif de ce projet est de comparer les temps de génération des ZDD en utilisant différentes structures de données sous-jacentes. Les ZDD sont utilisés pour représenter des ensembles de manière compacte, particulièrement lorsque les ensembles contiennent de nombreux éléments nuls.

Article introductif au ZDD : [lien](https://people.eecs.berkeley.edu/~alanmi/publications/2001/tech01_zdd_.pdf)

## Fonctionnalités

- **Manipulation d'entiers 64 bits** : Utilisation du module `Int64` pour manipuler des entiers de grande précision.
- **Décomposition en bits** : Transformation d'entiers en listes de bits pour des opérations arithmétiques.
- **Construction d'arbres de décision** : Création d'arbres de décision binaires équilibrés à partir de tables de vérité.
- **Compression des arbres** : Compression des arbres de décision en ZDD en utilisant deux approches différentes (liste et arbre).
- **Visualisation des graphes** : Génération de fichiers `dot` pour la visualisation des arbres et ZDD avec Graphviz.

## Installation

Pour cloner et installer ce projet, assurez-vous d'avoir OCaml et OPAM installés sur votre machine.

```bash
# Cloner le dépôt
git clone https://github.com/td2thinh/ProjOuv.git

# Accéder au répertoire du projet
cd ProjOuv

# Installer les dépendances avec OPAM
opam install . --deps-only

# Construire le projet
dune build
```
