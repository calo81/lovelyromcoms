module NavigationHelpers
  def path_to(page_name)
    case page_name
      when /the home\s?page/
        '/'
      else
        page_name
    end
  end
end

World(NavigationHelpers)