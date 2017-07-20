class FiguresController < ApplicationController

	get '/figures' do
		@figures = Figure.all
		erb :'figures/index'
	end

	get '/figures/new' do
		@titles = Title.all
		@landmarks = Landmark.all
		erb :'figures/new'
	end

	post '/figures' do

		new_params = params
		new_params[:figure][:title_ids] ||= []
		new_params[:figure][:landmark_ids] ||=[]

		if !params[:title][:name].blank?
			@title = Title.create(new_params[:title])
			new_params[:figure][:title_ids] << @title.id
		end

		if !params[:landmark][:name].blank?
			@landmark = Landmark.create(new_params[:landmark])
			new_params[:figure][:landmark_ids] << @landmark.id
		end

		@figure = Figure.create(name: params[:figure][:name])

		if !new_params[:figure][:title_ids].blank?
			titles = new_params[:figure][:title_ids].map{|title_id| Title.find(title_id)}
			@figure.titles = titles
		end
		if !new_params[:figure][:landmark_ids].blank?
			landmarks = new_params[:figure][:landmark_ids].map{|landmark_id| Landmark.find(landmark_id)}
			@figure.landmarks = landmarks
		end


		redirect "/figures/#{@figure.id}"
	end

	get '/figures/:id' do
		@figure = Figure.find(params[:id])
		erb :'figures/show'
	end

	get '/figures/:id/edit' do
		@figure = Figure.find(params[:id])
		@titles = Title.all
		@landmarks = Landmark.all

		erb :'figures/edit'
	end

	patch '/figures/:id' do
		# @figure = Figure.find(params[:id])
		# @figure.update(params[:figure])


		new_params = params
		new_params[:figure][:title_ids] ||= []
		new_params[:figure][:landmark_ids] ||=[]

		if !params[:title][:name].blank?
			@title = Title.create(new_params[:title])
			new_params[:figure][:title_ids] << @title.id
		end

		if !params[:landmark][:name].blank?
			@landmark = Landmark.create(new_params[:landmark])
			new_params[:figure][:landmark_ids] << @landmark.id
		end

		@figure = Figure.find(params[:id])

		@figure.update(name: new_params[:figure][:name])

		if !new_params[:figure][:title_ids].blank?
			titles = new_params[:figure][:title_ids].map{|title_id| Title.find(title_id)}
			@figure.titles = titles
		end
		if !new_params[:figure][:landmark_ids].blank?
			landmarks = new_params[:figure][:landmark_ids].map{|landmark_id| Landmark.find(landmark_id)}
			@figure.landmarks = landmarks
		end



		@figure.save


		redirect "/figures/#{@figure.id}"
	end




end
