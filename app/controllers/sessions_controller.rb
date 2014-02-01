class SessionsController < ApplicationController
    def new
      # renderöi kirjautumissivun
    end

    def create
      # haetaan usernamea vastaava käyttäjä tietokannasta
      user = User.find_by username: params[:username]
      # talletetaan sessioon kirjautuneen käyttäjän id (jos käyttäjä on olemassa)
      if user.nil? or not user.authenticate params[:password]
        redirect_to :back, notice: "username and password do not match"
      else
        session[:user_id] = user.id 
        # uudelleenohjataan käyttäjä omalle sivulleen 
        redirect_to user, notice: "Welcome back!"   
      end
    end

    def destroy
      # nollataan sessio
      session[:user_id] = nil
      # uudelleenohjataan sovellus pääsivulle 
      redirect_to :root
    end
end