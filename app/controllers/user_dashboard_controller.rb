class UserDashboardController < ApplicationController
 

def index
  p session[:user_id]
  @user=User.find_by_id(session[:user_id])
  #@user.name
  end
def show
  @user = User.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
  end
end

end
