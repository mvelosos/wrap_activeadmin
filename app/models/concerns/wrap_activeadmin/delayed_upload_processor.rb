module WrapActiveadmin

  module DelayedUploadProcessor

    extend ActiveSupport::Concern

    class_methods do
      def process_image(key, *args)
        after_save -> { create_upload_process_job(key, *args) },
                   if: proc { |x| (x.send("#{key}_previous_change").present? && x.send("#{key}_previous_change").uniq.count > 1) || x.direct_upload }
      end
    end

    included do
      attr_accessor :background_upload, :direct_upload

      private

      def create_upload_process_job(
        key, queue: 'upload_job', run_at: 1.minute.from_now,
        status_column: nil
      )
        delay(queue: queue, run_at: run_at).
          create_versions!(key, status_column: status_column)
      end

      def create_versions!(key, status_column: nil)
        return unless respond_to?(key)

        self.background_upload = true
        send("#{status_column}=", true) if status_column && respond_to?(status_column)
        send(key).recreate_versions!
        save!
      end
    end

  end

end
