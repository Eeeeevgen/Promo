Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'],
           image_size: 'large'
  provider :vkontakte, ENV['VK_API_KEY'], ENV['VK_API_SECRET'],
           scope: 'email',
           image_size: 'original',
           lang: 'en'
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET']
end
