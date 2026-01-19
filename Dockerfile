# Start with the official LibreTranslate image
FROM libretranslate/libretranslate:latest

# Switch to root to ensure permissions for the install script
USER root

# --- PRE-DOWNLOAD MODELS ---
RUN ./venv/bin/python scripts/install_models.py

# Switch back to the standard user
USER libretranslate

# --- CONFIGURATION ---
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_UPDATE_MODELS=false

# Runtime Limit: Ensure the app only loads these into RAM
ENV LT_LOAD_ONLY="sv,de,es,fr,pt,da,en"

EXPOSE 5000