class UserSessionsController < ApplicationController
  include ApplicationHelper


  # GET /sessions/1
  # GET /sessions/1.json
  def index
    @user_session = UserSession.find
    if @user_session.nil?
      render :json => nil
    else
      @user = current_user
      @groups = @user.groups.order('groups.name')
      render 'user_sessions/index.json.rabl'
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    @user_session ||= UserSession.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_session }
    end
  end

  # POST /sessions
  # POST /sessions.json
  def create

    @user = User.find_by_annota_id(params[:annota_id]) if params[:annota_id]
    @user = User.find_by_pc_uniq(params[:uniq_pc]) if params[:uniq_pc] && @user.nil?

    if @user.nil?
      render json: @user
      return
    else
      @user_session = UserSession.create(@user, true)
    end


    #respond_to do |format|
    if @user_session
      #format.json { render json: @user_session, status: :created, location: @user_session }
      render json: @user_session, status: :created, location: @user_session
    else
      #format.json { render json: @user_session.errors, status: :unprocessable_entity }
      render json: @user_session.errors, status: :unprocessable_entity

    end
    #end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    @user_session = UserSession.find
    @user_session.destroy if @user_session

    render "http://annota-test.fiit.stuba.sk/best_pages"
    #redirect_to "http://localhost:3000"

  end

  def actionToSkipLogging
    return [:index]
  end

  def actionParamsToSkipLogging
    return {:create => ['authenticity_token']}
  end
end
