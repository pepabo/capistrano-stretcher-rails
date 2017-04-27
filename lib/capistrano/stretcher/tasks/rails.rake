# Original source about asset_precompile: https://github.com/capistrano-plugins/capistrano-faster-assets/blob/master/lib/capistrano/tasks/faster_assets.rake

namespace :stretcher do
  set :exclude_dirs, fetch(:exclude_dirs) << "vendor/bundle" << "public/assets"
  set :assets_dependencies, %w(app/assets lib/assets vendor/assets Gemfile.lock config/routes.rb)

  class PrecompileRequired < StandardError;
  end

  def local_bundle_path
    @_local_bundle_path ||= fetch(:local_bundle_path, "vendor/bundle")
  end

  task :bundle do
    on application_builder_roles do
      within local_build_path do
        execute :bundle, :install, "--gemfile #{local_build_path}/Gemfile --deployment --path #{local_bundle_path} -j 4 --without development test"
      end
    end
  end

  task :asset_precompile do
    on application_builder_roles do
      within local_build_path do
        with rails_env: fetch(:rails_env) do
          begin
            checkout_dirs = capture(:ls, '-xr', local_checkout_path)
            latest_path = "#{local_checkout_path}/#{checkout_dirs.split[0]}"
            previous_path = "#{local_checkout_path}/#{checkout_dirs.split[1]}"

            raise PrecompileRequired unless previous_path

            execute :ls, "#{previous_path}/public/assets" rescue raise PrecompileRequired

            fetch(:assets_dependencies).each do |dep|
              latest = "#{latest_path}/#{dep}"
              previous = "#{previous_path}/#{dep}"
              next if [latest, previous].map{|d| test "[ -e #{d} ]"}.uniq == [false]

              execute :diff, '-Nqr', latest, previous rescue raise PrecompileRequired
            end

            info('Skipping asset precompile, no asset diff found')

            execute :cp, '-r', "#{previous_path}/public/assets", "#{latest_path}/public/"

          rescue PrecompileRequired
            execute :rm, '-rf', 'public/assets'
            execute :bundle, :exec, :rake, 'assets:precompile'
            execute :cp, '-r', 'public/assets', "#{latest_path}/public/"
          end
        end
      end
    end
  end
end

after 'stretcher:checkout_local', 'stretcher:bundle'
before 'stretcher:create_tarball', 'stretcher:asset_precompile'
