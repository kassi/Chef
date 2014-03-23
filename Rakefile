require "chef"
require "chef/knife"

defaults = {
  :secret_file => "#{ENV['HOME']}/.chef/encrypted_data_bag_secret"
}

namespace 'databag' do
  desc 'Show encrypted databag'
  task :create, [:databag, :item, :secret_file] do |t, args|
    args.with_defaults defaults
    abort "No databag name specified" unless args.databag

    sh "knife data bag create #{args.databag} #{args.item} -zd --secret-file #{args.secret_file}"

    Rake::Task["databag:edit"].invoke(*args)
  end
  desc 'Edit encrypted databag item.'
  task :edit, [:databag, :item, :secret_file] do |t, args|
    args.with_defaults defaults
    secret = Chef::EncryptedDataBagItem.load_secret args.secret_file
    item_file = "data_bags/#{args.databag}/#{args.item}.json"
    tmp_item_file = "/tmp/#{args.databag}_#{args.item}.json"
    begin
      #decrypt data bag into tmp file
      raw_hash = Chef::JSONCompat.from_json IO.read item_file
      databag_item = Chef::EncryptedDataBagItem.new raw_hash, secret
      IO.write tmp_item_file, Chef::JSONCompat.to_json_pretty( databag_item.to_hash )
      #edit tmp file
      sh "#{ENV['EDITOR']} #{tmp_item_file}"
      #encrypt tmp file data bag into original file
      raw_hash = Chef::JSONCompat.from_json IO.read tmp_item_file
      databag_item = Chef::EncryptedDataBagItem.encrypt_data_bag_item raw_hash, secret
      IO.write item_file, Chef::JSONCompat.to_json_pretty( databag_item )
    ensure
      ::File.delete tmp_item_file #ensure tmp file deleted.
    end
  end
end
