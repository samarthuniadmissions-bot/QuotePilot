# QuotePilot

QuotePilot is a responsive procurement comparison prototype for turning supplier quotations into a clear shortlist. The current build is intentionally transparent: it runs in local demo mode with a fictional electrical-equipment dataset, while the UI and data model are ready for server-side extraction and persistence.

## What works immediately

- Marketing homepage, pricing, login, signup, dashboard, history, suppliers, settings, new-analysis workflow, and results routes.
- Sample quotation dataset with demo-only labels.
- Multi-step intake with validation, sample data loading, file add/remove, and comparison-factor selection.
- Searchable analysis history and searchable result table.
- Conditional recommendations, missing-cost warnings, specification mismatch notes, and item-detail feedback.
- Local persistence for saved demo analyses.
- Plain-text PDF/Excel export placeholders that can be replaced by server report generation.
- Responsive desktop/tablet/mobile layouts with mobile navigation.

## Run locally

```bash
npm install
npm run dev
```

The starter uses vinext. On Windows, if the `WRANGLER_LOG_PATH=...` npm script syntax is not recognized by the shell, run `npx vinext dev` or `npx vinext build` directly.

## Production integration points

The UI currently does not claim that uploaded files were analyzed by a live AI service. To connect production processing:

1. Add Supabase Auth or Sites identity enforcement for workspace membership.
2. Store source documents in private R2/Supabase Storage.
3. Add a server-side document extraction endpoint for PDF text/OCR and spreadsheets.
4. Send extracted content to a server-side model provider, validate structured JSON, and calculate totals deterministically.
5. Persist the entities in `db/schema.sql`, then replace the demo state in `app/quote-pilot.tsx` with API calls.
6. Generate real PDF and XLSX reports server-side and keep the disclaimer/source references in every report.

No API keys are required for the demo and no uploaded document is sent to an external service by this prototype.

## Demo trial policy

The local demo keeps a small browser-side trial ledger keyed by normalized email address. One email can create one demo workspace; a repeat attempt is sent to the pricing page. This is useful for evaluating the workflow, but it is not a security boundary because browser storage can be cleared. Production enforcement should move the ledger to a server-side `trial_entitlements` table keyed by verified user ID/email, with authentication and rate limiting.

## Data model

`db/schema.sql` contains the suggested workspace, analysis, supplier, quotation item, finding, and correction tables. Keep uploaded files private and scope every query to a workspace membership.
