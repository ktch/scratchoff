module SessionsHelper
  
  def sign_in(admin)
    cookies.permanent.signed[:remember_token] = [admin.id, admin.salt]
    current_admin = admin
  end
  
  def current_admin=(admin)
    @current_admin = admin
  end
  
  def current_admin
    @current_admin ||= admin_from_remember_token
  end
  
  def signed_in?
    !current_admin.nil?
  end
  
  def sign_out
    cookies.delete(:remember_token)
    self.current_admin = nil
  end
  
  private
  
    def admin_from_remember_token
      Admin.authenticate_with_salt(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
end
