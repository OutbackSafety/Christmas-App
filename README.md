# Roo's European Christmas — family itinerary app

Files
- index.html — the app (one page). manifest.webmanifest + sw.js make it installable and usable offline.
- config.js — Supabase URL + anon key (fill in once).
- schema.sql — run once in Supabase SQL Editor.
- hero.jpg, hero-small.jpg, icon-*.png — images.

Setup (one-off)
1. Supabase: New project (Sydney). Settings → API → copy Project URL and anon key into config.js.
2. Supabase: SQL Editor → paste schema.sql → Run.
3. GitHub: new repo `roo-xmas` (public), upload these files, Settings → Pages → Deploy from branch `main` / root.
4. Family link = https://<github-user>.github.io/roo-xmas/#t=<TRIP_ID>  (TRIP_ID = any UUID, generated once; keep it private).
5. On each Android phone: open the family link in Chrome → ⋮ menu → "Add to Home screen" / "Install app".

Optional: Android APK (Capacitor) built in Multipass — see APK.md.
