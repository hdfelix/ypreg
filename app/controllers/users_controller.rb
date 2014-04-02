class UsersController < ApplicationController
	def index
		@users = User.all
	end

	def show
		@user = User.find(params[:id])
	end

	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)
		 if @user.save
			 redirect_to users_path, notice: 'New user created.'
		 else
			 render :new
		 end
		#redirect_to users_path
	end

	# Never trust parameters from the scary internet, only allow the white list through.	
	private
	 def user_params
		 params[:user] #.delete :admin unless current_user.try(:admin?)
		 params.require(:user).permit(:firstname, :lastname, :email, :password)#, :password_confirmation, :admin)
	 end
end
