
class WelcomeController < ApplicationController
  def index
    #@linkedin = Linkedin.first

    # get your api keys at https://www.linkedin.com/secure/developer
    @client = LinkedIn::Client.new('eA_Uz2aQ8XlzEmiQv5zEcvcM3HYm-PYUghlJTir3FSC9L_Wbq8At_9kSpnj1lZQx', 'g2n_LE5xH3Mr1Repvki_imIO7LqvrIfcqwCOCdQRxBJ3JTto434BC3SR8fgijIrT')
    @rtoken = @client.request_token.token
    @rsecret = @client.request_token.secret

    # then fetch your access keys
    #@client.authorize_from_request(@rtoken, @rsecret)


    #@myProfile = @client.profile.headline


  end
    

end
