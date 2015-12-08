namespace :stretcher do
  set :exclude_dirs, fetch(:exclude_dirs) << "vendor/bundle" << "public/assets"

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
          execute :bundle, :exec, :rake, 'assets:precompile'
        end
      end
    end
  end

  task :cleanup_precompiled_assets do
    on application_builder_roles do
      within local_build_path do
        execute :rm, '-rf', "public/assets"
      end
    end
  end
end

after 'stretcher:checkout_local', 'stretcher:bundle'
before 'stretcher:create_tarball', 'stretcher:asset_precompile'
after 'stretcher:cleanup_dirs', 'stretcher:cleanup_precompiled_assets'
