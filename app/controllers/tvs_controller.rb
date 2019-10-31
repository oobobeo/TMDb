class TvsController < ApplicationController

	def index
		@tvs = TV.all
	end

	def show
		@tv = TV.find(params[:id])
		puts '--------------'
		puts @tv.inspect
	end

	def new
		@tv = TV.new
	end

	def create
		# render plain: params[:tv].inspect
		@tv = TV.new(movie_params)

		if(@tv.save)
			redirect_to @tv
		else
			render 'new'
		end
	end

	def edit
		@tv = TV.find(params[:id])
	end

	def update
		@tv = TV.find(params[:id])
		if(@tv.update(tv_params))
			redirect_to @tv
		else
			render 'edit'
		end
	end

	def destroy
		@tv = TV.find(params[:id])
		@tv.destroy

		redirect_to tvs_path
	end

	private def tv_params
		params.require(:post).permit(:name)
	end

	def initializeDB(tv_ids)
		puts 'initializing TV DB'
		tv_ids.each do |data|
			data = JSON.parse data
			id, name = data['id'], data['name']
			tv = TV.new({'id' => id, 'name' => name})
			# How do I save movie data???
			tv.save
			puts tv.inspect
			break
		end
	end








end
