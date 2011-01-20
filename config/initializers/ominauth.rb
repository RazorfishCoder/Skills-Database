Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linked_in, 'eA_Uz2aQ8XlzEmiQv5zEcvcM3HYm-PYUghlJTir3FSC9L_Wbq8At_9kSpnj1lZQx', 'g2n_LE5xH3Mr1Repvki_imIO7LqvrIfcqwCOCdQRxBJ3JTto434BC3SR8fgijIrT'
end

class OmniAuth::Strategies::LinkedIn
  def user_hash(access_token)
    person = Nokogiri::XML::Document.parse(@access_token.get('/v1/people/~:(id,first-name,last-name,industry,headline,picture-url,site-standard-profile-request,positions)').body).xpath('person')
    hash = {
      'id' => person.xpath('id').text,
      'first_name' => person.xpath('first-name').text,
      'last_name' => person.xpath('last-name').text,
      'picture_url' => person.xpath('picture-url').text,
      'description' => person.xpath('headline').text,
      'industry' => person.xpath('industry').text,
      'job_title' => person.xpath('headline').text,
      'linkedin_url' => person.xpath('site-standard-profile-request').text
    }
    hash
  end
end

