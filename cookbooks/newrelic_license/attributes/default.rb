# sudo apt-get install python-software-properties

newrelic = Chef::EncryptedDataBagItem.load("keys", "newrelic")
default[:newrelic][:license_key] = newrelic["license_key"]
default[:newrelic][:mysql][:servers] = [
  {
    "name"          => newrelic["mysql_name"],
    "host"          => "localhost",
    "metrics"       => "status,newrelic",
    "mysql_user"    => newrelic["mysql_user"],
    "mysql_passwd"  => newrelic["mysql_pass"]
  }]
