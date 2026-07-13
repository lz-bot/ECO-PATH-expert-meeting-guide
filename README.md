# ECO-PATH Expert Meeting Guide

This folder contains a standalone interactive HTML guide for targeted ECO-PATH expert meetings.

The guide is designed for the first round of expert consultation, with a narrow focus on pathway scoping before protocol-to-activity mapping. It supports separate meetings with:

- Joost Boormans, urology
- Peter Siersema, gastroenterology

## Contents

```text
public_site/
├── index.html
├── README.md
└── .nojekyll
```

`index.html` is self-contained. It includes the page layout, styles, interaction logic, multilingual text, local saving, and export functions.

## What the guide does

The guide helps capture clear expert answers on:

- recommended first pathway;
- start point;
- endpoint;
- main clinical steps;
- key branches or variants;
- general hospital versus UMC referral or transfer criteria;
- relevant protocols, workflow documents, timing for receiving documents, and validation contacts.

It supports English, Dutch, and Chinese views.

## Important limitation

This is an offline HTML file. Filled answers are saved only in the current browser through local storage. They do not automatically sync to the original HTML file or to other users.

To share meeting results, use one of the export options in the page:

- `Export notes`
- `Download .md`
- `Download filled HTML`

## GitHub Pages use

This folder can be used as the root of a small GitHub Pages repository.

Suggested setup:

```bash
cd public_site
git init
git branch -M main
git add index.html README.md .nojekyll .gitignore
git commit -m "Add ECO-PATH expert meeting guide"
```

Then create a GitHub repository and push:

```bash
git remote add origin https://github.com/<your-account>/<repo-name>.git
git push -u origin main
```

In GitHub, enable Pages from:

```text
Settings → Pages → Build and deployment → Deploy from branch → main / root
```

## Data protection note

Do not add patient-level data, identifiable clinical data, private emails, internal hospital documents, credentials, ecoinvent files, or local Brightway databases to this repository.

This public-site folder is intentionally separate from the broader ECO-PATH working directory to reduce the risk of publishing internal research materials.
