require "sinatra"

def workshops_content(name)
    File.read("workshops/#{name}.txt")

rescue Erno::ENOENT
    return nil
end

def save_work(name,description)
    File.open("workshops/#{name}.txt", "w") do |file|
    file.print(description)
    end
end

get '/' do

    @files = Dir.entries("workshops")
    erb :index

end
get '/create' do
    erb :create
    
end

get '/:name' do
    @name =params[:name]
    @descriptions = workshops_content(@name)
    erb :workshops
end

post '/create' do
    save_work(params["name"],params["description"])
    erb :new
end
