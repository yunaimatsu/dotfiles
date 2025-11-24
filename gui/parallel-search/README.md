# Parallel Search CLI

通常検索（DuckDuckGo）とAI検索（Claude）を同じターミナルで並列表示するCLIツールです。

## 特徴

- 🔍 **DuckDuckGo検索**: 通常のWeb検索結果を表示
- 🤖 **Claude AI検索**: AI による検索クエリの解析と回答を表示
- ⚡ **並列実行**: 両方の検索を同時に実行し、高速に結果を取得
- 🎨 **美しいUI**: Rich ライブラリによる見やすい2カラムレイアウト

## セットアップ

### 1. 依存関係のインストール

```bash
cd parallel-search
pip install -r requirements.txt
```

### 2. API キーの設定

Claude API を使用するため、Anthropic の API キーが必要です。

```bash
export ANTHROPIC_API_KEY='your-api-key-here'
```

永続的に設定する場合は、`~/.bashrc` または `~/.zshrc` に追加してください：

```bash
echo 'export ANTHROPIC_API_KEY="your-api-key-here"' >> ~/.bashrc
source ~/.bashrc
```

### 3. 実行権限の付与

```bash
chmod +x search_cli.py
```

## 使い方

### 基本的な使用方法

```bash
python search_cli.py [検索クエリ]
```

### 例

```bash
# Python プログラミングについて検索
python search_cli.py Python プログラミング 入門

# 複数の単語を含む検索
python search_cli.py "machine learning tutorials"

# 結果の表示数を指定（デフォルト: 5件）
python search_cli.py -n 10 人工知能
```

### オプション

- `-n, --num-results`: DuckDuckGo の検索結果表示数（デフォルト: 5）
- `-h, --help`: ヘルプメッセージを表示

## 出力例

ターミナルに2つのパネルが並んで表示されます：

```
┌─────────────────────────────┬─────────────────────────────┐
│  🔍 DuckDuckGo Search       │  🤖 Claude AI Search        │
├─────────────────────────────┼─────────────────────────────┤
│ 1. タイトル...              │ ## 概要                      │
│    https://example.com      │ 検索クエリに対する簡潔な説明 │
│    スニペット...            │                              │
│                             │ ## 主なポイント              │
│ 2. タイトル...              │ - ポイント1                  │
│    ...                      │ - ポイント2                  │
└─────────────────────────────┴─────────────────────────────┘
```

## 技術スタック

- **Python 3.8+**
- **anthropic**: Claude API クライアント
- **duckduckgo-search**: DuckDuckGo 検索 API
- **rich**: ターミナル UI ライブラリ

## トラブルシューティング

### API キーエラー

```
Error: ANTHROPIC_API_KEY environment variable not set
```

→ API キーが設定されていません。上記のセットアップ手順を確認してください。

### 検索エラー

DuckDuckGo の検索が失敗する場合は、ネットワーク接続を確認してください。

## ライセンス

MIT License
