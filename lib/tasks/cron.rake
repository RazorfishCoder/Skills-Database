desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
  Rake::Task['normalize_skill_tags'].invoke        
end

desc "Convert each skill tag to appropriate casing"
task :normalize_skill_tags do
  @employees = Employee.all
  puts "Analyzing #{@employees.length} employees"
  
  @employees.each do |employee|
    puts "Processing '#{employee.first_name}'"
    
    employee.skill_tags.each do |skill|
      puts "Checking '#{skill.name}'" 
      
      # Attempt to find exact match on an employee's skill
      new_skill_name = SkillTypes.find_skill_match(skill.name)
      
      # If there is no match...attempt to downcase the entire skill and find it again
	    if new_skill_name.nil?	      
        new_skill_name = SkillTypes.find_skill_match(skill.name.downcase)
      end
      
      # If there is a match...go ahead and replace the name    
	    unless new_skill_name.nil?
        puts "Normalizing '#{skill.name}' to '#{new_skill_name}'"
        skill.name = new_skill_name
	    end	
	    
	    # Lastly, if the skill rating is out the 1..5 bounds then set it to 1 
	    if skill.rate < 1 or skill.rate > 5
		    skill.rate = 1
	    end
	
    end
    
    # Update the employees skills
    employee.update_attributes(employee.skill_tags)
  end
end