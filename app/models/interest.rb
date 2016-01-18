class Interest < ActiveRecord::Base
  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% Class methods
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  # changes the input to lowercase then capitalizes the first letter
  def self.capitalize_first input
    return input unless input.instance_of? String

    input = input.downcase
    input[0] = input[0].capitalize
    input
  end
end
