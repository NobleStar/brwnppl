if Rails.env.production?
  ENV['APP_URL']              = 'http://brwnppl.herokuapp.com'

  # Facebook
  ENV['FACEBOOK_APP_KEY']     = '335259899881893'
  ENV['FACEBOOK_SECRET_KEY']  = '36c6a1f3d7e5f0c515b860b03ae9c36f'

  # Twitter
  ENV['TWITTER_APP_KEY']      = 'oSHCdhFySVK9AKu35hF9w'
  ENV['TWITTER_SECRET_KEY']   = '22FAKjS17wfl1svhMggdPs5yCGn8HxaAOdeNFyfKlsc'
  ENV['TWITTER_OAUTH_TOKEN']  = '23608012-AHqp6bV1Krzi6d2gTMdnrHGBmQmc6pMp33HoosvQ2'
  ENV['TWITTER_OAUTH_SECRET'] = 'cjO4Uz9nvF4wWw52mVokObmmnFjrhb96U3L4nTQeyE'

elsif Rails.env.development?
  ENV['APP_URL']              = 'http://lvh.me:3000'

  # Facebook
  ENV['FACEBOOK_APP_KEY']     = '326246034130327'
  ENV['FACEBOOK_SECRET_KEY']  = 'cac30ca1574b810cd0dc63bb24806286'

  # Twitter
  ENV['TWITTER_APP_KEY']      = 'jTFQ5sKUJmoixLlOmfFTMw'
  ENV['TWITTER_SECRET_KEY']   = 'qpX5G9aSfhToIvwg8J9ydeL74sPKthJ977hQnKocp8'
  ENV['TWITTER_OAUTH_TOKEN']  = '23608012-eOC1FeiwEGdD5F8D5vsF7OGyG03q2GI1Yx1eKOmkM'
  ENV['TWITTER_OAUTH_SECRET'] = 'LNcNbXuHoD4gi1Ch8H8V9okjR4LZTDvDbbYgJqypQ'

end
  