class UsersController < ApplicationController
    # POST /users
    def create
        # Create a new user
        @user = User.new(user_params)

        # If the user is saved successfully, return the user
        if @user.save
            render json: { 
                user: { 
                    username: @user.username, 
                    email: @user.email
                }
            } 
        # If the user is not saved successfully, return success: false
        else
            render json: {
                success: false,
            }
        end
    end

    # handle user parameters
    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end
end
