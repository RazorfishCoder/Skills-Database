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
@employee = Employee.create(:linkedin_id => 'h8Q48tjfpC',
                :first_name => 'Brian',
                :last_name => 'Fletcher',
                :job_title => 'Presentation Layer Architect at Razorfish',
                :industry => 'Internet',
                :skill_tags  => [{:name  => 'html', :rate => 9}, {:name => 'css', :rate => 9}, {:name => 'javascript', :rate => 7}],
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=45607&authToken=E-rl&authType=name&trk=api*a113222*s121717*')

Authorization.create(:provider => 'linked_in', :uid => 'h8Q48tjfpC', :employee_id => @employee.id)

@employee = Employee.create(:linkedin_id => 'ZekjEIF-XL',
                :first_name => 'Steve',
                :last_name => 'Ebrahimi',
                :job_title => 'Senior Technical Architect and Center of Excellence Lead at Razorfish',
                :industry => 'Internet',
                :skill_tags  => [{:name  => 'java', :rate => 3}, {:name => 'ruby', :rate => 4}],
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=5597359&authToken=vXjL&authType=name&trk=api*a113222*s121717*')
                
Authorization.create(:provider => 'linked_in', :uid => 'ZekjEIF-XL', :employee_id => @employee.id)                

@employee = Employee.create(:linkedin_id => 'Tzb-cLr90-',
                :first_name => 'Anil',
                :last_name => 'Mirchandani',
                :job_title => 'Razorfish - Microsoft',
                :industry => 'Information Technology and Services',
                :skill_tags  => [{:name  => 'java', :rate => 9}, {:name => '.net', :rate => 6}],
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=30963358&authToken=NXO5&authType=name&trk=api*a113222*s121717*')

Authorization.create(:provider => 'linked_in', :uid => 'Tzb-cLr90-', :employee_id => @employee.id)

@employee = Employee.create(:linkedin_id => 'iY7PJGFcyp',
                :first_name => 'Todd',
                :last_name => 'Matthews',
                :job_title => 'Technical Architect for Razorfish and Software Consultant',
                :industry => 'Computer Software',
                :skill_tags  => [{:name  => 'java', :rate => 10}, {:name => 'ruby', :rate => 7}, {:name => 'css', :rate => 3}],
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=4921540&authToken=gTEc&authType=name&trk=api*a113222*s121717*')

Authorization.create(:provider => 'linked_in', :uid => 'iY7PJGFcyp', :employee_id => @employee.id)

@employee = Employee.create(:linkedin_id => 'kFIzlSsMz3',
                :first_name => 'Martin',
                :last_name => 'Jacobs',
                :job_title => 'Group VP, Technology at Razorfish',
                :industry => 'Information Technology and Services',
                :skill_tags  => [{:name  => 'java', :rate => 8}, {:name => 'php', :rate => 4}],
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=2653005&authToken=nFPA&authType=name&trk=api*a113222*s121717*')

Authorization.create(:provider => 'linked_in', :uid => 'kFIzlSsMz3', :employee_id => @employee.id)

@employee = Employee.create(:linkedin_id => 'NWd9FrVH2R',
                :first_name => 'Billy',
                :last_name => 'Zane',
                :job_title => 'Self-Promoter at Hollywood',
                :industry => 'Entertainment',
                :skill_tags  => [{:name  => 'c#', :rate => 8}, {:name => 'iOS', :rate => 9}],
                :linkedin_url => 'http://www.linkedin.com/profile?viewProfile=&key=95652846&authToken=PSJP&authType=name&trk=api*a113222*s121717*')
                
Authorization.create(:provider => 'linked_in', :uid => 'NWd9FrVH2R', :employee_id => @employee.id)