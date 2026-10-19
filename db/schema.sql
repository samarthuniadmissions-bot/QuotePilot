-- QuotePilot reference schema for Supabase/Postgres or D1-compatible adaptation.
create table if not exists profiles (id text primary key, full_name text, company_name text, created_at text default current_timestamp);
create table if not exists workspaces (id text primary key, name text not null, owner_id text not null, created_at text default current_timestamp);
create table if not exists workspace_members (id text primary key, workspace_id text not null, user_id text not null, role text not null default 'member');
create table if not exists suppliers (id text primary key, workspace_id text not null, name text not null, contact_email text, phone text, notes text, created_at text default current_timestamp);
create table if not exists analyses (id text primary key, workspace_id text not null, name text not null, category text, currency text default 'INR', status text not null default 'draft', created_by text, created_at text default current_timestamp, updated_at text default current_timestamp);
create table if not exists quotation_files (id text primary key, analysis_id text not null, supplier_id text, storage_path text not null, original_filename text not null, extraction_status text not null default 'pending', created_at text default current_timestamp);
create table if not exists quotation_items (id text primary key, analysis_id text not null, supplier_id text, item_description text not null, normalized_description text, quantity real, unit text, unit_price real, discount real, tax_amount real, freight_amount real, other_charges real, total_amount real, delivery_days integer, payment_terms text, warranty text, source_reference text, extraction_confidence real);
create table if not exists analysis_findings (id text primary key, analysis_id text not null, finding_type text not null, severity text not null, description text not null, supporting_evidence text, resolution_status text default 'open', created_at text default current_timestamp);
create table if not exists analysis_corrections (id text primary key, analysis_id text not null, quotation_item_id text, field_name text not null, original_value text, corrected_value text, corrected_by text, created_at text default current_timestamp);

-- Production note: enforce workspace membership in RLS/policies before exposing any table or storage bucket.
