# Powerline Shell トグル機能

Powerline Shellのプロンプトに表示されるKubernetes情報とGCP情報を動的に表示/非表示切り替えする機能です。

## 使用方法

### 基本コマンド

#### Kubernetes情報のトグル
```bash
k8s-toggle    # 表示/非表示を切り替え
k8s-info      # エイリアス（同じ動作）
```

#### GCP情報のトグル
```bash
gcp-toggle    # 表示/非表示を切り替え
gcp-info      # エイリアス（同じ動作）
```

#### 両方同時にトグル
```bash
prompt-toggle # Kubernetes/GCP両方の表示/非表示を切り替え
prompt-info   # エイリアス（同じ動作）
```

### 環境変数での制御

以下の環境変数を設定することで、起動時から情報を非表示にできます：

```bash
# Kubernetes情報を非表示
export POWERLINE_K8S_HIDE=1

# GCP情報を非表示
export POWERLINE_GCP_HIDE=1

# 表示に戻す
unset POWERLINE_K8S_HIDE
unset POWERLINE_GCP_HIDE
```

### 永続化

常に非表示にしたい場合は、`~/.zshrc.local`に以下を追加：

```bash
# Kubernetes情報を常に非表示
export POWERLINE_K8S_HIDE=1

# GCP情報を常に非表示
export POWERLINE_GCP_HIDE=1
```

## 実装詳細

- `powerline-shell.py`は生成物のため直接編集不可
- `.zshrc.prompt`の`powerline_precmd`関数で出力をフィルタリング
- K8S情報: ⎈マークを含む行全体を削除
- GCP情報: GCPセグメントのみを削除（行は維持）

## トラブルシューティング

### 設定が反映されない場合
```bash
source ~/.zshrc
```

### 動作確認
```bash
# 現在の環境変数を確認
echo "K8S_HIDE: $POWERLINE_K8S_HIDE"
echo "GCP_HIDE: $POWERLINE_GCP_HIDE"
```