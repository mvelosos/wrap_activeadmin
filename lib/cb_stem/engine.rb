require 'devise'
require 'active_admin'

module CbStem

  # Initialize Engine
  class Engine < ::Rails::Engine

    isolate_namespace CbStem

    initializer 'assets.precompile' do |_app|
      config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
    end

  end

end
