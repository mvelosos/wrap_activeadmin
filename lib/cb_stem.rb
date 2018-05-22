require 'slim-rails'
require 'sass'
require 'cb_stem/engine'

# Engine
module CbStem

  autoload :VERSION, 'cb_stem/version'

  mattr_accessor :google_analytics
  mattr_accessor :chart_colors
  mattr_accessor :file_preview_versions
  mattr_accessor :enable_media_library

  # add default values of more config vars here
  self.google_analytics = {}

  self.chart_colors = [
    '#56b181',
    '#65B1E3',
    '#6775de',
    '#8857a7',
    '#e9a9e7',
    '#d16156',
    '#f09f82',
    '#ecbf68',
    '#20c997',
    '#17a2b8'
  ]

  self.file_preview_versions = %i[thumb]
  self.enable_media_library  = false

  # this function maps the vars from your app into your engine
  def self.setup
    yield self
  end

end
