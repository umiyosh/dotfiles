# シェルスクリプトGo移植プロジェクト要求仕様書

## 1. プロジェクト概要

### 1.1 目的
dotfilesリポジトリ内の約50個のシェルスクリプトをGo言語に移植し、以下を実現する：
- 保守性の向上
- エラーハンドリングの改善
- クロスプラットフォーム対応の強化
- パフォーマンスの最適化
- テスタビリティの向上

### 1.2 スコープ
- 対象: `/bin`ディレクトリ内の全シェルスクリプト（約50個）
- 非対象: Pythonスクリプト（将来的に検討）

## 2. 機能要求

### 2.1 スクリプト分類と優先度

#### 高優先度
1. **開発支援系**
   - `vimbench`: Vim/Neovim起動時間測定
   - `zshbench`: Zsh起動時間ベンチマーク
   - `mkc`: AI活用コミットメッセージ生成
   - `mkb`: AI活用ブランチ名生成
   - `revi/revi-kill`: コードレビューツール制御

2. **通知系**
   - `notif`: macOS通知
   - `notif_rich`: Slack通知（マークダウン変換付き）

#### 中優先度
3. **Git拡張**
   - `git-back`: 以前のブランチへの移動
   - `git-follow`: リモートブランチ追跡
   - `git-ignore`: .gitignore管理
   - `git-vdiff`: ビジュアルdiff

#### 低優先度
4. **エディタ/IDE連携**
   - `cur`: Cursor IDE起動
   - `editor.sh`: エディタ起動
   - `te/tj`: テキスト編集

5. **ユーティリティ**
   - `trans`: 翻訳
   - `imgcat`: 画像表示
   - `record_with_whisper.sh`: 音声録音

### 2.2 機能要件
1. **完全な後方互換性**
   - 既存のコマンドライン引数をすべてサポート
   - 出力フォーマットの維持
   - 終了コードの互換性

2. **エラーハンドリングの改善**
   - 明確なエラーメッセージ
   - 適切なエラーコードの返却
   - デバッグモードの提供

3. **設定管理**
   - YAML形式の設定ファイルサポート
   - 環境変数による設定オーバーライド
   - デフォルト値による設定不要での動作

## 3. 非機能要求

### 3.1 パフォーマンス
- 起動時間: シェルスクリプトと同等以下
- メモリ使用量: 最小限に抑制
- 頻繁に使用されるツールはデーモン化を検討

### 3.2 互換性
- macOS: 完全サポート
- Linux: 主要機能のサポート
- シンボリックリンクによる移行期間中の共存

### 3.3 保守性
- 単一バイナリアーキテクチャ
- モジュラー設計
- 包括的なテストカバレッジ（80%以上）

## 4. アーキテクチャ設計

### 4.1 全体構成
```
単一バイナリ「dot」+ サブコマンド構成
例: dot vimbench, dot git-back
```

### 4.2 ディレクトリ構造
```
/dotfiles-go/
├── cmd/
│   └── dot/
│       └── main.go              # エントリーポイント
├── internal/
│   ├── ai/                      # AI統合（sgpt, gemini）
│   ├── app/                     # アプリケーションコンテキスト
│   ├── command/                 # Cobraコマンド定義
│   ├── config/                  # 設定管理
│   ├── exec/                    # プロセス実行ラッパー
│   ├── git/                     # Git操作
│   ├── notification/            # 通知システム
│   └── platform/                # OS固有機能
├── pkg/                         # 公開パッケージ（将来用）
├── testdata/                    # テスト用ゴールデンファイル
├── go.mod
├── go.sum
├── Makefile
└── README.md
```

### 4.3 主要コンポーネント

#### 依存性注入
```go
type App struct {
    Executor     exec.Executor
    Notifier     notification.Notifier
    AIClient     ai.Client
    GitClient    git.Client
    Config       *config.Config
}
```

#### インターフェース設計
```go
// プロセス実行
type Executor interface {
    Command(ctx context.Context, name string, arg ...string) *exec.Cmd
    Run(ctx context.Context, name string, arg ...string) ([]byte, error)
}

// 通知
type Notifier interface {
    Send(ctx context.Context, message string) error
}

// AI統合
type AIClient interface {
    GenerateCommitMessage(prompt string) (string, error)
    GenerateBranchName(description string) (string, error)
}
```

## 5. 実装計画

### 5.1 フェーズ1: 基盤構築（2週間）
- プロジェクト構造のセットアップ
- Cobraフレームワークの統合
- 基本的な内部ライブラリの実装
  - exec wrapper
  - config loader
  - logging

### 5.2 フェーズ2: 基本ツール移植（3週間）
- `vimbench`, `zshbench`
- `notif`, `notif_rich`
- テストフレームワークの確立

### 5.3 フェーズ3: Git/AI統合（4週間）
- `git-back`, `git-follow`, `git-ignore`
- `mkc`, `mkb`
- AI/Git共通ライブラリの実装

### 5.4 フェーズ4: 残りのツール（3週間）
- エディタ連携ツール
- その他ユーティリティ
- 統合テスト

### 5.5 フェーズ5: 最適化と文書化（2週間）
- パフォーマンスチューニング
- ドキュメント作成
- 移行ガイドの作成

## 6. テスト戦略

### 6.1 テストレベル
1. **単体テスト**: モック使用、ロジックの検証
2. **統合テスト**: 実際の外部コマンドとの連携
3. **互換性テスト**: シェルスクリプトとの出力比較
4. **E2Eテスト**: 実使用シナリオの検証

### 6.2 ゴールデンファイルテスト
```bash
# 期待される出力を記録
./bin/vimbench > testdata/vimbench.golden

# Go実装と比較
go test -golden
```

### 6.3 移行テスト
並行実行による互換性確認：
- シェルスクリプト版とGo版を同時実行
- 出力の正規化と比較
- 差分がないことを保証

## 7. 移行戦略

### 7.1 段階的移行
1. Go版を`dot`コマンドとして提供
2. シンボリックリンクで既存コマンド名をサポート
3. 十分なテスト期間後、シェルスクリプトを削除

### 7.2 互換性維持
```bash
# インストール時のシンボリックリンク作成
ln -s /usr/local/bin/dot /usr/local/bin/vimbench
ln -s /usr/local/bin/dot /usr/local/bin/git-back
# ... 他のコマンドも同様
```

## 8. リスクと対策

### 8.1 パフォーマンス低下
- **リスク**: Go起動時間がシェルより遅い
- **対策**: 単一バイナリ化、頻繁使用ツールのデーモン化

### 8.2 互換性の欠如
- **リスク**: 微妙な動作の違い
- **対策**: 徹底的なゴールデンファイルテスト

### 8.3 外部依存の変更
- **リスク**: sgpt等の仕様変更
- **対策**: インターフェース抽象化、バージョン固定

## 9. 成功基準

1. **機能的成功**
   - 全スクリプトの移植完了
   - 既存ワークフローの維持
   - エラーハンドリングの改善

2. **品質基準**
   - テストカバレッジ80%以上
   - ゼロダウンタイム移行
   - ドキュメント完備

3. **性能基準**
   - 起動時間の維持または改善
   - メモリ使用量の最適化

## 10. 今後の拡張性

- プラグインシステムの追加
- Web UIの提供
- 他言語バインディング
- クラウド統合機能

---

作成日: 2025-07-28
作成者: Claude Code with Gemini collaboration