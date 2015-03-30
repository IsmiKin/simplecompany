# simplecompany.rb
require 'rubygems'
require 'sinatra'
require 'mysql2'
require 'rubygems'
require 'data_mapper' # requires all the gems listed above
require 'json'
require_relative 'config/configvars.rb'
require_relative 'config/configmapper.rb'
require 'dm-serializer/to_json'
require 'base64'


# retrieve database info
configdb = YAML.load((File.read('config/database.yml')))["development"]

# API REST section

# Company

# Get all the companies
get '/company/all/' do
  content_type :json
  Company.all.to_json
end

# Get one company by id
get '/company/:idcompany' do
  content_type :json

  idcompany = params['idcompany']
  if Company.get(idcompany).nil? || idcompany.nil?
    { :error => 1, :message => "An error occured, check the parameters." }.to_json
  else

  end

end

# Create a new company
post '/company/' do
  content_type :json

  new_company = Company.create(params)

  if new_company.saved?
    new_bk = params.clone
    new_bk["created_at"] = Time.now
    new_bk["company_idcompany"] = new_company.attributes[:idcompany]
    Companybk.create(new_bk)
    { :error => 0, :message => "The new company has been created." }.to_json
  else
    { :error => 1, :message => "An error occured, check the parameters." }.to_json
  end
end

# Update an existing company
put '/company/' do
  content_type :json

  company_updated = Company.update(params)

  if company_updated
    new_bk = params.clone
    new_bk["created_at"] = Time.now
    new_bk["company_idcompany"] =params["idcompany"]
    new_bk.delete("idcompany")
    Companybk.create(new_bk)
    { :error => 0, :message => "The new company has been created." }.to_json
  else
    { :error => 1, :message => "An error occured, check the parameters." }.to_json
  end

end

# Create a new company
post '/person/' do
  content_type :json

  newperson_data = params.clone
  binary_data = Base64.encode64(params[:passport][:tempfile].read)
  if params.keys.include?('passport')
    newperson_data["passport"] =  String(binary_data)
  else
    newperson_data.delete("passport")
  end

  newperson_data["company_idcompany"]=newperson_data["company"]
  newperson_data.delete("company")

  new_person = Person.create(newperson_data)

  # Versioning

  if new_person.saved?
    new_bk = newperson_data.clone
    new_bk["created_at"] = Time.now
    new_bk["person_idperson"] = new_person.attributes[:idperson]
    Personbk.create(new_bk)
    { :error => 0, :message => "The new person has been created." }.to_json
  else
    { :error => 1, :message => "An error occured, check the parameters." }.to_json
  end

end