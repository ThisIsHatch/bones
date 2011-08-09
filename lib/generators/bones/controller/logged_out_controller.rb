class LoggedOutController < ApplicationController
  
  include LoggedOutHelper
  
  private
  
  def login(user_params)
    @user_session = UserSession.new(user_params)
    if @user_session.save
      @current_user = @user_session.user
      redirect_back_or_default(dashboard_path)
    else
      errors = @user_session.errors[:base]
      flash.now[:error] = "#{errors.join('\\n')}" unless errors.empty?
      render(:template => 'user_sessions/new')
    end
  end
    
end
