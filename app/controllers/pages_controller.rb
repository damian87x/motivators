class PagesController < ApplicationController
  def home
    # variable for title definition in helper.
    @title = "Home"

  end

  def about
    @title = "About"
  end
end