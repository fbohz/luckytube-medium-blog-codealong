require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end
  
  get "/login" do 
    erb :login
  end 
  
  get "/signup" do 
    erb :signup
  end 
  
  get "/home/:id" do 
    @user = User.find_by_id(params[:id])
    @luckyvideos = @user.luckyvideos
      if @luckyvideos.empty?
        @empty = "You don't have any LuckyVideos! Add one below!"
        @user = User.find_by_id(params[:id])
        erb :home
      else 
        erb :home
      end 
  end 
  
  post '/luckyvideo/:id' do
    @user = User.find_by_id(params[:id])
    @luckyvideo = Luckyvideo.new(params)
    @luckyvideo.save
    @user.luckyvideos << @luckyvideo
    redirect to "/home/#{@user.id}"
  end 
  
  post '/signup' do
    if User.find_by(email: params[:email])
      @error = <<-HTML 
        User with that email already exists. Please <a href='/login'>Login</a>.
      HTML
      erb :'/signup'
    else   
      @user = User.new(params)
      @user.save
      redirect to "/home/#{@user.id}"
    end 
  end 
  
  post '/login' do
    @user = User.find_by(email: params[:email])
    if @user
     redirect to "/home/#{@user.id}"
   else 
     @error = <<-HTML
      Your email was not recognized. Please try again or <a href='/signup'>Sign Up</a>.
      HTML
     erb :'/login'
   end 
    
  end 

end
