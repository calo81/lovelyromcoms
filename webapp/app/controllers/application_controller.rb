class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :print_params

  private
  def print_params
    puts params.inspect
  end
end
