# decisions.md — mobile-saiyo-hp

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
