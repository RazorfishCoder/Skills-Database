# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

# We'll need this for the LinkedIn Application
Linkedin.create(:api_key => 'eA_Uz2aQ8XlzEmiQv5zEcvcM3HYm-PYUghlJTir3FSC9L_Wbq8At_9kSpnj1lZQx', :secret_key => 'g2n_LE5xH3Mr1Repvki_imIO7LqvrIfcqwCOCdQRxBJ3JTto434BC3SR8fgijIrT')

# Some sample initial Linkedin Profiles from Razorfish
Employee.create(:linkedin_id => 'h8Q48tjfpC',
                :first_name => 'Brian', 
                :last_name => 'Fletcher',
                :job_title => 'Presentation Layer Architect at Razorfish',
                :industry => 'Internet',
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=45607&authToken=E-rl&authType=name&trk=api*a113222*s121717*')

Employee.create(:linkedin_id => 'ZekjEIF-XL',
                :first_name => 'Steve', 
                :last_name => 'Ebrahimi',
                :job_title => 'Senior Technical Architect and Center of Excellence Lead at Razorfish',
                :industry => 'Internet',
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=5597359&authToken=vXjL&authType=name&trk=api*a113222*s121717*')

Employee.create(:linkedin_id => 'Tzb-cLr90-',
                :first_name => 'Anil', 
                :last_name => 'Mirchandani',
                :job_title => 'Razorfish - Microsoft',
                :industry => 'Information Technology and Services',
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=30963358&authToken=NXO5&authType=name&trk=api*a113222*s121717*')

Employee.create(:linkedin_id => 'iY7PJGFcyp',
                :first_name => 'Todd', 
                :last_name => 'Matthews',
                :job_title => 'Technical Architect for Razorfish and Software Consultant',
                :industry => 'Computer Software',
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=4921540&authToken=gTEc&authType=name&trk=api*a113222*s121717*')

Employee.create(:linkedin_id => 'kFIzlSsMz3',
                :first_name => 'Martin', 
                :last_name => 'Jacobs',
                :job_title => 'Group VP, Technology at Razorfish',
                :industry => 'Information Technology and Services',
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=2653005&authToken=nFPA&authType=name&trk=api*a113222*s121717*')

Employee.create(:linkedin_id => 'NWd9FrVH2R',
                :first_name => 'Billy', 
                :last_name => 'Zane',
                :job_title => 'Self-Promoter at Hollywood',
                :industry => 'Entertainment',
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=95652846&authToken=PSJP&authType=name&trk=api*a113222*s121717*')