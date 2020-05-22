module ApplicationHelper
  def flash_class(level)
    case level
      when 'notice' then "alert alert-notice"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-error"
      when 'warning' then "alert alert-warning"
    end
  end
end
