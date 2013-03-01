require 'data_mapper'

module VCAP
  module Services
    module Redis
      class Node
        class ProvisionedService
          include DataMapper::Resource
          property :name,            String,      :key => true
          property :port,            Integer,     :unique => true
          property :password,        String,      :required => true
          property :plan,            Integer,     :required => true
          property :plan_option,     String,      :required => false
          property :pid,             Integer
          property :memory,          Integer,     :required => true
          property :status,          Integer,     :default => 0
          property :container,       String
          property :ip,              String
        end
      end
    end
  end
end


def load_sqlite(path, node_host)
  ret = []
  DataMapper::setup(:default, path)
  ps = VCAP::Services::Redis::Node::ProvisionedService
  ps.all.each do |svc|
    ret << {
      "name"        => svc[:name],
      "host"        => node_host,
      "port"        => svc[:port],
      "password"    => svc[:password],
    }
  end
  ret
end
