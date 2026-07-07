# モバイルHP 引き継ぎメモ

最終更新：2026-07-07

---

## 開発サーバーの起動方法

```
cd "C:\dev\mobile-saiyo-hp"
npm run dev
```

→ `http://localhost:4322` で起動（この採用HPの専用ポート。サロンHPは4321）

---

## 今日やったこと（2026-06-20）

### 1. エントリーフォーム → GAS連携を修正・動作確認済み
- **原因**：`no-cors` + `Content-Type: application/json` の組み合わせがブロックされていた
- **対応**：fetchを `URLSearchParams` に変更、GASを `e.parameter` で受け取るよう修正
- **GAS デプロイURL**：  
  `https://script.google.com/macros/s/AKfycbzH4z-YGU85Y8M75R1mMlGA3hfOeVdLgiRDFJKIa0os69NI9iAFWI-paAEqRDtUz_qB/exec`
- **GAS clasp フォルダ**：`C:\ダウイン_AI\_採用フォームGAS\`
- **Script ID**：`14OnsHzbgh4iYWGEpr5NUSWBZF80hXUP8iwhcitzh8JrJyCewclyksqnm`
- GAS更新手順：コードを編集 → `cd _採用フォームGAS` → `clasp push` → `clasp deploy --deploymentId AKfycbzH4z...`

### 2. ABOUTページ修正
- 所在地に福岡を追加（`【東京】...` / `【福岡】...` 形式・改行あり）
- チーム規模：社員16名 ＋ アルバイト27名 に更新
- 価値観カード（挑戦・チームワーク・成長）の絵文字 → SVGアイコンに変更
- テーブルを全幅表示に変更（縦積みレイアウト）

### 3. CULTUREページ修正
- 「ダウインらしさ」4カードの絵文字 → SVGアイコンに変更（ホームと同じスタイル）

### 4. RECRUITページ修正
- 選考フロー（STEP 01/02/03）の高さを揃えた
- 矢印をステップカードの外に切り出し、`items-start` で統一

### 5. ngrok導入（社内限定公開）
- インストール・認証設定済み
- 使い方：ターミナルで `ngrok http 4321` を実行するだけ
- `astro.config.mjs` に `allowedHosts` 設定済み

---

## 現在のページ構成

| ページ | パス | 状態 |
|--------|------|------|
| ホーム | `/` | 完成 |
| 採用情報 | `/recruit` | 完成（フォーム動作確認済み） |
| 私たちについて | `/about` | 完成 |
| チームの文化 | `/culture` | 完成 |
| インタビュー一覧 | `/interview` | 完成（橋本さんのみ公開、他はComing Soon） |
| 橋本インタビュー | `/interview/hashimoto` | 完成 |
| ブログ一覧 | `/blog` | 完成 |
| ブログ第1回 | `/blog/hajimemashite` | 公開済み |
| 送信完了 | `/thanks` | 完成 |

---

## 次にやること（候補）

- [ ] インタビューページ：残り6名分を追加（当面Coming Soonのままでも可）
- [ ] ブログ記事の追加（Quillと一緒に定期更新）
- [ ] 本番公開：Firebase Hosting か Vercel にデプロイ
- [ ] 独自ドメイン設定（m.dawin.co.jp）

---

## よく使うファイルパス

| 内容 | パス |
|------|------|
| ホーム | `src/pages/index.astro` |
| 採用 | `src/pages/recruit.astro` |
| About | `src/pages/about.astro` |
| Culture | `src/pages/culture.astro` |
| Interview | `src/pages/interview.astro` |
| 共通レイアウト | `src/layouts/Layout.astro` |
| Astro設定 | `astro.config.mjs` |
| GASコード | `C:\ダウイン_AI\_採用フォームGAS\コード.js` |
