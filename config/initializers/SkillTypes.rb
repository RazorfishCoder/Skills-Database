class SkillTypes
  def self.skillsmap(skillname)
     skillshash = { 'Java' => 'Java', 
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
		'php' => 'PHP', 
		'Php' => 'PHP', 
		'PHP' => 'PHP', 
		'javascript' => 'JavaScript', 
		'JavaScript' => 'JavaScript', 
		'wpf' => 'WPF', 
		'WPF' => 'WPF', 
		"ruby" => "Ruby on Rails", 
		"Ruby on Rails" => "Ruby on Rails" }
     return skillshash[skillname]
  end
end
