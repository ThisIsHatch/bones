class LoggedInController < ApplicationController
  
  before_filter :require_user
  
end
