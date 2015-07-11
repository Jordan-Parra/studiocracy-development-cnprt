module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | Studiocracy"
    end
  end
end
