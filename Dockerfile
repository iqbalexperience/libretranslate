# Start with the official LibreTranslate image
FROM libretranslate/libretranslate:latest

# Switch to root user temporarily to ensure we have write permissions during build
USER root

# --- PRE-DOWNLOAD MODELS ---
# This step downloads the models into the image itself.
# CUSTOMIZATION: Change the list "en,de,es..." to the languages you actually need.
# IMPORTANT: Keeping this list short keeps your build fast and image small.
# If you want ALL languages, remove the '--load_only_lang_codes' flag entirely.
RUN ./venv/bin/python scripts/install_models.py --load_only_lang_codes "en,ar,zh,fr,de,hi,it,ja,pt,ru,es"

# Switch back to the non-root user for security
USER libretranslate

# --- CONFIGURATION ---
# Set the host to 0.0.0.0 so Railway can reach the app
ENV LT_HOST=0.0.0.0
ENV LT_PORT=5000

# Disable auto-update on startup because we already downloaded them above
ENV LT_UPDATE_MODELS=false

# Expose the port
EXPOSE 5000