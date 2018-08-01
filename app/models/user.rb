class User < Account
    validates_presence_of :name, :email
end
