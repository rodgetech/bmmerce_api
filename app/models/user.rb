class User < Account
    validates_presence_of :name, :player_id

    def self.facebook_authenticate(params)
        where(uid: params[:uid], provider: "facebook").first_or_create! do |user|
            user.uid = params[:uid]
            user.name = params[:name]
            user.avatar = params[:avatar]
            user.provider = params[:provider]
            user.player_id = params[:player_id]
        end
    end

    def self.google_authenticate(params)
        where(uid: params[:uid], provider: "google").first_or_create! do |user|
            user.uid = params[:uid]
            user.name = params[:name]
            user.provider_image = params[:provider_image]
            user.email = params[:email]
            user.provider = params[:provider]
            user.player_id = params[:player_id]
        end
    end
end
