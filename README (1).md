# 🐾 SPA France — Carte Interactive des Structures d'Accueil

Application web pour les agents SPA : consultation de la carte, fiche de chaque structure, historique chronologique des contacts, envoi d'email.

---

## 📁 Fichiers du projet

```
spa-carte/
├── index.html           ← L'application complète
├── structures.geojson   ← Les 7 563 structures (données QGIS)
├── supabase_setup.sql   ← Script SQL à exécuter une fois
└── README.md            ← Ce fichier
```

---

## 🚀 Mise en ligne sur GitHub Pages (gratuit)

### Étape 1 — Créer le dépôt GitHub
1. Aller sur [github.com](https://github.com) et se connecter (ou créer un compte)
2. Cliquer **New repository**
3. Nom : `spa-carte` — visibilité : **Public**
4. Cliquer **Create repository**

### Étape 2 — Uploader les fichiers
1. Dans le dépôt créé, cliquer **uploading an existing file**
2. Glisser-déposer les 4 fichiers (`index.html`, `structures.geojson`, `supabase_setup.sql`, `README.md`)
3. Cliquer **Commit changes**

### Étape 3 — Activer GitHub Pages
1. Aller dans **Settings** → **Pages**
2. Source : **Deploy from a branch**
3. Branch : **main** / dossier : **/ (root)**
4. Cliquer **Save**
5. Après 1-2 minutes, l'URL sera : `https://VOTRE_NOM.github.io/spa-carte/`

---

## 🗄️ Configurer Supabase (historique des contacts)

> Sans cette étape, la carte et les fiches fonctionnent, mais l'historique des contacts est désactivé.

### Étape 1 — Créer un compte Supabase
1. Aller sur [supabase.com](https://supabase.com) → **Start for free**
2. Se connecter avec GitHub ou email
3. Cliquer **New project**
4. Nom : `spa-contacts`, mot de passe : choisir un mot de passe fort
5. Région : **West EU (Ireland)** (le plus proche de la France)
6. Attendre ~2 minutes que le projet se crée

### Étape 2 — Créer la table des contacts
1. Dans le menu gauche, cliquer **SQL Editor**
2. Cliquer **New query**
3. Copier-coller tout le contenu de `supabase_setup.sql`
4. Cliquer **Run** (▶️)
5. Message attendu : `Success. No rows returned`

### Étape 3 — Récupérer les clés API
1. Dans le menu gauche, cliquer **Settings** → **API**
2. Copier :
   - **Project URL** (ex: `https://abcdefgh.supabase.co`)
   - **anon / public key** (longue chaîne commençant par `eyJ...`)

### Étape 4 — Mettre à jour index.html
1. Ouvrir `index.html` dans un éditeur de texte (Notepad, VS Code…)
2. Trouver les lignes (vers le début du script) :
   ```js
   const SUPABASE_URL      = 'https://VOTRE_PROJET.supabase.co';
   const SUPABASE_ANON_KEY = 'VOTRE_CLE_ANON_ICI';
   ```
3. Remplacer par vos valeurs :
   ```js
   const SUPABASE_URL      = 'https://abcdefgh.supabase.co';
   const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...';
   ```
4. Sauvegarder et ré-uploader `index.html` sur GitHub

---

## 👤 Connexion des agents

Les agents se connectent avec leur adresse `@spa.com`.

- Email attendu : `prenom.nom@spa.com`
- Le prénom et nom sont automatiquement détectés depuis l'email
- La session est conservée dans le navigateur (pas besoin de se reconnecter à chaque fois)
- Chaque contact enregistré est associé à l'email de l'agent

> ⚠️ Il n'y a pas de vrai mot de passe — le système fait confiance aux agents pour utiliser leur propre email. Pour un accès plus sécurisé, il faudrait une authentification Supabase (évolution future possible).

---

## 📋 Fonctionnalités

| Fonctionnalité | Description |
|---|---|
| 🗺️ Carte interactive | 7 563 structures avec clustering automatique |
| 🔍 Recherche | Par nom, commune ou adresse |
| 🔽 Filtres | Par type de structure et par département |
| 📄 Fiche structure | Adresse, téléphone, email, site web, réseaux sociaux, scores |
| 📋 Historique contacts | Fiche chronologique par structure, visible par tous les agents |
| ✉️ Envoi email | Ouvre votre client mail avec les données pré-remplies + enregistre le contact |
| 👤 Identification agent | Email affiché dans chaque contact enregistré |

---

## 🔄 Mettre à jour les données

Quand votre fichier QGIS évolue :
1. Ré-exporter en GeoJSON depuis QGIS : `Clic droit sur la couche > Exporter > Enregistrer les entités sous... > GeoJSON, EPSG:4326`
2. Nommer le fichier `structures.geojson`
3. Ré-uploader sur GitHub en remplaçant l'ancien

---

## ❓ Support

En cas de problème, vérifier :
- Que `structures.geojson` est bien dans le même dossier que `index.html`
- Que les clés Supabase sont correctement copiées (sans espaces)
- Que la politique RLS Supabase a bien été créée (rerun le SQL)
