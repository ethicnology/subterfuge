#!/usr/bin/env sh

# LOCAL PREVIEW ONLY — this script no longer deploys to gh-pages.
#
# The canonical deployment of https://ethicnology.github.io/subterfuge/ is
# done exclusively by the `.github/workflows/deploy-web.yaml` CI workflow on
# every push to `main`. This guarantees that whatever is served was built
# from a specific, reviewable commit — not from a developer's local machine,
# which cannot be audited and could serve tampered code for an app that
# handles cryptographic secrets (mnemonics/seeds/shares).
#
# Use this script only to build and preview the web build locally.

# abort on errors
set -e

# build
flutter build web --release --base-href '/subterfuge/'

echo "Build ready in build/web/. Preview locally, e.g.:"
echo "  cd build/web && python3 -m http.server 8000"
