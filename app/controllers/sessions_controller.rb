class SessionsController < ApplicationController
 def new
 #~ redirect_to 
  if session[:user_id]
 session[:user_id] = nil
 redirect_to login_url, :notice => "logged out"
   end
 end

 def create 
  if 
 user = User.authenticate(params[:name],params[:password])
 session[:user_id] = user.id
 session[:user_role] = user.role1
 if session[:user_role] == "admin"
 redirect_to users_url
 else
 redirect_to user_dashboard_index_url
 end
 else
 redirect_to login_url, :alert => "invalid"
 end
end



 def destroy
 session[:user_id] = nil
  redirect_to login_url, :notice => "logged out"
 end
end
