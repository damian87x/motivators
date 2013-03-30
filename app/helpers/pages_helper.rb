module PagesHelper
  # Returns the full title or basic for all pages
  def title   # Method definition
    base_title = "Motivators - Get inspiration and change your life now!" # Variable assignment
    if @title.nil?   # Boolean test if title empty then only base_title
      base_title    # return base title
    else
      "#{base_title} | #{@title}"   #  else return base_title + @title
    end
  end

  # show root link
  def link_root
    # link whit text "Motivators" and path "/"
    link_to("Motivators", root_path)
  end

end
