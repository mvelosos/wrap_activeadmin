module ViewHelpers

  # ViewHelpers For Tab
  module Tab

    def select_tab?(target_tab, key: :tab)
      return unless target_tab == params[key]
      'selected'
    end

  end

end
