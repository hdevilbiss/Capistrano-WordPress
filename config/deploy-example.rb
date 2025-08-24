set :application, 'example.com'
set :repo_url, 'git@github.com:username/example.com.git'
set :username, -> {'username'}

# Git Branch Options
# ask :branch, -> { `git rev-parse --abbrev-ref HEAD`.chomp }
set :branch, :master
# set :branch, :main
# set :branch, :development

# Paths (Sometimes the deployment location and the public_html location are different)
set :proj_root, -> {"/home/#{fetch(:username)}/remoteServerDirectoryPath/#{fetch(:application)}"}
set :deploy_to, -> {"#{fetch(:proj_root)}/subfolderName"}
set :tmp_dir, -> {"#{fetch(:deploy_to)}/tmp"}

# Linked Files and Folders (must exist on the remote)
set :linked_files, fetch(:linked_files, []).push(".env","web/.htaccess")
set :linked_dirs, fetch(:linked_dirs, []).push("web/app/uploads")
set :linked_dirs, fetch(:linked_dirs, []).push("web/app/plugins/pluginName", "web/app/plugins/pluginName2", " web/app/themes/themeName")

# Task
# NOTE:public_symlink_location can be defined in production.rb and/or staging.rb if there are different locations per stage
# @link https://capistranorb.com/documentation/faq/how-can-i-access-stage-configuration-variables/
set :public_symlink_location, -> {"/home/#{fetch(:username)}/public_html"}

namespace :deploy do
  namespace :symlink do
    desc "Remove public_html and replace with a symlink named public_html to the current/web folder"
    task :release_public_html do
      on roles :app do
        within fetch(:proj_root) do
          execute "rm","-rf","#{fetch(:public_symlink_location)}"
          
          execute "ln","-sf","#{current_path}/web","#{fetch(:public_symlink_location)}"
        end
      end
    end
  end
end

# Hook in the custom deployment task
after "deploy:symlink:release", "deploy:symlink:release_public_html"