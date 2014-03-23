# See http://docs.opscode.com/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "ksi"
client_key               "#{current_dir}/ksi.pem"
validation_client_name   "kluks-validator"
validation_key           "#{current_dir}/kluks-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/kluks"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../cookbooks"]

knife[:secret_file] = "#{ENV['HOME']}/.chef/encrypted_data_bag_secret"
