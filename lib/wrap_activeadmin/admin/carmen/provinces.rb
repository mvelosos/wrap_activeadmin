ActiveAdmin.register_page 'Carmen::Provinces' do
  menu false

  controller do
    skip_before_action :authenticate_active_admin_user

    def index
      collection =
        Carmen::Country.coded(params[:country]).
        subregions.map { |u| [u.name, u.name] }
      render json: collection.to_json, status: :ok
    end
  end
end
