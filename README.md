# Finance

## Supabase Setup

1. Create a Supabase project.
2. In Supabase SQL Editor, run [supabase_setup.sql](/Users/ashutoshdubey/Documents/Finance/supabase_setup.sql).
3. In `Authentication` -> `Providers`, make sure `Email` sign-in is enabled.
4. Copy your `Project URL` and `Publishable / Anon key` from Supabase.
5. Open the dashboard, paste those values into the auth screen or Settings, then create your account.
6. Sign in with that same account on Chrome, Safari, and phone.

## What Syncs

- Dashboard data tabs
- Scanner history

## What Stays Local

- Angel One MPIN
- Anthropic API key

## Notes

- Sync is per account through Supabase Auth and RLS, not through a public spreadsheet URL.
- Cloud sync uses a single per-user snapshot row in `dashboard_snapshots`.
- If two devices edit at the same time, the latest completed sync wins.
