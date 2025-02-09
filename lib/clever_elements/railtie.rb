module CleverElements
  class Railtie < Rails::Railtie
    initializer 'clever_elements.initialize_client' do |app|
      config_file = Rails.root.join 'config', 'clever_elements.yml'
      
      if File.exists?(config_file)
        configuration = YAML.load_file config_file
        
        client = CleverElements::Client.new *configuration.values_at('user_id', 'api_key', 'mode')
        CleverElements::Model.proxy = client.proxy
      else
        Rails.logger.warn 'Could not find a configuration file for CleverElements.'
      end
    end
  end
end