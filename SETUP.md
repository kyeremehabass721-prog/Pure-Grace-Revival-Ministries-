# Setup Guide — Pure-Grace Revival Ministries App

This gives you a **public site** (`index.html`) that shows only current/upcoming events and sermons, and a **private admin dashboard** (`admin.html`) where you and your leaders log in to add or remove them. Nothing is hardcoded — everything comes from a small free database (Supabase).

## 1. Create your Supabase project (5 min)
1. Go to https://supabase.com and sign up (free tier is enough).
2. Click **New Project**. Name it anything (e.g. `pure-grace-revival`). Set a database password and save it somewhere safe.
3. Wait ~2 minutes for it to finish setting up.

## 2. Create the database tables
1. In your Supabase project, open the **SQL Editor** (left sidebar).
2. Open the `schema.sql` file included here, copy all of it, paste it into the SQL Editor, and click **Run**.
3. This creates your `events` and `sermons` tables and locks them down so only logged-in leaders can add/edit/delete, while everyone can view.

## 3. Get your project keys
1. In Supabase, go to **Project Settings → API**.
2. Copy the **Project URL** and the **anon public key**.
3. Open `index.html` and `admin.html` in a text editor. Near the bottom of each, replace:
   ```js
   const SUPABASE_URL = "YOUR_SUPABASE_URL";
   const SUPABASE_ANON_KEY = "YOUR_SUPABASE_ANON_KEY";
   ```
   with your actual values, in **both files**.

## 4. Create leader logins
1. In Supabase, go to **Authentication → Users → Add User**.
2. Add an entry for yourself and each of your 2–3 leaders (their email + a temporary password). Turn on "Auto Confirm User" so they don't need to verify by email.
3. Share each leader's email/password with them privately. They can log in at `admin.html` and change their password later if you enable that (optional, ask if you want this added).

## 5. Publish to GitHub Pages
1. Replace your old `index.html` in the GitHub repo with the new one.
2. Add `admin.html` to the same repo.
3. Commit and push — GitHub Pages will update automatically.
4. Your dashboard will be live at `yoursite.com/admin.html`. You may want to avoid linking to it publicly (it's not listed in the nav) — only people with the URL and a leader login can reach it.

## How it behaves
- **Events**: only shows on the public site if their date is today or later. Past events quietly stop appearing — no manual deleting needed (though leaders can still delete them from the dashboard if they want a clean list).
- **Sermons**: shows the most recent 9 sermons whose date has already passed (so a sermon "goes live" on its date and stays as an archive).
- Everything starts **empty** — there are no sample/placeholder events or sermons. You and your leaders add your own from the dashboard.

## 6. Add PWA files (install-to-home-screen)
Your site is now installable as an app on iPhone and Android, using your church logo as the icon.

1. Add these new files/folders to the **same repo folder** as `index.html`:
   - `manifest.json`
   - `sw.js`
   - `icons/` (the whole folder — contains all icon sizes)
2. Push to GitHub. Your live URL is:
   `https://kyeremehabass721-prog.github.io/Pure-Grace-Revival-Ministries-/`
3. Open that link on a phone:
   - **Android (Chrome)**: a banner appears automatically at the bottom with an **Install** button — tapping it triggers the native install prompt.
   - **iPhone (Safari)**: a matching banner appears automatically; tapping **Install** opens a short instruction sheet ("Tap Share → Add to Home Screen → Add"), since iOS doesn't allow apps to trigger installs directly — Apple requires that manual step.
4. Once installed, the app opens full-screen (no browser bar), with your church logo as the home screen icon.

**Note:** the banner only shows over HTTPS (GitHub Pages already gives you this) and won't show again once dismissed or installed, on that device.

## Note on the rest of the site
Your existing About, Giving, and Contact sections (leadership, service times, location, giving verse) are untouched — only Sermons and Events were made dynamic.
