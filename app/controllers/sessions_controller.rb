class SessionsController < ApplicationController
  
	def create
    @user = User.find_by_token(params[:token])
    @course = @user.courses.find(params[:course_id])
    @session = @course.sessions.new(name: params[:name], date: params[:date], active: params[:active], allow_anonymous: params[:allow_anonymous])

    if @session.save
      render 'sessions/create'
    else
      @message = "Failed to create a session"
      render nothing: true, layout: 'failure'
    end

  end

  def show
    if(params[:anonymous] == "true")
      @session = Session.find_by_token(params[:id])
      
      if(@session.present?)
        render 'sessions/show'
      else
        @message = "Session not found"
        render nothing: true, layout: 'failure'
      end
    else
      @user = User.find_by_token(params[:token])
      @course = @user.courses.find(params[:course_id])
      @session = @course.sessions.find(params[:id])
      if(@session.present?)
        render 'sessions/show'
      else
        @message = "No Sessions"
        render nothing: true, layout: 'failure'
      end
    end
  end

  def index
    @user = User.find_by_token(params[:token])

    if(params[:course_id].present?)
      @course = @user.courses.find(params[:course_id])
      @sessions = @course.sessions
    else
      @sessions = @user.sessions
    end

    render 'sessions/index'
  end


  def update

    @user = User.find_by_token(params[:token])
    @session = @user.sessions.find(params[:id])

    @session.assign_attributes(params.permit(:name, :date, :course_id, :active, :allow_anonymous))

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
    @session.active = params[:active]

    if @session.save
      render 'sessions/show'
    else
      @message = "Failed to activate a session"
      render nothing: true, layout: 'failure'
      
    end
    
  end

end