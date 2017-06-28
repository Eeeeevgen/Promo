Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '102839003675100', '942dab595d434238237dab1c3310b95a'
  provider :vkontakte, '6085918', 'IuWw374g6srRMtVa9cRL',
           {
               :scope => 'email',
               :lang => 'en'
           }
end