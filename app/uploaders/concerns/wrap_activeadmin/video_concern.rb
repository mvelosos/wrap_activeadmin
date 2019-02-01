module WrapActiveadmin

  # VideoUploader
  module VideoConcern

    extend ActiveSupport::Concern
    include CarrierWave::Video
    require 'streamio-ffmpeg'

    included do
      version :web_video do
        process :convert_to_mp4, if: :should_process_video?
      end

      version :video_preview do
        process :screenshot, if: :should_process_video?

        def full_filename(for_file)
          img_name(for_file, version_name)
        end

        def img_name(for_file, version_name)
          %(#{version_name}_#{for_file.chomp(File.extname(for_file))}.jpg)
        end
      end
    end

    def should_process_video?(*args)
      video?(*args) && process_upload?(*args)
    end

    def screenshot
      tmpfile = File.join(File.dirname(current_path), 'tmpfile')
      File.rename(current_path, tmpfile)
      movie = FFMPEG::Movie.new(tmpfile)
      movie.screenshot(current_path + '.jpg')
      File.rename(current_path + '.jpg', current_path)
      File.delete(tmpfile)
    end

    def convert_to_mp4
      options      = { custom: %w[-strict -2] }
      video_name   = file.original_filename
      ffmpeg_video = FFMPEG::Movie.new(file.path)
      ffmpeg_video.transcode("tmp/#{video_name}.mp4", options)
    end

  end

end
