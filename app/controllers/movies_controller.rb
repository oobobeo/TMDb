class MoviesController < ApplicationController

	def index
		@movies = Movie.all
	end

	def show
		@movie = Movie.find(params[:id])
		puts '--------------'
		puts @movie.inspect
	end

	def new
		@movie = Movie.new
	end

	def create
		# render plain: params[:movie].inspect
		@movie = Movie.new(movie_params)

		if(@movie.save)
			redirect_to @movie
		else
			render 'new'
		end
	end

	def edit
		@movie = Movie.find(params[:id])
	end

	def update
		@movie = Movie.find(params[:id])
		if(@movie.update(movie_params))
			redirect_to @movie
		else
			render 'edit'
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy

		redirect_to movies_path
	end

	private def movie_params
		params.require(:post).permit(:title)
	end

	def initializeDB(movie_ids)
		puts 'initializing Movie DB'
		movie_ids.each do |data|
			data = JSON.parse data
			id, title = data['id'], data['original_title']
			# How do I save movie data???
			movie = Movie.new({'id' => id, 'title' => title})
			movie.save
			puts movie.inspect
			break
		end
	end

end