$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'wrap_activeadmin/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'wrap_activeadmin'
  s.version     = WrapActiveadmin::VERSION
  s.authors     = ['CMDBrew Studio Inc.']
  s.email       = ['dev@cmdbrew.com']
  s.homepage    = 'http://www.cmdbrew.com'
  s.summary     = 'WrapActiveAdmin is a generic backend panel based on ActiveAdmin'
  s.description = 'WrapActiveAdmin is used as the base backend panel for all our clients.'
  s.license     = 'Copyright CMDBrew Studio Inc.'

  s.files = Dir['{app,config,db,lib}/**/*', 'LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '>= 5.0.2'
  s.add_dependency 'slim-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'activeadmin', '>= 1.3', '< 1.4'
  s.add_dependency 'just-datetime-picker'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails', '~> 6.0.1'
  s.add_dependency 'jquery-minicolors-rails'
  s.add_dependency 'dropzonejs-rails', '~> 0.7.4'
  s.add_dependency 'select2-rails'
  s.add_dependency 'tinymce-rails'
  s.add_dependency 'chart-js-rails', '~> 0.1.3'
  s.add_dependency 'friendly_id', '~> 5.1.0'
  s.add_dependency 'carrierwave', '~> 1.3.1'
  s.add_dependency 'carrierwave-audio'
  s.add_dependency 'carrierwave-video'
  s.add_dependency 'streamio-ffmpeg'
  s.add_dependency 'mini_magick'
  s.add_dependency 'fog-aws'
  s.add_dependency 'acts_as_list', '~> 0.9.10'
  s.add_dependency 'devise'
  s.add_dependency 'bootstrap', '~> 4.0.0'
  s.add_dependency 'bootstrap-datepicker-rails'
  s.add_dependency 'draper', '~> 3.0.1'
  s.add_dependency 'flag-icons-rails'
  s.add_dependency 'carmen-rails'
  s.add_dependency 'countries'
  s.add_dependency 'google-api-client', '~> 0.11'
  s.add_dependency 'oauth2'
  s.add_dependency 'signet'
  s.add_dependency 'legato'
  s.add_dependency 'ancestry'
  s.add_dependency 'video_info', '~> 2.7.0'

  s.add_development_dependency 'devise'
  s.add_development_dependency 'pg', '~> 0.15'
  s.add_development_dependency 'thin'
  s.add_development_dependency 'byebug'
  s.add_development_dependency 'interactive_editor'
  s.add_development_dependency 'letter_opener'
  s.add_development_dependency 'faker'
end
