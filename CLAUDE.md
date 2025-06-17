# CLAUDE.md

このファイルは、このリポジトリでコードを扱う際のClaude Code (claude.ai/code) への指針を提供します。

## リポジトリ概要

これは開発環境設定を管理するための個人用dotfilesリポジトリです。Neovim、Zsh、Tmux、Git、各種開発ツールの設定が含まれており、macOSとLinuxのクロスプラットフォーム対応をしています。

## 必須コマンド

### セットアップとインストール
- `./setup.sh` - dotfilesのデプロイ、依存関係のインストール、環境設定を行うメインセットアップスクリプト

### パフォーマンスベンチマーク
- `./bin/vimbench` - Neovim/Vimの起動時間を測定
- `./bin/zshbench` - Zshの起動時間をベンチマーク（10回実行して統計情報を表示）

### 開発ユーティリティ
- `./bin/mkc` - 日本語入力からAI翻訳を使用してConventional Commitメッセージを作成

### テスト
このリポジトリはCircleCIを使用して継続的インテグレーションを行っています。ローカルで変更を検証するには：
1. セットアップスクリプトがエラーなく実行されることを確認: `./setup.sh`
2. シェルの起動をテスト: `zsh -c 'exit'`
3. エディタの起動をテスト: `vim +qa` および `nvim +qa`
4. パフォーマンスベンチマークを実行: `./bin/vimbench` と `./bin/zshbench`

## アーキテクチャ

### ディレクトリ構造
- `/bin/` - カスタムシェルスクリプトとユーティリティ
- `/lua/` - Neovim Lua設定
  - `/lua/config/` - Neovimのコアセットアップとlazy.nvim設定
  - `/lua/plugins/` - 個別のプラグイン設定
- `.zshrc.*` ファイル - モジュール化されたZsh設定（basic、prompt、completion、keybindなど）
- `init.lua` - Neovimのメインエントリーポイント

### 主要な設計原則
1. **モジュラー設定**: Zshの設定は保守性のために複数の`.zshrc.*`ファイルに分割
2. **遅延読み込み**: NeovimはLazy.nvimを使用して効率的なプラグイン管理を実現
3. **クロスプラットフォーム**: macOSとLinuxの違いを条件分岐で処理
4. **パフォーマンス重視**: 起動時間を監視するベンチマークツールを含む

### プラグイン管理
- **Neovim**: Lazy.nvimを使用（`lua/config/lazy.lua`で設定）
- **Zsh**: zgenを使用してプラグイン管理
- **Tmux**: TPM（Tmux Plugin Manager）を使用

### AI統合
このリポジトリにはAI活用ツールが含まれています：
- Claude Sonnet 4を使用するように設定されたAvante.nvimプラグイン
- コマンドラインAIアシスタントのためのShell-GPT統合
- `bin/ChatGPTSearch.sh`でのChatGPT検索機能
- `bin/mkc`でのAIによるコミットメッセージ生成

## AI作業ルール
- Claude Codeは すべての応答に日本語を使用すること。

