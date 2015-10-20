class YpUserDecorator < UserDecorator
  delegate_all

  def background_check_date_row_class
    ''
  end

  def background_check_date_bg_class
    ''
  end
end
