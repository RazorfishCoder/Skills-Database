#require 'test_helper'

class LinkedinTest < ActiveSupport::TestCase
  
  test "save linkedin" do
    linkedin = Linkedin.new
    linkedin.api_key = "eA_Uz2aQ8XlzEmiQv5zEcvcM3HYm-PYUghlJTir3FSC9L_Wbq8At_9kSpnj1lZQx"
    linkedin.secret_key = "g2n_LE5xH3Mr1Repvki_imIO7LqvrIfcqwCOCdQRxBJ3JTto434BC3SR8fgijIrT"
    assert linkedin.save
  end
  
end