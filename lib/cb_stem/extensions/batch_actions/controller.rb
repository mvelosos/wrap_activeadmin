module ActiveAdmin

  module BatchActions

    # Overwriting Controller - activeadmin/lib/active_admin/batch_actions/controller.rb
    module Controller

      # Controller action that is called when submitting the batch action form
      # rubocop:disable all
      def batch_action
        if action_present?
          selection  =            params[:collection_selection] || []
          inputs     = JSON.parse params[:batch_action_inputs]  || '{}'
          if current_batch_action.inputs.present?
            valid_keys =
              StringSymbolOrProcSetting.new(current_batch_action.inputs).
              value(self).try(:keys)
            inputs     = inputs.with_indifferent_access.slice(*valid_keys)
          end
          instance_exec selection, inputs, &current_batch_action.block
        else
          raise "Couldn't find batch action \"#{params[:batch_action]}\""
        end
      end

    end

  end

end
