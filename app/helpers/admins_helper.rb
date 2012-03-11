module AdminsHelper
  
  def markdown(text)
    RDiscount.new(text).to_html
  end
  
end