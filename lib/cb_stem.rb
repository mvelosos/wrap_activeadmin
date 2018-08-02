require 'slim-rails'
require 'sass'
require 'cb_stem/engine'

# Engine
module CbStem

  autoload :VERSION, 'cb_stem/version'

  mattr_accessor :google_analytics
  mattr_accessor :video_info
  mattr_accessor :file_preview_versions
  mattr_accessor :enable_media_library
  mattr_accessor :file_size

  # add default values of more config vars here
  self.google_analytics = {}
  self.video_info       = {}
  self.file_size        = 0..10.megabytes

  self.file_preview_versions = %i[thumb]
  self.enable_media_library  = false

  # this function maps the vars from your app into your engine
  def self.setup
    yield self
  end

end
