class UsersController < Clearance::UsersController
    # layout "authentication"
  
    def new
        @user = User.new
    end

    def create #for validation success & failures & using flash message
        user = User.new(user_params)
        if user.save
            flash[:message] = 'Congratulations on signing up!'
            redirect_to '/'
        else
            flash[:message] = 'Incorrect details given!'
            redirect_to '/sign_up'
        end
    end

    def index
        @users = User.all.page params[:page]
    end

    def show
        @user = User.find(params[:id])
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        user = User.find(params[:id])
        if user_params["password"] == ""
            user.update(first_name: user_params["first_name"])
            user.update(last_name: user_params["last_name"])
            user.update(email: user_params["email"])
            user.update(photo: user_params["photo"])
        else
            user.update(user_params)
        end
        byebug
        redirect_back(fallback_location: root_path)
    end

    def destroy
        user = User.find(params[:id])
        user_auth = Authentication.find_by(user_id: user.id)
        user_auth.delete
        user.delete
        redirect_to "/"
    end

    

    private
    def user_params
      params.require(:user).permit(
        :email, 
        :password, 
        :first_name, 
        :last_name, 
        :verify,
        :photo
      )
    end 
end