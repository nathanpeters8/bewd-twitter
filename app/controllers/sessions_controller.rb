class SessionsController < ApplicationController
    # POST /sessions
    def create
        # find user by username
        @user = User.find_by(username: params[:user][:username])

        if @user && BCrypt::Password.new(@user.password) == params[:user][:password]
            # create new session
            session = @user.sessions.create

            # set session token in cookie
            cookies.permanent.signed[:twitter_session_token] = {
                value: session.token,
                httponly: true
            }

            # render success response
            render json: {
                success: true
            }
        else
            # render error response
            render json: {
                success: false,
                errors: ["Invalid username or password"]
            }
        end
    end

    # GET /authenticated
    def authenticated
        # find session by token
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        # authenticate user if session found
        if session
            user = session.user

            render json: {
                authenticated: true,
                username: user.username
            }
        # else render unauthenticated
        else
            render json: {
                authenticated: false
            }
        end
    end
    
    # DELETE /sessions
    def destroy
        # find session by token
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        # destroy session if found
        if session and session.destroy
            render json: {
                success: true
            }
        end
    end
end
