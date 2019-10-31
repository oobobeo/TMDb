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

	def initializeDB(person_ids)
		puts 'initializing Person DB'
		person_ids.each do |data|
			data = JSON.parse data
			id,name,depertment,character,job = data['id'],data['name'],data['department'],data['character'],data['job']
			person = Person.new({'id'=>id,'name'=>name,'department'=>department,'character'=>character,'job'=>job })
			person.save
			puts person.inspect
			break
		end
	end



end