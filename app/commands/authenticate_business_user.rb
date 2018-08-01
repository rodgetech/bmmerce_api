class AuthenticateBusinessUser
    prepend SimpleCommand
  
    def initialize(username, password)
      @username = username
      @password = password
    end
  
    def call
      JsonWebToken.encode(
          account_id: user.id, 
          name: user.name, 
          email: user.email, 
          type: 'business', 
          business_id: user.business.id, 
          business_name: user.business.name) if user
    end
  
    private
  
    attr_accessor :username, :password
  
    def user
      business_user = BusinessUser.find_by_username(username)
      return business_user if business_user && business_user.authenticate(password)
  
      errors.add :user_authentication, 'Invalid credentials'
      nil
    end
end