class PeopleController < ApplicationController

def new

end

def create
	@person = Person.new(post_params)

	@person.save
	redirect_to @person
end

def show
  @person = Person.find(params[:id])
end

def index
	@people = Person.all
end

def edit
  @person = Person.find(params[:id])
end

def update
  @person = Person.find(params[:id])
 
  if @person.update(params[:person].permit(:first_name, :last_name, :birth_date, :email))
    redirect_to @person 
  else
    render 'edit'
  end
end

private
	def post_params
		params.require(:people).permit(:first_name, :last_name, :birth_date, :email)
	end
end
