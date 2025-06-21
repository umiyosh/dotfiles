#!/bin/bash
#  このスクリプトはObsidian Tasksで付与したハイプライオリティの文字列を削除し、タスクをクリーンアップするためのスクリプトです。
#  Obsidian Shell Command プラグインからします。
# 引数チェック
if [ $# -ne 1 ]; then
    echo "使用方法: $0 <ファイルのフルパス>"
    exit 1
fi

# ファイルパスを変数に格納
FILE_PATH="$1"

# ファイルの存在確認
if [ ! -f "$FILE_PATH" ]; then
    echo "エラー: ファイルが存在しません: $FILE_PATH"
    exit 1
fi

# ファイルの読み取り権限確認
if [ ! -r "$FILE_PATH" ]; then
    echo "エラー: ファイルの読み取り権限がありません: $FILE_PATH"
    exit 1
fi

# ファイルの書き込み権限確認
if [ ! -w "$FILE_PATH" ]; then
    echo "エラー: ファイルの書き込み権限がありません: $FILE_PATH"
    exit 1
fi

# バックアップファイル名を生成（タイムスタンプ付き）
BACKUP_FILE="${FILE_PATH}.backup.$(date +%Y%m%d_%H%M%S)"

# バックアップを作成
cp "$FILE_PATH" "$BACKUP_FILE"
if [ $? -ne 0 ]; then
    echo "エラー: バックアップの作成に失敗しました"
    exit 1
fi

echo "バックアップを作成しました: $BACKUP_FILE"

# sedコマンドで🔺を削除（インプレース編集）
# macOSとLinuxの両方で動作するよう、-iオプションの後に空文字列を指定
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOSの場合
    sed -i '' 's/🔺//g' "$FILE_PATH"
else
    # Linuxの場合
    sed -i 's/🔺//g' "$FILE_PATH"
fi

# sedの実行結果を確認
if [ $? -eq 0 ]; then
    echo "成功: 🔺を削除しました"

    # 変更があったか確認
    if diff -q "$FILE_PATH" "$BACKUP_FILE" > /dev/null; then
        echo "情報: ファイルに🔺は含まれていませんでした"
        # バックアップを削除（変更がない場合）
        rm "$BACKUP_FILE"
        echo "バックアップファイルを削除しました（変更なし）"
    else
        echo "ファイルが更新されました"
        rm "$BACKUP_FILE"
        echo "バックアップファイルを削除しました(変更あり)"
    fi
else
    echo "エラー: 🔺の削除に失敗しました"
    # エラーの場合、バックアップから復元
    mv "$BACKUP_FILE" "$FILE_PATH"
    echo "バックアップから復元しました"
    exit 1
fi
