Rails.application.config.middleware.use OmniAuth::Builder do
  linkedin = Linkedin.first
  provider(:linked_in, linkedin.api_key, linkedin.secret_key) if linkedin
end

class OmniAuth::Strategies::LinkedIn
  def user_hash(access_token)
    person = Nokogiri::XML::Document.parse(@access_token.get('/v1/people/~:(id,first-name,last-name,industry,headline,picture-url,site-standard-profile-request,positions,location)').body).xpath('person')

    positions = []
    person.xpath('positions').children.each{|position| positions << position unless position.blank? }

    hash = {
      :employee => {
        'id' => person.xpath('id').text,
        'first_name' => person.xpath('first-name').text,
        'last_name' => person.xpath('last-name').text,
        'picture_url' => person.xpath('picture-url').text,
        'description' => person.xpath('headline').text,
        'industry' => person.xpath('industry').text,
        'job_title' => person.xpath('headline').text,
        'linkedin_url' => person.xpath('site-standard-profile-request').text,
        'location' => person.xpath('location').xpath('name').text
      },
      'id' => person.xpath('id').text,
      :last_job => positions.first.xpath('company').xpath('name').text
    }
    hash
  end
end

