# sudo apt-get install python-software-properties

newrelic = Chef::EncryptedDataBagItem.load("keys", "newrelic")
default[:newrelic][:license_key] = newrelic["license_key"]
default[:newrelic][:mysql][:servers] = "localhost"
