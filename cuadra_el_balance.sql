-- =====================================================================
--  CUADRA EL BALANCE · Base de datos (Supabase / PostgreSQL)
-- ---------------------------------------------------------------------
--  Una sola tabla: guarda el nombre del jugador y su puntuación.
--  El ranking se calcula ordenando por puntuación (mayor a menor).
--
--  Cómo usarlo: Supabase → SQL Editor → New query → pegar todo → Run.
-- =====================================================================

create table if not exists public.ranking (
  id          bigint generated always as identity primary key,
  nombre      text        not null check (char_length(trim(nombre)) between 1 and 15),
  puntuacion  integer     not null check (puntuacion between 0 and 10000000),
  creado_en   timestamptz not null default now()
);

-- Índice para que el ranking cargue rápido
create index if not exists ranking_puntuacion_idx
  on public.ranking (puntuacion desc, creado_en asc);

-- Seguridad: el público solo puede LEER el ranking e INSERTAR puntajes.
-- No puede modificar ni borrar registros.
alter table public.ranking enable row level security;

drop policy if exists "ranking_leer" on public.ranking;
create policy "ranking_leer"
  on public.ranking for select
  to anon, authenticated
  using (true);

drop policy if exists "ranking_insertar" on public.ranking;
create policy "ranking_insertar"
  on public.ranking for insert
  to anon, authenticated
  with check (
    char_length(trim(nombre)) between 1 and 15
    and puntuacion between 0 and 10000000
  );

grant select, insert on public.ranking to anon, authenticated;

-- ---------------------------------------------------------------------
--  Consulta de ranking (para verlo desde el SQL Editor):
--
--  select rank() over (order by puntuacion desc) as puesto,
--         nombre, puntuacion, creado_en
--  from public.ranking
--  order by puntuacion desc, creado_en asc
--  limit 10;
-- ---------------------------------------------------------------------
