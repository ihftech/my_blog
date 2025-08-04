module ApplicationHelper

  def gravatar_for(entity, size: 100, default: "identicon")
    email = entity.try(:email) || ""
    hash = Digest::MD5.hexdigest(email.strip.downcase)
    "https://www.gravatar.com/avatar/#{hash}?s=#{size}&d=#{default}"
  end

end
