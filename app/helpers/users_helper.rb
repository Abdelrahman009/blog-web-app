module UsersHelper

  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, class: "gravatar",height: '140px',
              width: '140px', style: "border-radius: 50%")
  end

end
