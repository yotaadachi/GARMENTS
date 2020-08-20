unless Rails.env.development? || Rails.env.test?
 CarrierWave.configure do |config|
 	config.fog_credentials = {
 		provider: 'AWS',
 		aws_access_key_id: 'AKIATKBIL6RM5DC5LXSF',
 		aws_secret_access_key: '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',
 		region: 'ap-northeast-1'
 	}

 	config.fog_directory = 'garments-photo'
 	config.cache_storage = :fog
 	config.fog_public = false
 end
end