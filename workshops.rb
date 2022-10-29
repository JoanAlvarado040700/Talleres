require "sinatra"

def workshops_content(name) #Abrir un archivo usando el metodo File.read
    File.read("workshops/#{name}.txt")

rescue Errno::ENOENT
    return nil
end

def save_work(name,description) #Crear archivos usando el metodo File.open
    File.open("workshops/#{name}.txt", "w") do |file|
    file.print(description)
    end
end

def delete_workshops(name) #Borrar archivo usando el metodo File.delete
    File.delete("workshops/#{name}.txt")
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

get '/:name/edit' do
    @name =params[:name]
    @descriptions = workshops_content(@name)
    erb :edit
end
post '/create' do
    save_work(params["name"],params["description"])
    @message ="agregado exitosamente"
    erb :message
end

delete '/:name' do
    delete_workshops(params[:name])
    @message = "borrado exitosamente"
    erb :message
end

put '/:name' do
    save_work(params[:name], params["description"])
    redirect CGI.escape("/#{params[:name]}")
    
end
