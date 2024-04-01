class TweetsController < ApplicationController
    # POST /tweets
    def create
        # retrieve user based on session token
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        # check if session exists
        if session
            # create tweet for user
            user = session.user
            @tweet = user.tweets.create(tweet_params) 

            # render success response
            if @tweet.save
                render 'tweets/create'
            # render not successful response
            else
                render json: { success: false }
            end
        else
            render json: { success: false }
        end
    end

    # DELETE /tweets/:id
    def destroy
        # retrieve user based on session token
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        # check if session exists
        if session
            # retrieve tweet by id
            @tweet = session.user.tweets.find(params[:id])

            # destroy tweet if found
            if @tweet and @tweet.destroy
                render json: { success: true }
            else
                render json: { success: false }
            end
        else
            render json: { success: false }
        end
    end

    # GET /tweets
    def index
        @tweets = Tweet.order(created_at: :desc)
        render 'tweets/index'
    end

    # GET /users/:username/tweets
    def index_by_user
        # retrieve user based on session token
        token = cookies.permanent.signed[:twitter_session_token]
        session = Session.find_by(token: token)

        # find current user's tweets if session exists
        if session
            @tweets = session.user.tweets
            render 'tweets/index'
        # otherwise find user's tweets by username
        else
            user = User.find_by(username: params[:username])
            if user
                @tweets = user.tweets
                render 'tweets/index'
            else
                render json: { success: false }
            end
        end
    end

    # handle tweet parameters
    private

    def tweet_params
        params.require(:tweet).permit(:username, :message)
    end
end
