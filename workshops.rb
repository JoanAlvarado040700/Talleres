require "sinatra"

def workshops_content(name)
    File.read("workshops/#{name}.txt")

rescue Erno::ENOENT
    return nil
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

