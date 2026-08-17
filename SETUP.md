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

## What changed vs. your original file
Everything — nav, hero, About, Giving, Contact, footer — is exactly as you had it. Only two sections became dynamic:
- **Sermons**: previously 3 hardcoded cards, now pulled live from the `sermons` table.
- **Events**: previously 4 hardcoded entries, now pulled live from the `events` table, filtered to today-and-later.

Both start empty until you add entries from `admin.html`.
