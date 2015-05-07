class SessionsController < ApplicationController
  
	def create
    @session = Session.new(name: params[:name], date: params[:date], course_id: params[:course_id], active: params[:active])

    if @session.save
      render 'sessions/create'
    else
      @message = "Failed to create a session"
      render nothing: true, layout: 'failure'
    end

  end

  def show
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.find(params[:id])
    if(@session.present? )
      render 'sessions/show'
    else
      @message = "No Sessions"
      render nothing: true, layout: 'failure'
    end

  end

  def index
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @sessions = @course.sessions

    render 'sessions/index'
  end


  def update

    @user = User.find_by_token(params[:token])
    @session = @user.sessions.find(params[:id])

    @session.assign_attributes(params.permit(:name, :date, :course_id, :active))

    if @session.save
      render 'sessions/show'
    else
      @message = "Failed to update a session"
      render nothing: true, layout: 'failure'
    end

  end
  

  def delete
    user = Instructor.find_by_token(params[:token])

    if user.sessions.find(params[:id]).delete
      @message = "Session deleted"
      render nothing: true, layout: 'application'
    else
      @message = "Error deleting session"
      render nothing: true, layout: 'failure'
    end

  end

  def deleteAll

    user = Instructor.find_by_token(params[:token])
    sessions = user.sessions
    #Iterate thru sessions?
    sessions.each do |session|
      if session.delete
        @message = "Sessions"
        render nothing: true, layout: 'application'
      else
        @message = "Error deleting sessions"
        render nothing: true, layout: 'failure'
      end
    end
  end

  def activate
    @user = User.find_by_token(params[:token])
    @session = @user.sessions.find(params[:id])
    @session.assign_attributes(params.permit(:active))

    if @session.save
      render 'sessions/show'
    else
      @message = "Failed to activate a session"
      render nothing: true, layout: 'failure'
    end
    
  end

end