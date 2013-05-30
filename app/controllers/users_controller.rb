class UsersController < ApplicationController
  before_filter :authorize, :except => [:facebook_login, :twitter_login, :user_tweet]
  # GET /users
  # GET /users.json
  skip_before_filter :authorize_admin, :only => [:show, :facebook_login, :twitter_login, :user_tweet]
   def authorize_admin
      if (session[:user_role]== nil) && (User.find_by_id(session[:user_id]))
        redirect_to admin_index_url, :notice => "Unauthorized view"
      end
  end
 
 def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
  
  def facebook_login
    
       p omniauth = request.env['omniauth.auth']
       omniauth.extra.raw_info.email
       omniauth.extra.raw_info.first_name
     if  user = User.find_by_Email_id(omniauth.extra.raw_info.email)
      p "+++++++++++print current user+++++++++++=="
         session[:user_id] = user.id
             session[:user_role] = user.role1
               p "++++++++++++END ++++++++++"
                 redirect_to store_index_path
       else 
        user = User.new(:Email_id => omniauth.extra.raw_info.email, :name => omniauth.extra.raw_info.first_name)
          user.save(:validate => false)
            session[:user_id] = user.id
                session[:user_role] = user.role1
                  redirect_to store_index_path
       
      end
  end
  
  def user_tweet
       
   Twitter.configure do |config|
    config.consumer_key = "o03XFFrtRcUaOEljH1vMw"
      config.consumer_secret = "BhK9HK4NnNmA4MyJO6KdZEHQ9jCQULQMeImNyiEyxak"
        config.oauth_token = session[:twitter_token]
          config.oauth_token_secret = session[:twitter_secret]
  end

 
    
    Twitter.update(params["tweet_content"])
    redirect_to store_index_path
end
  
  def twitter_login
    
      p omniauth = request.env['omniauth.auth']
        p session[:twitter_secret] = omniauth.extra.access_token.secret
          p session[:twitter_token] = omniauth.extra.access_token.token
            redirect_to store_index_path
              if  user = User.find_by_name(omniauth.extra.raw_info.name)
                session[:user_id] = user.id
                  session[:user_role] = user.role1
              else
                user = User.new(:name => omniauth.extra.raw_info.name)
                  user.save(:validate => false)
                    session[:user_id] = user.id
                      p session[:user_id]        
                        session[:user_role] = user.role1
              end
         
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
          format.json { render json: @user }
      end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @user }
      end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
         
      respond_to do |format|
        if @user.save
          Notifier.new_user_created(@user).deliver 
            RegistrationConfirmed.registration_confirmed(@user).deliver       
              format.html { redirect_to login_url, notice: 'User #{@user.name} was successfully created.' }
                format.json { render json: @user, status: :created, location: @user }
        else
          format.html { render action: "new" }
            format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
   @user = User.(params[:id])
     respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User #{@user.name} was successfully updated.' }
          format.json { head :no_content }
      else
        format.html { render action: "edit" }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

 def upload
   
   p session[:user_id]
   p params[:media]
   @user = User.find_by_id(session[:user_id])
    u = @user.update_attributes(:media => params[:media])
    redirect_to @user, notice: 'File was successfully uploaded'
    end
 
 
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
      @user.destroy

        respond_to do |format|
          format.html { redirect_to users_url }
            format.json { head :no_content }
        end
  end
  
end


