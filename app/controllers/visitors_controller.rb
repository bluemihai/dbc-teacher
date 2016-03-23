class VisitorsController < ApplicationController
  def index
    if current_user && current_user.admin?
      redirect_to admin_path
    else
      redirect_to welcome_path      
    end
  end

  def about
  end

  def welcome
    @interactions = Interaction.all
  end
end
