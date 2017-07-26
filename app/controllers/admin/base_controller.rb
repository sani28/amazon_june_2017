class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

  private

  def authorize
    head :unauthorized unless current_user.is_admin?
  end
end
