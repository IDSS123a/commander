# Kako upravljati AI Coding Assistantom (ACA)
## Univerzalni priručnik za non-codera koji gradi web apps
## Autor: Davor Mulalić | Sistem: Commander (github.com/IDSS123a/commander)
## Verzija: 1.0 — Juli 2026

---

## Uvod

Ovaj priručnik je napisan na osnovu stvarnog iskustva gradnje IDSS Handbook web aplikacije. Svaka lekcija je naučena kroz konkretnu grešku ili uspjeh. Ništa ovdje nije teorija.

Cilj je da ti — kao non-coder — možeš upravljati bilo kojim AI Coding Assistantom (ACA) na bilo kojoj platformi i dobiti profesionalne rezultate.

---

## 1. Zlatna pravila prije nego kreneš

### 1.1 Commander je tvoj zakon

Svaki put kada kreneš novi razgovor s ACA-om, daj mu tri URL-a:

```
1. Commander Constitution (univerzalni zakon):
   https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md

2. Project Constitution (zakon projekta):
   https://raw.githubusercontent.com/IDSS123a/[projekt]/main/CONSTITUTION.md

3. Trenutni sprint:
   https://raw.githubusercontent.com/IDSS123a/[projekt]/main/sprints/SPRINT_XX.md
```

Bez ovih tri URL-a — ne kreći. ACA koji ne zna zakon ne može poštovati zakon.

### 1.2 Jedan sprint = jedan razgovor

Nikada ne tražiš od ACA-a da izgradi cijelu aplikaciju u jednom razgovoru. To je najskuplja greška.

```
POGREŠNO: "Napravi mi cijelu IDSS Handbook aplikaciju."

ISPRAVNO:  "Pročitaj Sprint 01 i implementiraj ga."
```

### 1.3 Uvijek zatraži kompletne fajlove

Ti si non-coder. Ne možeš raditi s parcijalnim izmjenama.

```
POGREŠNO: "Dodaj ovu liniju u actions.ts na liniji 43."

ISPRAVNO:  "Napiši mi cijeli actions.ts fajl s ovom izmjenom."
```

### 1.4 Nikada nemoj dati ACA-u pristup .env fajlu

Neke platforme (Google Antigravity, Devin) mogu čitati i mijenjati lokalne fajlove. Antigravity je obrisao sve ključeve bez pitanja. Uvijek napravi backup .env fajla prije nego dozvolis ACA-u file-system pristup.

---

## 2. Kako odabrati ACA za zadatak

Različiti ACA alati su dobri za različite zadatke. Ne koristi jedan alat za sve.

| Zadatak | Preporučeni ACA |
|---|---|
| Planiranje, arhitektura, System Instructions | Claude (claude.ai) |
| Implementacija koda, sprint po sprint | GitHub Copilot u VS Code |
| UI komponente (React/Tailwind/Shadcn) | v0.dev |
| Brzi bugfix | GitHub Copilot |
| Code review | Claude |
| Analiza grešaka iz terminala | Claude |

### Platforme koje izbjegavaj za ovaj tip projekta

- **Devin** — free tier se iscrpi u 2 sprinta. Nije isplativo.
- **Google Antigravity** — briše .env bez upozorenja. Opasno.
- **Lovable/Bolt** — dobri za prototipe, loši za kompleksnu logiku.
- **Rocket.new** — slab za backend kompleksnost.

### Windsurf napomena

Windsurf je preuzeo Devin i preimenovan u Devin Desktop. Ako tražiš Windsurf, završit ćeš na Devinu.

---

## 3. Protokol za svaki sprint

Svaki sprint slijedi isti protokol. Bez iznimke.

### Korak 1 — Pripremi prompt

```
Pročitaj ova tri dokumenta u cijelosti:

1. [Commander Constitution URL]
2. [Project Constitution URL]  
3. [Sprint URL]

Implementiraj sprint tačno kako je specificiran.
Projekt koristi src/ folder strukturu.
Terminal: Windows CMD sintaksa isključivo.
Napiši kompletan sadržaj svakog fajla — ne parcijalne izmjene.
```

