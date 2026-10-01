// =====================================================================
//  CUADRA EL BALANCE · Configuración
// ---------------------------------------------------------------------
//  1. En Supabase: Project Settings → API (o "API Keys").
//  2. Copia la "Project URL" y la llave pública (anon / publishable).
//  3. Pégalas abajo. NUNCA pongas aquí la service_role / secret key.
//
//  La llave anon/publishable es pública por diseño: la seguridad la
//  da Row Level Security (ver cuadra_el_balance.sql), que solo permite
//  leer el ranking e insertar puntajes nuevos.
//
//  Si dejas los valores de ejemplo, el juego funciona en MODO LOCAL
//  (el ranking se guarda solo en el navegador de cada jugador).
// =====================================================================

window.CONFIG = {
  SUPABASE_URL: "https://TU-PROYECTO.supabase.co",
  SUPABASE_ANON_KEY: "TU_ANON_KEY",
  TABLA: "ranking",
  TOP: 10
};
