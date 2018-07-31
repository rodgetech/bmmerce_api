class AuthenticateBusinessUser
    prepend SimpleCommand
  
    def initialize(email, password)
      @email = email
      @password = password
    end
  
    def call
      JsonWebToken.encode(
          user_id: user.id, 
          name: user.name, 
          email: user.email, 
          type: 'business', 
          business_id: user.business.id, 
          business_name: user.business.name) if user
    end
  
    private
  
    attr_accessor :email, :password
  
    def user
      business_user = BusinessUser.find_by_email(email)
      return business_user if business_user && business_user.authenticate(password)
  
      errors.add :user_authentication, 'Invalid credentials'
      nil
    end
end