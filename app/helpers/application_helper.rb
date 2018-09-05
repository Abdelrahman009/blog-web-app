module ApplicationHelper
  def get_full_title(title = "")
    base = 'TwitterApp'
    return base if title.empty?
    "#{title} #{base}"
  end

  def home_page_view(title)
    if title == "Home" ||
        title == "Help" ||
        title == "About"
      ""
    else
      "hidden"
    end
  end

  def about_page_view(title)
    if title == "Home" ||
        title == "Help" ||
        title == "About"
      ""
    else
      "hidden"
    end
  end
  def help_page_view(title)
    if title == "Home" ||
        title == "Help" ||
        title == "About"
      ""
    else
      "hidden"
    end
  end
  def search_form_view(title)
    if title == "Home" ||
        title == "Help" ||
        title == "About"
      "hidden"
    else
      "none"
    end
  end
end