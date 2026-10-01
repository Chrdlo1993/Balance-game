# CUADRA EL BALANCE

Juego retro (estilo años 80) para aprender la ecuación contable:

```
ACTIVO = PASIVO + PATRIMONIO
```

Eres el contador de la **ventanilla 1**. Cada cliente llega con una solicitud
(tributaria, contable o financiera) y las cuentas de esa operación caen como
piezas de Tetris. Tienes que acomodar cada pieza en **ACTIVO**, **PASIVO** o
**PATRIMONIO** para que la ecuación cuadre.

## Cómo se juega

| Tecla | Acción |
|---|---|
| ◀ ▶ (o A / D) | Mover la pieza |
| 1 · 2 · 3 | Ir directo a Activo · Pasivo · Patrimonio |
| ▼ (o S) | Bajar más rápido |
| ESPACIO (o ▲) | Soltar la pieza |
| P / ESC | Pausa |
| M | Sonido sí / no |

En el celular: toca una columna o usa los botones bajo el tablero.

**Reglas**

- Cada pieza trae el nombre de la cuenta y el valor del movimiento (`+` aumenta, `−` disminuye).
  Ojo: una disminución de Bancos (`−$500`) también va en ACTIVO.
- Pieza bien ubicada: suma puntos. Cuando todas las piezas de la operación están bien, la operación
  **cuadra**, se limpia del tablero y das un bono.
- Pieza mal ubicada: se queda como bloque rojo de **DESCUADRE** y el contador te explica dónde iba.
- Tres operaciones perfectas seguidas = **auditoría limpia**: se elimina un bloque de descuadre.
- Si la columna central (donde caen las piezas) se llena, el balance colapsa y termina la partida.
- Cada 5 clientes subes de nivel: las piezas caen más rápido y llegan operaciones más complejas
  (depreciación, IVA, retención en la fuente, dividendos, reservas, deterioro de cartera, prima en
  colocación de acciones, etc.).

## Archivos

| Archivo | Para qué sirve |
|---|---|
| `index.html` | El juego completo (HTML + CSS + JavaScript, sin dependencias). |
| `config.js` | URL y llave pública de Supabase. |
| `cuadra_el_balance.sql` | Crea la única tabla `ranking` (nombre + puntuación) con sus políticas de seguridad. |
| `README.md` | Este archivo. |

## Configurar Supabase (ranking)

1. Crea un proyecto en [supabase.com](https://supabase.com).
2. Ve a **SQL Editor → New query**, pega el contenido de `cuadra_el_balance.sql` y presiona **Run**.
3. Ve a **Project Settings → API** y copia la **Project URL** y la llave pública **anon / publishable**.
4. Pégalas en `config.js`:

```js
window.CONFIG = {
  SUPABASE_URL: "https://xxxxxxxx.supabase.co",
  SUPABASE_ANON_KEY: "eyJ... o sb_publishable_...",
  TABLA: "ranking",
  TOP: 10
};
```

> Nunca pongas la llave `service_role` / `secret` en `config.js`: ese archivo es público.
> La llave anon es pública por diseño; Row Level Security solo permite **leer** el ranking e
> **insertar** puntajes (no modificar ni borrar).

Sin configurar Supabase el juego funciona en **modo local** (el ranking queda solo en ese navegador).

Para ver el ranking desde Supabase:

```sql
select rank() over (order by puntuacion desc) as puesto, nombre, puntuacion, creado_en
from public.ranking
order by puntuacion desc, creado_en asc
limit 10;
```

## Publicar

**GitHub**

```bash
git init
git add .
git commit -m "Cuadra el balance"
git branch -M main
git remote add origin https://github.com/TU-USUARIO/cuadra-el-balance.git
git push -u origin main
```

**Vercel**

1. En [vercel.com](https://vercel.com) → **Add New → Project** → importa el repositorio de GitHub.
2. Framework Preset: **Other**. Sin comando de build. Output: la raíz del proyecto.
3. **Deploy**. Cada `git push` a `main` vuelve a publicar el juego automáticamente.

## Probar en local

Abre `index.html` en el navegador. (Si el ranking de Supabase no carga desde `file://`,
usa cualquier servidor estático, por ejemplo la extensión Live Server de VS Code.)

## Nota

El ranking es de juego: como cualquier juego 100 % en el navegador, un usuario avanzado podría
enviar un puntaje inventado. La base de datos limita el nombre (1–15 caracteres) y la puntuación
(0 – 10.000.000).
