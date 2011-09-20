module ApplicationHelper
  module ApplicationHelper
  #return a title on a per-page basis
  def title

    if @title.nil?
      base_title
    else
      "#{@title}"
    end
  end


end

end
