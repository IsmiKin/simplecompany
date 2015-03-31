#configmapper.rb

require_relative 'configvars.rb'
require 'data_mapper' # requires all the gems listed above
require 'dm-migrations'
require 'yaml'

#configdb = YAML.load(ERB.new((File.read('config/database.yml'))).result)["development"]
#configdb = YAML.load((File.read('config/database.yml')))["development"]

#DataMapper.setup(:default, "mysql://#{configdb['username']}:#{configdb['password']}@#{configdb['hostname']}/#{configdb['database']}")
DataMapper.setup(:default, ENV['CLEARDB_DATABASE_URL'])


class Company
  include DataMapper::Resource

  property :idcompany,          Serial  , key: true
  property :name,               String  , required: true  , length: 1..250
  property :address,            Text    , required: true  , length: 1..250
  property :country,            String  , required: true  , length: 1..100
  property :city,               String  , required: true  , length: 1..100
  property :email,              Text    , format: :email_address
  property :phone,              String

  has n, :companybks
end

class Companybk
  include DataMapper::Resource

  property :idcompanybk,        Serial  , key: true
  property :name,               String  , required: true  , length: 1..250
  property :address,            Text    , required: true  , length: 1..250
  property :country,            String  , required: true  , length: 1..100
  property :city,               String  , required: true  , length: 1..100
  property :email,              Text    , format: :email_address
  property :phone,              String
  property :created_at,         DateTime

  belongs_to :company
end

class Person
  include DataMapper::Resource

  property :idperson,           Serial  , key: true
  property :name,               String  , length: 1..250
  property :type,               Text    , required: true  , length: 1..250
  property :passport,           Text    , length: 500000

  has n, :personbks
  belongs_to :company
end

class Personbk
  include DataMapper::Resource

  property :idpersonbk,         Serial  , key: true
  property :name,               String  , length: 1..250
  property :type,               Text    , required: true  , length: 1..250
  property :passport,           Text    , length: 500000
  property :created_at,         DateTime

  belongs_to :person
  belongs_to :company
end

DataMapper.finalize

# Remove comments for first launch
#DataMapper.auto_migrate!
#DataMapper.auto_upgrade!