### Korak 2 — ACA piše kod

Pusti ACA da završi. Ne prekidaj.

### Korak 3 — Ti copy-paste u VS Code

Otvori svaki fajl koji ACA napiše, obriši stari sadržaj, zalijepi novi.

### Korak 4 — TypeScript provjera

```
npx tsc --noEmit
```

Ako ima grešaka — ne nastavljaj. Pošalji grešku ACA-u i traži ispravku.

### Korak 5 — Pokretanje

```
npm run dev
```

Otvori browser i provjeri da li radi.

### Korak 6 — Commit

```
git add .
git commit -m "feat: Sprint XX complete - [kratak opis]"
git push
```

### Korak 7 — Javi ACA-u koji si sprint završio

Svaki put kad počinješ novi razgovor s ACA-om, reci mu koji je posljednji završeni sprint. ACA nema memoriju između razgovora.

---

## 4. Kako prenositi kontekst između razgovora

ACA nema memoriju. Svaki novi razgovor počinje od nule.

Uvijek počni razgovor s ovim blokom:

```
Projekt: [naziv projekta]
Local root: [putanja na računaru]
Commander: https://raw.githubusercontent.com/IDSS123a/commander/main/CONSTITUTION.md
Project Constitution: https://raw.githubusercontent.com/IDSS123a/[projekt]/main/CONSTITUTION.md
Zadnji završeni sprint: Sprint XX
Sada implementiraj: Sprint XX+1
URL sprinta: [sprint URL]
```

---

## 5. Greške koje će se desiti i kako ih riješiti

### 5.1 TypeScript greška

ACA napiše kod s greškom. Normalno.

```
Šalji grešku ovako:

"npx tsc --noEmit daje ovu grešku:
[paste greške]

Napiši mi cijeli fajl src/[putanja] s ispravkom."
```

### 5.2 API greška (404, 403, 500)

Kada dobiješ API grešku u browseru ili terminalu:

```
"Dobivam ovu grešku u terminalu:
[paste greške]

Analiziraj i napiši mi ispravljene fajlove."
```

### 5.3 ACA tvrdi da je sprint završen a kod ne postoji

Ovo se desilo s novim chatbotom koji je tvrdio da je završio Sprint 06 i 07 ali nisu kreirani nikakvi fajlovi. Provjera:

```
dir src\features\[naziv]
```

Ako folder ima samo `.gitkeep` — sprint nije završen. Zatraži od ACA-a da implementira ponovo.

### 5.4 .env grešaka

Najčešći uzroci:
- Razmak iza `=` znaka: `KEY= vrijednost` → greška
- Navodnici: `KEY="vrijednost"` → greška  
- Ispravno: `KEY=vrijednost`

### 5.5 Supabase greška "no unique constraint"

Kada koristiš `upsert` s `onConflict`, kolona mora imati UNIQUE constraint u bazi. Dodaj ga u Supabase SQL Editor:

```sql
ALTER TABLE [tabela] ADD CONSTRAINT [naziv] UNIQUE ([kolona]);
```

### 5.6 Zod greška ".errors ne postoji"

Zod v3+ koristi `.issues` umjesto `.errors`:

```typescript
// Pogrešno
result.error.errors[0].message

// Ispravno  
result.error.issues[0].message
```

### 5.7 Next.js middleware upozorenje

Next.js 16+ ne koristi `middleware.ts` nego `proxy.ts` s exportom:

```typescript
export async function proxy(request: NextRequest) { ... }
```

### 5.8 Supabase Admin Client greška u API rutama

`createSupabaseAdminClient()` koji koristi `cookies()` ne radi u API rutama. Koristi direktni klijent:

```typescript
export function createSupabaseDirectAdmin() {
  return createClient(
    env.NEXT_PUBLIC_SUPABASE_URL,
    env.SUPABASE_SERVICE_ROLE_KEY,
    { auth: { autoRefreshToken: false, persistSession: false } }
  )
}
```

---

## 6. Kritične tehničke lekcije

Ove lekcije su naučene kroz konkretne greške na IDSS Handbook projektu.

### 6.1 Gemini API — embedding modeli

