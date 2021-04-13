class ApplicationController < ActionController::Base
  before_action :set_tracking_cookie

  private

  def set_tracking_cookie
    unless cookies[:user_uuid]
      uuid = SecureRandom.uuid
      cookies.permanent[:user_uuid] = uuid
      User.create(uuid: uuid)
    end
  end
end
