# Système Multi-Agent Maitresse, Bonbon et Salle de Classe

## Vue d'ensemble
Ce projet simule un environnement multi-agent où des agents interagissent dans un scénario de salle de classe. Les agents incluent un agent **Enseignant**, un agent **Bonbon**, et l'environnement **Salle de Classe**. L'objectif du système est de modéliser les interactions entre l'enseignant et les élèves en utilisant des bonbons comme récompenses, et de voir comment ces interactions influencent le comportement en classe.

Le projet utilise les concepts des systèmes multi-agents (MAS) pour simuler des processus de prise de décision et des interactions basées sur des agents dans un environnement de salle de classe.

## Composants
- **Agent Enseignant** : L'enseignant interagit avec les élèves en distribuant des bonbons comme récompenses pour de bons comportements ou de bonnes performances académiques.
- **Agent Bonbon** : L'agent bonbon gère le stock de bonbons disponibles, en suivant le nombre de bonbons à distribuer.
- **Environnement de Salle de Classe** : L'environnement où les agents interagissent. Il contient les élèves et permet à ces derniers d'effectuer des actions basées sur les retours de l'enseignant et la disponibilité des bonbons.
  
## Fonctionnalités
- Les agents communiquent entre eux pour simuler la gestion de la classe et l'attribution des récompenses.
- L'enseignant peut attribuer des bonbons aux élèves en fonction de leur comportement ou de leurs réussites académiques.
- Le système suit le nombre de bonbons dans la salle de classe et veille à leur distribution équitable.
- les élèves cherchent a voler des bonbons.
- Les élèves prennent des décisions en fonction des retours de l'enseignant et de la disponibilité des bonbons.

## Installation

### Prérequis
- Godot
- Bibliothèques requises (listées dans `requirements.txt`)

### Installation
1. Clonez le dépôt :
   ```bash
   git clone git@github.com:Mxckx9772/dos.git
   cd dos
