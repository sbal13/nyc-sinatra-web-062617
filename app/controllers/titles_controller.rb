class TitlesController < ApplicationController
	get '/titles' do
		@titles = Title.all
		erb :'titles/index'
	end

	get '/titles/new' do
		erb :'titles/new'
	end

	post '/titles' do
		@title = Title.create(params[:title])
		redirect "/titles/#{@title.id}"
	end

	get '/titles/:id' do
		@title = Title.find(params[:id])
		erb :'titles/show'
	end

	get '/titles/:id/edit' do
		@title = Title.find(params[:id])
		erb :'titles/edit'
	end

	post '/titles/:id' do
		@title = Title.find(params[:id])
		@title.update(params[:title])
		erb :'titles/show'
	end


end
