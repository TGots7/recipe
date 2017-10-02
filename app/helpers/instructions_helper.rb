module InstructionsHelper

	def set_instructions(params)
		if !params.blank? 
        if params == "Today"
          @instructions = Instruction.from_today
        elsif params == "Old Recipes"
          @instructions = Instruction.old_news
        elsif params == "Alphabetical"
          @instructions = Instruction.alphabetical
        elsif params == "Alphabetical From Z"
          @instructions = Instruction.alphabetical_from_z
        elsif params == "Most Ingredients"
          @instructions = Instruction.most_ingredients
        elsif params == "Least Ingredients"
          @instructions = Instruction.least_ingredients
        end
      else
        @instructions = Instruction.all
      end
     end
	
end
