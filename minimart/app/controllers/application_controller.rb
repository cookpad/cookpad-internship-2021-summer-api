class ApplicationController < ActionController::API

  private

  def current_user
    return @current_user if defined?(@current_user)

    user_name = request.headers['X-User-Name']
    @current_user = if user_name.present?
                      r = User.find_or_create_by!(name: user_name[0, 255]) do |user|
                        user.pickup_location = PickupLocation.first
                      end
                      r.pickup_location = PickupLocation.first
                      r
                    else
                      nil
                    end
  end
end
