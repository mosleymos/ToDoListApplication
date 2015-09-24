require 'sinatra'
require "sinatra/activerecord"

# Pour la base de données

require "sqlite3"
require "rake"

set :database, { adapter:"sqlite3", database:"db/todoapp.sqlite3"}

class Todo < ActiveRecord::Base

end


# -- Creation et sauvegarde d'une nouvelle tache dans la base 
post '/' do 
	todo = Todo.create(:text => params[:text])
	todo.status ="1"
	if todo.save 
		status 201
		redirect '/'
	else
		status 412
		redirect '/'
	end
  
end
# -- récupération de toutes les taches enregistrées dans la base de données
get '/' do
	@todos = Todo.all
	erb :index
end

# -- Modification d'une tache

get '/todo/:id' do 
	@todo = Todo.find (params[:id])
	erb :edit
end


put '/todo/:id' do
  todo = Todo.find(params[:id])
  todo.text = (params[:text])
  if todo.save
    redirect '/'
  else
    
    redirect '/'
  end
end

# --- Suppression d'une tache

get '/todo/:id/delete' do
	@todo = Todo.find(params[:id])
	erb :delete
end

delete '/todo/:id' do
Todo.find(params[:id]).destroy
redirect('/')

end

get "/todo/:id/finish" do
	@todo =Todo.find(params[:id])
	@todo.status = 0
	@todo.save	
	redirect '/'
end
