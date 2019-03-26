class TweetsController < ApplicationController
  

  get '/tweets' do
    if is_logged_in?
      @user = current_user
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end
  
    post '/tweet' do
    if !params[:content].empty?
      tweet = Tweet.create(:content => params[:content])
      current_user.tweets << tweet
      current_user.save
      redirect to '/tweets'
    else
      redirect to '/tweets/new'
    end
  end
  
  
   get '/tweets/new' do
    if is_logged_in?
      @user = current_user
      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if is_logged_in?
      @user = current_user
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])
    if is_logged_in? && @tweet.user == current_user
      erb :'/tweets/edit'
    else
      redirect to '/login'
    end
  end

 patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    if !params[:content].empty?
      @tweet.update(:content => params[:content])
      @tweet.save
      redirect to "tweets/#{params[:id]}"
    else
      redirect to "tweets/#{params[:id]}/edit"
    end
  end

  post '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    if current_user == @tweet.user
      @tweet.delete
      redirect to '/tweets'
    else
      redirect to "/tweets/#{params[:id]}"
    end
  end

  
end 