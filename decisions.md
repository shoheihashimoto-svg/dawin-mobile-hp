# decisions.md — mobile-saiyo-hp

---

## トップのヒーロー画像を「原石から輝きへ」に（Three.jsの宝石は撤去）
**決定日：2026-11-07**

- 3案（A ダイヤ／B 原石から輝きへ／C 現場写真風）から **B** を採用（橋本）。
- 画像は gpt-image-2 で作り、`public/hero-genseki.webp`（1200×1200・約250KB）に置く。Three.js（3Dの宝石）は外した。
- 流れ（流れ星のイントロ→「Diamond cuts diamond」→ヒーロー）は変えない。画像はふわっと浮く動き＋光が横切る動きだけ。

### なぜこう決めたか
- 専用に作り直した画像より、サンプルBを切り抜いた「仮の画像」のほうが良いと判断（橋本「仮の方がよかった」）。
- そのため、仮の画像を元に「同じ絵のまま高精細に」と描き直させた版を本番にした。新しく生成し直すと別の絵になってしまう。

### 作り方（作り直すときはこの順）
1. サンプルBを生成（1536×1024）し、石の部分を切り抜く（切り抜き範囲 640,150〜1500,1010）
   > Cinematic photorealistic still life on a deep midnight navy background (#050816): in the right half of a wide landscape frame, a rough uncut raw diamond crystal stone transforms from left to right into a perfectly cut, polished brilliant diamond; the left part of the stone is rough, cloudy and grey-white with natural crystal texture, the right part is precisely faceted and sparkling with white and electric blue light. Fine glittering dust particles and small shards float around the cutting boundary, as if the stone is being sharpened. Blue rim light. The left half of the frame is empty dark navy space for website text. Premium, dramatic, hopeful mood. No text, no letters, no logos, no tools, no hands, no people, no watermark.
2. 切り抜いた画像を `edit`（2048×2048・quality high・2枚）で高精細にし、元にいちばん近い1枚を選ぶ
   > Recreate this exact image as a higher-resolution, sharper version with finer detail. Keep everything the same: the same composition and framing, the same stone shape, size, angle and position, the left half rough grey rocky raw stone and the right half cut brilliant diamond, the same glowing electric blue crystal dust and sparkles at the boundary and around the stone, the same deep navy almost black background and the same blue glow under the stone. Only improve sharpness, facet crispness, rock texture detail and clean fine particles. No text, no letters, no logos, no watermark.
3. 1200×1200 の webp（品質86）にして `public/hero-genseki.webp` を差し替える
- 注意：gpt-image-2 は `--input-fidelity` が使えない（エラーになる）。

---

## SEO対策の方針（2026-08-05実施）
**決定日：2026-08-05**

### 実施済み
- `Layout.astro` に canonical タグ追加（全ページ共通）
- `recruit.astro` に JobPosting 構造化データ（JSON-LD）追加 → Googleしごと検索対応
- ブログ5本のタイトルに「携帯販売バイト」「モバイルイベントスタッフ」などのキーワードを追加

### 中長期でやること（優先度順）
1. エリア特化ブログ記事（「東京で携帯販売バイトを探している方へ」「福岡版」）
2. 求人ボックス クローリング申請（求人ページを職種別URLに分割する必要あり）
3. Airワーク（Indeed連携・無料）の導入検討
4. ブログ記事ごとに個別OGP画像を用意（現状は全記事共通画像）
5. Google Search Console でインデックス状況・流入KWを定期確認

### 方針
- ビッグKW（「携帯 バイト」等）は媒体サイトに勝てない。ロングテール＋ブランドKWで勝ちに行く。
- ブログは「不安解消型FAQ」がSEO×採用の両面で最も効く。週1本継続。

---

## ブログ記事の口調・カテゴリルール
**決定日：2026-07-22**

- **口調**：全記事、です・ます調で統一する。だ/である調は使わない。
- **category**：`部長より` で統一（`部長から` は使わない）。
- **週次運用**：毎週月曜にQuill・Buzzと壁打ちしてネタを決め、本文作成 → git push → 本番自動反映の流れ。

---

## インタビューページ 写真ルール
**決定日：2026-07-10**

### 写真は必ず2枚用意する（1枚では登録不可）

| フィールド | 用途 | 使う場所 |
|---|---|---|
| `photo` | アイコン（ヒーロー左の丸い写真） | `[id].astro` ヒーローセクション・`interview.astro` カード |
| `photoPosition` | アイコン用 object-position | 同上 |
| `mainPhoto` | メイン写真（Q1の上、角丸・余白付き） | `[id].astro` メインセクション |
| `mainCaption` | メイン写真の下のキャプション（例：「休日は子供と一緒に」） | 同上 |

### ルール
- `photo` と `mainPhoto` は **必ず両方** セットする。片方だけの場合は公開しない。
- `mainPhoto` に fallback（`|| staff.photo`）は **使わない**。両方なければビルドで気づけるよう明示的に分ける。
- 写真ファイルは `public/` に置く。命名：`{id}.jpg`（アイコン）・`{id}_main.jpg`（メイン）
- `interview.astro`（一覧ページ）と `[id].astro`（詳細ページ）の **両方** にデータを追加する。片方だけは必ずミスになる。

### 作業チェックリスト（新しいスタッフ追加時）
- [ ] `public/{id}.jpg` コピー済み
- [ ] `public/{id}_main.jpg` コピー済み
- [ ] `interview.astro` の `members` 配列に `photo`・`photoPos` 追加済み
- [ ] `[id].astro` の `staffData` に `photo`・`photoPosition`・`mainPhoto`・`mainCaption` 追加済み

### なぜこう決めたか
毎回「一覧ページだけ追加」「詳細ページのメイン写真を忘れる」「1枚を使い回す」といったミスが繰り返されたため、
2枚必須・fallback禁止・両ページ同時追加を明示的なルールとして定めた（2026-07-10）。
