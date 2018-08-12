class User < Account
    validates_presence_of :name

    def self.facebook_authenticate(params)
        where(uid: params[:uid]).first_or_create! do |user|
            user.uid = params[:uid]
            user.name = params[:name]
            user.avatar = params[:avatar]
        end
    end

    def self.google_authenticate(params)
        puts "THE IMAGE"
        puts params[:provider_image]
        where(uid: params[:uid]).first_or_create! do |user|
            user.uid = params[:uid]
            user.name = params[:name]
            user.provider_image = params[:provider_image]
            user.email = params[:email]
            user.provider = params[:provider]
        end
    end
end
