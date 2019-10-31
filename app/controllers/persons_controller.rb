class PersonsController < ApplicationController

	def index
		@persons = Person.all
	end

	def show
		@person = Person.find(params[:id])
		puts '--------------'
		puts @person.inspect
	end

	def new
		@person = Person.new
	end

	def create
		# render plain: params[:person].inspect
		@person = Person.new(movie_params)

		if(@person.save)
			redirect_to @person
		else
			render 'new'
		end
	end

	def edit
		@person = Person.find(params[:id])
	end

	def update
		@person = Person.find(params[:id])
		if(@person.update(person_params))
			redirect_to @person
		else
			render 'edit'
		end
	end

	def destroy
		@person = Person.find(params[:id])
		@person.destroy

		redirect_to persons_path
	end

	private def person_params
		params.require(:post).permit(:name,:department,:character,:job)
	end

end