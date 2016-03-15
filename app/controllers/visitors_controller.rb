class VisitorsController < ApplicationController
  def index
    if current_user && current_user.admin?
      redirect_to admin_path
    end
  end

  def about
  end
end
