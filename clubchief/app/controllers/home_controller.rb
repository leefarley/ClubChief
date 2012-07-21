class HomeController < ApplicationController

  def main
  end

  def login  
  	respond_to do |format|
    	format.html { redirect_to login_path}
  	end
  end
end
