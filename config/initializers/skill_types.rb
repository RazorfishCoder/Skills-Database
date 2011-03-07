class SkillTypes

  @skills_hash = {'Java' => 'Java', 
                	'java' => 'Java', 
              		'.net' => '.net', 
              		'actionscript' => 'ActionScript', 
              		'ActionScript' => 'ActionScript', 
              		'c#' => 'C#', 
              		'C#' => 'C#', 
              		'c++' => 'C++', 
              		'C++' => 'C++', 
              		'css' => 'CSS', 
              		'CSS' => 'CSS', 
              		'flash' => 'Flash', 
              		'Flash' => 'Flash', 
              		'Flex' => 'Flex', 
              		'flex' => 'Flex', 
              		'iOS' => 'iOS', 
              		'jquery' => 'jQuery', 
              		'jQuery' => 'jQuery', 
              		'php' => 'PHP', 
              		'Php' => 'PHP', 
              		'PHP' => 'PHP', 
              		'javascript' => 'JavaScript', 
              		'JavaScript' => 'JavaScript', 
              		'wpf' => 'WPF', 
              		'WPF' => 'WPF', 
              		"ruby" => "Ruby on Rails", 
              		"Ruby on Rails" => "Ruby on Rails" }

  def self.find_skill_match(skill_name)
     return @skills_hash[skill_name]
  end
end
