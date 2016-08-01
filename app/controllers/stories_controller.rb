class StoriesController < ApplicationController
	before_filter :authenticate_user!, :only => [:edit, :new, :create, :update, :destroy, :awaiting_approval]
	def index
		@stories = Story.where(status: "Approved").all.order("name ASC")
	end

	def search 
		k = params[:keyword].downcase
		if k == "empty"
			@stories = Story.where(status: "Approved").all.order("name ASC")
		else
			@stories = []
			Story.where(status: "Approved").all.each do |s|
				if  s.name != nil and s.name.downcase.include? k
						@stories << s
				end
			end
		end
		respond_to do |format|
			format.html {redirect_to stories_url}
			format.js {}
		end
	end

	def view
		@story = Story.find(params[:id])
	end

	def edit
		@story = Story.find(params[:id])
	end

	def new
		@story = Story.new
	end

	def create 
		user = User.find(current_user)
		s = user.stories.create(params.require(:story).permit(:name, :title, :content)) do |x|
			x.status = "Awaiting Approval"
		end		
		if s.valid?
			flash[:notice] = "Successfully Created Testimony. Awaiting Approval."
			render :js => "window.location = '/stories'"
		else
			flash[:error] = "Error Creating Testimony. Please Fill Out All Fields."
			render "layouts/fail"
		end
	end

	def update

		@story = Story.find(params[:id])
		if current_user.level == "Admin"
			@story.update(params.require(:story).permit(:name, :title, :content, :status))
		else
			@story.update(params.require(:story).permit(:name, :title, :content))
		end

		if @story.valid?
			flash[:notice] = "Successfully Updated Testimony."
			render "layouts/success"
		else
			flash[:error] = "Error Updating Testimony! Make Sure No Field Is Blank!"
			render "layouts/fail"
		end
	end

	def destroy
		@story = Story.find(params[:id])
	  	@story.destroy
	  	redirect_to stories_path	
	end

	def awaiting_approval
		if current_user.level == "Admin"
			@stories = Story.where(status: "Awaiting Approval")
		else
			redirect_to stories_path
		end
		#render "index"
	end
end
