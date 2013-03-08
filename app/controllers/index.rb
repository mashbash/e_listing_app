enable :sessions

get '/' do
  request_token = Etsy.request_token
  session[:request_token]  = request_token.token
  session[:request_secret] = request_token.secret
  redirect Etsy.verification_url
end

get '/authorize' do
  access_token = Etsy.access_token(
    session[:request_token],
    session[:request_secret],
    params[:oauth_verifier]
  )
  @user = User.new(access_token: access_token.token, access_token_secret: access_token.secret)
  @user.save 
  redirect '/home'
  # raise access_token.inspect
  # access_token.token and access_token.secret can now be saved for future API calls

end

get '/home' do
  erb :home
end

post '/search' do
  @searchcategory = params[:category]
  @listings = Etsy::Listing.find_all_active_by_category(@searchcategory, {:limit => 10}) #an array of listings objects
  # p @listings
  # @listings.each do  |l|
  #   p l.title
  #   p l.description
  #   p l.price
  #   p l.currency
  #   p l.quantity
  # end  
  erb :_add_listing,
      :layout => false,
      :locals => {:listings => @listings}
end  
