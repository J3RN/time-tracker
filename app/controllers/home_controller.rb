class HomeController < ApplicationController
  def index
    if user_signed_in?
      redirect_to time_entries_url
    end
  end
end
