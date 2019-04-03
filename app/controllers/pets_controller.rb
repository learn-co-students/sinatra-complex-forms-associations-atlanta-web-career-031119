class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'pets/new'
  end

  post '/pets' do 
    @pet = Pet.create(params[:pet])
    if params[:owner][:name] != ""
      @owner = Owner.create(params[:owner])
      @pet.owner = @owner
      @owner.save
      @pet.save
    end
    redirect "/pets/#{@pet.id}"
  end

  
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end
  
  patch '/pets/:id' do
    @pet = Pet.find(params[:id])
    @pet.update(params[:pet])
    if params[:owner][:name] != ""
      @owner = Owner.create(params[:owner])
      @pet.owner = @owner
      @pet.save
    end
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    @owner = Owner.find_by(@pet.owner_id)
    erb :'/pets/show'
  end

  
end
