class AdminController < ApplicationController
  http_basic_authenticate_with :name => "kevin", :password => ENV["PASSWORD"]
  layout false
  def show  
  end 
end