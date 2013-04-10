class PagesController < ApplicationController
  def home
    # variable for title definition in helper.
    @title = "home"

  end

  def about
    @title = "about"
  end
end