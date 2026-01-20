# Start with the official LibreTranslate image
FROM libretranslate/libretranslate:latest

# Switch to root to ensure permissions for the install script
USER root

# --- PRE-DOWNLOAD MODELS (All models or selected models) ---
RUN ./venv/bin/python scripts/install_models.py
# RUN ./venv/bin/python scripts/install_models.py --load_only_lang_codes "sv,de,es,fr,pt,da,en"


# Switch back to the standard user
USER libretranslate

# --- CONFIGURATION ---
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000
ENV LT_UPDATE_MODELS=false

# Runtime Limit: Ensure the app only loads these into RAM
ENV LT_LOAD_ONLY="sv,de,es,fr,pt,da,en"

EXPOSE 5000
