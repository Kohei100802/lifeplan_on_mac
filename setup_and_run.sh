#!/bin/bash

# ライフプランシミュレーターのセットアップと実行スクリプト

echo "=========================================================="
echo "  ライフプランシミュレーター セットアップスクリプト"
echo "=========================================================="

# プロジェクトディレクトリに移動
cd "$(dirname "$0")/lifeplan-simulator"

# Python 3が存在するか確認
if ! command -v python3 &> /dev/null; then
    echo "Python 3がインストールされていません。"
    echo "Homebrewを使用してインストールすることをお勧めします："
    echo "  /bin/bash -c \"\$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\""
    echo "  brew install python"
    exit 1
fi

# Pythonのバージョンを確認
PYTHON_VERSION=$(python3 --version | cut -d' ' -f2)
echo "Python バージョン: $PYTHON_VERSION"

# 仮想環境の作成
if [ ! -d "venv" ]; then
    echo "Python仮想環境を作成しています..."
    python3 -m venv venv
    if [ $? -ne 0 ]; then
        echo "仮想環境の作成に失敗しました。"
        exit 1
    fi
    echo "仮想環境を作成しました。"
else
    echo "仮想環境は既に存在します。"
fi

# 仮想環境を有効化
echo "仮想環境を有効化しています..."
source venv/bin/activate

# 依存パッケージのインストール
echo "依存パッケージをインストールしています..."
pip install -r requirements.txt
if [ $? -ne 0 ]; then
    echo "依存パッケージのインストールに失敗しました。"
    exit 1
fi
echo "依存パッケージをインストールしました。"

# データベースの初期化
if [ ! -f "instance/lifeplan.db" ]; then
    echo "データベースを初期化しています..."
    python admin_tools.py init-db
    if [ $? -ne 0 ]; then
        echo "データベースの初期化に失敗しました。"
        exit 1
    fi
    echo "データベースを初期化しました。"
else
    echo "データベースは既に存在します。"
fi

# ローカルIPアドレスの取得
IPADDR=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n 1)

echo "=========================================================="
echo "セットアップが完了しました！"
echo ""
echo "アプリケーションを起動するには："
echo "  cd lifeplan-simulator"
echo "  source venv/bin/activate"
echo "  python run.py"
echo ""
echo "ブラウザでアクセス："
echo "  ローカル: http://localhost:5000/"
echo "  ネットワーク内: http://$IPADDR:5000/"
echo ""
echo "インターネット公開方法の詳細："
echo "  INTERNET_ACCESS.md ファイルを参照してください。"
echo "=========================================================="

# 実行確認
read -p "今すぐアプリケーションを起動しますか？ (y/n): " CONFIRM
if [ "$CONFIRM" = "y" ] || [ "$CONFIRM" = "Y" ]; then
    echo "アプリケーションを起動しています..."
    python run.py
else
    echo "アプリケーションは起動されませんでした。手動で起動するには上記の手順を実行してください。"
fi