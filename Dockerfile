# ---- DeskGROW OpenSCAD Builder ----
FROM ubuntu:22.04

# 1) 必要なパッケージを一括インストール
#    - openscad          : STL 生成エンジン
#    - libgl1, libglu1   : OpenSCAD が CLI で動くのに必須な OpenGL ライブラリ
#    - python3-pip       : Python パッケージ管理ツール
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openscad \
        libgl1 \
        libglu1-mesa \
        python3-pip && \
    rm -rf /var/lib/apt/lists/*

# 2) 作業ディレクトリを /srv に
WORKDIR /srv

# 3) GitHub リポジトリの内容をすべてコピー
COPY . .

# 4) Python 依存 (Flask, gunicorn など) をインストール
#    python3 -m pip … にすると “pip not found” 問題を回避できる
RUN python3 -m pip install --no-cache-dir -r requirements.txt

# 5) コンテナ起動コマンド
#    gunicorn が Flask アプリ server:app をポート 10000 で待ち受け
CMD ["gunicorn", "-b", "0.0.0.0:10000", "server:app"]
