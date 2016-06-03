class User < ActiveRecord::Base
  # validates :uid, :provider, presence: true
    #:name

    def self.find_or_create_from_omniauth(auth_hash)
      # Find or create a user

      user = self.find_by(uid: auth_hash["uid"], provider: auth_hash["provider"])
      if !user.nil?
        return user
      else
        user = User.new
        user.provider = auth_hash["provider"]
        user.uid = auth_hash["uid"]
        user.name = auth_hash["info"]["display_name"]
        user.email = auth_hash["info"]["email"]
      end
        if user.save
          return user
        else
          return nil
        end
      end

  end
