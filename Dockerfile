FROM ruby:3.2.2

# 必要なパッケージのインストール
RUN apt-get update -qq && \
    apt-get install -y build-essential \
                       libpq-dev \  # PostgreSQLクライアントライブラリ
                       nodejs \
                       postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# アプリケーションディレクトリの作成
WORKDIR /app

# GemfileとGemfile.lockをコピー
COPY Gemfile Gemfile.lock ./

# Bundlerでgemをインストール
RUN bundle install && \
    rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
    bundle exec bootsnap precompile --gemfile

# アプリケーションのコピー
COPY . .

# エントリーポイントスクリプトの追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Railsサーバー起動
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]