`text-embedding-004` nije dostupan na Gemini free tier ključevima.

Dostupni embedding modeli na free tier:
- `gemini-embedding-001`
- `gemini-embedding-2` (dimenzija: 3072)
- `gemini-embedding-2-preview`

Provjeri koji modeli su dostupni na tvojim ključevima:
```
https://generativelanguage.googleapis.com/v1beta/models?key=TVOJ_KLJUC
```

### 6.2 Gemini API — endpoint verzije

Generation model (`gemini-2.5-flash`): koristi `v1beta` endpoint
Embedding modeli: provjeriti koji endpoint podržavaju (može biti `v1` ili `v1beta`)

### 6.3 Supabase CLI i Vercel projekti

Ako je Supabase projekt kreiran kroz Vercel organizaciju, `supabase link` ne radi — nedostaju privilegije. Koristi Supabase Dashboard SQL Editor direktno.

### 6.4 pgvector dimenzija

Dimenzija vektora u kodu i u bazi mora biti identična. Ako mijenjaš embedding model, moraš promijeniti i `vector(N)` u bazi i sve funkcije koje ga koriste.

### 6.5 Gemini generation model

Jedini ispravan string za generaciju je: `gemini-2.5-flash`

Svi drugi stringovi (`gemini-2.0-flash`, `gemini-flash-2.0`, itd.) vraćaju grešku.

### 6.6 Supabase i resurs sa specifičnom organizacijom

Supabase projekti pod `vercel_icfg_` organizacijom ne mogu biti upravljani kroz standardni Supabase CLI koji je autentificiran s tvojim osobnim računom. Rješenje: uvijek koristi Supabase Dashboard.

---

## 7. Upravljanje API ključevima

### 7.1 Nikada ne commituješ .env

`.env` fajl mora biti u `.gitignore`. Provjeri:

```
git status
```

Ako vidiš `.env` u listi — odmah dodaj u `.gitignore` i pokreni:

```
git rm --cached .env
```

### 7.2 .env.example uvijek commit

`.env.example` s placeholder vrijednostima (bez pravih ključeva) uvijek ide na GitHub. Svaki novi ključ koji dodaš — dodaj i u `.env.example`.

### 7.3 Backup .env

Prije nego dozvoliš ACA-u pristup fajlovima, napravi backup:

```
copy .env .env.backup
```

### 7.4 Ako izgubis ključeve

Svaki servis ima dashboard gdje možeš regenerirati ključeve:

| Servis | URL |
|---|---|
| Supabase | supabase.com/dashboard → Settings → API |
| Gemini | aistudio.google.com/apikey |
| Resend | resend.com/api-keys |
| Upstash | console.upstash.com → Details |
| OCR.Space | ocr.space/ocrapi |
| Sentry | sentry.io → Settings → Client Keys |

---

## 8. GitHub workflow

### 8.1 Inicijalni setup (jednom po projektu)

```
git init
git add .
git commit -m "feat: initial scaffold"
git branch -M main
git remote add origin https://github.com/IDSS123a/[repo].git
git push -u origin main
```

Ako GitHub repo već ima fajlove:

```
git pull origin main --allow-unrelated-histories
git push -u origin main
```

### 8.2 Svakodnevni workflow

```
git add .
git commit -m "feat: Sprint XX complete - [opis]"
git push
```

### 8.3 Conflict pri mergu

Ako dobiješ conflict:

```
git checkout --theirs [fajl s conflictom]
git add [fajl]
git commit -m "merge: resolve conflict"
git push
```

---

## 9. Kontrolni sistem — kako znaš da je sprint stvarno završen

Nakon svakog sprinta, provjeri sve ovo:

```
□ npx tsc --noEmit → 0 grešaka
□ npm run dev → app se pokreće bez grešaka
□ Browser → funkcionalnost radi kako je očekivano
□ dir src\features\[sprint folder] → postoje stvarni fajlovi (ne samo .gitkeep)
□ git push → pushano na GitHub
□ GitHub → vidim nove fajlove u repozitoriju
```

Ako ijedna stavka nije označena — sprint nije završen.

