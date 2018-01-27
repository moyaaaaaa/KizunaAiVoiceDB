set :application, 'kizuna_ai_voice_db'

set :repo_url, 'git@github.com:moyaaaaaa/KizunaAiVoiceDB.git'

# デプロイするブランチを指定
set :branch, 'I11'

# デプロイ先のディレクトリ
set :deploy_to, '/var/www/KizunaAiVoiceDB'

# 保持するバージョンの数
set :keep_releases, 5

# rubyのバージョン
set :rbenv_ruby, '2.3.1'

# ログレベルの指定
set :log_level, :debug

namespace :deploy do

  desc 'Initial Deploy'
  task :initial do
    on roles(:app) do
      before 'deploy:restart', 'puma:start'
      invoke 'deploy'
    end
  end

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end
