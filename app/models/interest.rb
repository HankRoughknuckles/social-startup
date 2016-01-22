class Interest < ActiveRecord::Base
  #%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  #%% Class methods
  ##%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  def self.autocomplete_results interest_name, exclude
    search(interest_name, exclude).map do |i|
      { label: i.name, value: i.name }
    end
  end


  # returns all interest tags with passed name, except for those in
  # names_to_exclude (an array of strings)
  def self.search name, names_to_exclude
    ActsAsTaggableOn::Tag
      .where("(name ILIKE ?)", "%#{name}%")
      .where.not(name: names_to_exclude)
      .limit(10)
  end


  # changes the input to lowercase then capitalizes the first letter
  def self.capitalize_first input
    return input unless input.instance_of? String

    input = input.downcase
    input[0] = input[0].capitalize
    input
  end
end
