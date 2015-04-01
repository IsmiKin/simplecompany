# simplecompany.rb
require 'rubygems'
require 'sinatra'
require 'mysql2'
require 'rubygems'
require 'data_mapper' # requires all the gems listed above
require 'json'

require './config/configvars.rb'
require './config/configmapper.rb'

require 'dm-serializer/to_json'
require 'base64'

set :public_folder, File.dirname(__FILE__) + '/assets'

get '/' do
  erb :index
end

# API REST section

# Company

# Get all the companies
get '/api/company/all/' do
  content_type :json
  Company.all.to_json
end

# Get one company by id
get '/api/company/:idcompany' do
  content_type :json

  idcompany = params['idcompany']
  if Company.get(idcompany).nil? || idcompany.nil?
    { :error => 1, :message => "An error occured, check the parameters." }.to_json
  else

  end

end

# Create a new company
post '/api/company/' do
  content_type :json


  puts "Parametros------->> #{params}"
  if params[:name].nil?
    datacomp = JSON.parse(request.body.read)
  else
    datacomp = params
  end

  new_company = Company.create(datacomp)

  new_company.errors.keys.each do |key|
    new_company.errors[key].each do |error|
      logger.info "errors #{key} => #{error}"
    end
  end


  if new_company.saved?
    new_bk = params.clone
    new_bk["created_at"] = Time.now
    new_bk["company_idcompany"] = new_company.attributes[:idcompany]
    Companybk.create(new_bk)

    { :error => 0, :message => "The new company has been created." , :idcompany => new_company.attributes[:idcompany] }.to_json

  else
    { :error => 1, :message => "An error occured, check the parameters." }.to_json
  end
end

# Update an existing company
put '/api/company/' do
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
post '/api/person/' do
  content_type :json


  if params[:type].nil?
    datacomp = JSON.parse(request.body.read)
  else
    datacomp = params
  end

  newperson_data = datacomp.clone

  if datacomp.keys.include?('passport')
    binary_data = Base64.encode64(datacomp[:passport][:tempfile].read)

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