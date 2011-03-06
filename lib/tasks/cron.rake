desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  @employees = Employee.all
    puts "About to index #{@employees.length} employees"
    @employees.each do |employee|
      puts "Processing " +  employee.first_name
      employee.skill_tags.each do |skill|
        puts "Processing " +  skill.name
        newskillname = SkillTypes.skillsmap(skill.name)
	if newskillname.nil?
        	newskillname = SkillTypes.skillsmap(skill.name.downcase)
        end
	unless newskillname.nil?
        	puts "changing to " + newskillname
        	skill.name = newskillname
	end
	if skill.rate < 1 or skill.rate > 5
		skill.rate = 1
	end
      end
      employee.update_attributes(employee.skill_tags)
    end
end
