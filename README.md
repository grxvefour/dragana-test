# Dragana browser test

GitHub Pages test for Serbian RHVoice voice **Dragana**, built to WebAssembly from the browser POC by accessibility-luxembourg.

## Deploy
1. Create an empty GitHub repository.
2. Upload everything from this folder, including `.github/workflows/deploy.yml` and `patches/`.
3. Commit to `main`.
4. Repository **Settings → Pages → Build and deployment → Source: GitHub Actions**.
5. Open the Pages URL after the workflow finishes.

The first load downloads the Serbian language data and Dragana voice, then caches them in IndexedDB. No paid TTS API is used.