---

## 10. Resend email u razvoju

Resend zahtijeva verificiranu domenu za `FROM` adresu. U razvoju:

1. Koristi `onboarding@resend.dev` kao `RESEND_FROM_EMAIL`
2. Za notifikacije direktoru koristi Gmail: `mulalic71@gmail.com` (ili tvoj Gmail)
3. Greške slanja emaila u razvoju — omotaj u `try/catch` da ne blokiraju ostale operacije
4. Za produkciju: verificiraj domenu na resend.com/domains

---

## 11. Supabase — čisti start

Kada naslijediš Supabase projekt sa "smećem" od prethodnih eksperimenata:

1. Ne pokušavaj čistiti — obrisi projekt
2. Kreiraj novi čisti projekt
3. Postavi novu organizaciju: `IDSS123a` (ne Vercel organizacija)
4. Ažuriraj .env s novim ključevima
5. Pokreni migracije ispočetka

Gubiš 30 minuta ali štediš sate frustracija.

---

## 12. Komunikacija s ACA-om — fraze koje rade

### Kada tražiš implementaciju
```
"Pročitaj [URL] i implementiraj tačno kako je specificirano."
```

### Kada imaš grešku
```
"Dobijem ovu grešku: [paste]. Napiši mi cijeli fajl [putanja] s ispravkom."
```

### Kada ACA napravi parcijalnu izmjenu
```
"Ja sam non-coder. Ne mogu raditi s parcijalnim izmjenama. 
Napiši mi cijeli fajl."
```

### Kada ACA skrne s puta
```
"STOP. Pročitaj Commander Constitution: [URL].
Implementiraj SAMO ono što piše u Sprint dokumentu. 
Ništa više, ništa manje."
```

### Kada tražiš provjeru
```
"Provjeri GitHub repo [URL] i reci mi je li Sprint XX stvarno implementiran."
```

---

## 13. Commander update — kako i kada

Na kraju svakog projekta (ili veće cjeline), ažuriraj Commander s naučenim lekcijama.

Stvari koje sam naučio na IDSS Handbook projektu a koje idu u Commander:

1. `ENGINEERING_RULES.md` — Zod v3+ koristi `.issues` ne `.errors`
2. `ARCHITECTURE_PATTERNS.md` — Next.js 16+ koristi `proxy.ts`
3. `ARCHITECTURE_PATTERNS.md` — `upsert` zahtijeva eksplicitni UNIQUE constraint
4. `ARCHITECTURE_PATTERNS.md` — `createSupabaseDirectAdmin()` za API rute
5. `DECISION_LOG.md` — ACA alati mogu brisati .env — uvijek backup
6. `DECISION_LOG.md` — Supabase CLI ne radi za Vercel org projekte
7. `DECISION_LOG.md` — `text-embedding-004` nije na free Gemini tier
8. `PROMPT_LIBRARY/recover-env.md` — kako regenerirati .env ključeve
9. `FEATURE_LIFECYCLE.md` — ACA kreira HANDOFF_SPRINT_XX.md (korisna praksa)

---

## 14. Psihologija rada s ACA-om

### ACA nije magičan

ACA griješi. Čini to često. To je normalno. Tvoj posao je da ga ispraviš, ne da budeš frustriran.

### ACA nema memoriju

Svaki novi razgovor je novi ACA koji nikad nije vidio tvoj projekt. Uvijek mu daj kontekst.

### ACA tvrdi da je završio a nije

Uvijek provjeri stvarne fajlove, ne samo što ACA kaže. `dir` komanda ili GitHub su jedina istina.

### Jedan problem odjednom

Nikada ne šalji ACA-u više od jednog problema u istoj poruci. Rješava prvi, zaboravlja ostale.

### Pauze su OK

Ako si zaglavljen s greškom više od 30 minuta — zaustavi se. Napiši mi. Ponekad je lakše sve pogledati svježim očima.

---

*Commander v1.0 — IDSS123a Organisation*
*Dokument: ACA Management Guide*
*Na osnovu iskustva gradnje IDSS Handbook Web App — Sarajevo 2026*
