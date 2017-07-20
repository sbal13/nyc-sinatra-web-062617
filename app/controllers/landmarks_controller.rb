class LandmarksController < ApplicationController
	get '/landmarks' do
		@landmarks = Landmark.all
		erb :'landmarks/index'
	end

	get '/landmarks/new' do
		@figures = Figure.all
		erb :'landmarks/new'
	end

	post '/landmarks' do
		@landmark = Landmark.create(params[:landmark])
		if params[:entry_type] == "Create"
			@landmark.figure = Figure.create(params[:figure])
			@landmark.save	
		end	
		redirect "/landmarks/#{@landmark.id}"
	end

	get '/landmarks/:id' do
		@landmark = Landmark.find(params[:id])
		erb :'landmarks/show'
	end

	get '/landmarks/:id/edit' do
		@landmark = Landmark.find(params[:id])
		@figures = Figure.all
		erb :'landmarks/edit'
	end

	post '/landmarks/:id' do
		@landmark = Landmark.find(params[:id])
		@landmark.update(params[:landmark])
		if params[:entry_type] == "Create"
			@landmark.figure = Figure.create(params[:figure])
			@landmark.save	
		end	
		erb :'landmarks/show'
	end

end
