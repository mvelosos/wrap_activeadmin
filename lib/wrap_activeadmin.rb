# Base
require 'devise'
require 'active_admin'
require 'draper'
require 'ancestry'
require 'acts_as_list'
# Components
require 'bootstrap'
require 'bootstrap-datepicker-rails'
require 'jquery-minicolors-rails'
require 'just-datetime-picker'
require 'carrierwave'
require 'carrierwave/video'
require 'carrierwave/audio'
require 'streamio-ffmpeg'
require 'tinymce-rails'
require 'select2-rails'
require 'dropzonejs-rails'
require 'chart-js-rails'
require 'jquery-rails'
require 'jquery-ui-rails'
# Countries
require 'flag-icons-rails'
require 'carmen-rails'
require 'countries'
# Google Analytics
require 'oauth2'
require 'legato'
require 'signet/oauth_2/client'
# Video Embed
require 'video_info'
# Compilers
require 'slim-rails'
require 'sass'
# Engine
require 'wrap_activeadmin/engine'

# Engine
module WrapActiveadmin

  autoload :VERSION, 'wrap_activeadmin/version'

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
