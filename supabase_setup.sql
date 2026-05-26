-- ============================================================
-- SPA France — Schéma Supabase
-- À exécuter dans : Supabase > SQL Editor > New query
-- ============================================================

CREATE TABLE contact_logs (
  id              BIGSERIAL PRIMARY KEY,
  structure_id    INTEGER       NOT NULL,
  structure_nom   TEXT,
  agent_email     TEXT          NOT NULL,
  agent_nom       TEXT,
  contact_date    DATE          NOT NULL,
  contact_method  TEXT          NOT NULL
                  CHECK (contact_method IN ('email','telephone','visite','courrier','autre')),
  destinataire    TEXT,        -- email de la structure contactée
  sujet           TEXT,        -- objet de l'email
  corps_message   TEXT,        -- corps de l'email envoyé
  commentaire     TEXT,        -- note interne de l'agent
  email_envoye    BOOLEAN DEFAULT FALSE,
  created_at      TIMESTAMPTZ DEFAULT NOW()
);

CREATE INDEX idx_contact_logs_structure ON contact_logs (structure_id);
CREATE INDEX idx_contact_logs_agent     ON contact_logs (agent_email);
CREATE INDEX idx_contact_logs_date      ON contact_logs (contact_date DESC);

ALTER TABLE contact_logs ENABLE ROW LEVEL SECURITY;

CREATE POLICY "agents_full_access" ON contact_logs
  FOR ALL TO anon USING (true) WITH CHECK (true);
