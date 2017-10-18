extra.md
class InstructionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_instruction, only: [:show, :edit, :update, :destroy]

  # GET /instructions
  def index
      if params[:user_id]
        @instructions = User.find(params[:user_id]).instructions
      else    
        @instructions = set_instructions(params[:query])
      end
  end

  # GET /instructions/1
  def show
    
  end

  # GET /instructions/new
  def new
    @instruction = Instruction.new
    6.times do
      @instruction.ingredients.build
    end
  end

  # GET /instructions/1/edit
  def edit
    if !policy(@instruction).update?
      redirect_to welcome_path(current_user.id)
    else 
      4.times do
      @instruction.ingredients.build
      end
      render :edit
    end
  end

  # POST /instructions
  def create
    raise params.inspect
    @instruction = Instruction.new(:name => params[:instruction][:name], :content => params[:instruction][:content], :cook_time => params[:instruction][:cook_time], :user_id => params[:instruction][:user_id])
    @instruction.name.capitalize!

    respond_to do |format|
      if @instruction.save

      if params[:instruction][:ingredients]
          params[:instruction][:ingredients].each do |ingredients_attributes|
            if ingredients_attributes[:name].present?
              ingredient = Ingredient.find_by(id: ingredients_attributes[:name])
              newItoI = InstructionIngredient.create(instruction_id: @instruction.id, ingredient_id: ingredients_attributes[:name], quantity: ingredients_attributes[:quantity])
            end
          end
      end
      if params[:instruction][:new_ingredients]
          params[:instruction][:new_ingredients].each do |ingredients_attributes|
            if ingredients_attributes[:name].present?
              nameIng = ingredients_attributes[:name].capitalize!
              ingredient = Ingredient.find_or_create_by(name: nameIng)
              ingredient.save
              newItoI = InstructionIngredient.create(instruction_id: @instruction.id, ingredient_id: ingredient.id, quantity: ingredients_attributes[:quantity])
            end
          end
      end
       
        format.html { redirect_to @instruction, notice: 'Recipe was successfully created.' }
      else
        format.html { redirect_to new_user_instruction_path(current_user), notice: 'Recipe form was not properly filled out.'}
      end
    end
  end

  # PATCH/PUT /instructions/1
  def update
    
    respond_to do |format|
      if @instruction.update(:name => params[:instruction][:name], :content => params[:instruction][:content], :cook_time => params[:instruction][:cook_time], :user_id => params[:instruction][:user_id])
          if params[:instruction][:instruction_ingredients]
            params[:instruction][:instruction_ingredients].each do |ingredients_attributes|
            if ingredients_attributes[:id].present?
                ingredient = InstructionIngredient.find_by(id: ingredients_attributes[:id])
                ingredient.update(quantity: ingredients_attributes[:quantity])
                ingredient.save
            end
          end        
      if params[:instruction][:new_ingredients]
          params[:instruction][:new_ingredients].each do |ingredients_attributes|
            if ingredients_attributes[:name].present?
              nameIng = ingredients_attributes[:name].capitalize!
              if ingredient = Ingredient.find_by(name: nameIng)
                  int = @instruction.ingredients.select { |object| object.id == ingredient.id }
                  if int
                    binding.pry
                    format.html { redirect_to edit_user_instruction_path(current_user, @instruction), notice: 'You already have that ingredient' }
                    else
                    newItoI = InstructionIngredient.create(instruction_id: @instruction.id, ingredient_id: ingredient.id, quantity: ingredients_attributes[:quantity])
                  end
              else ingredient = Ingredient.create(name: ingredients_attributes[:name])
                  ingredient.save
                  newItoI = InstructionIngredient.create(instruction_id: @instruction.id, ingredient_id: ingredient.id, quantity: ingredients_attributes[:quantity])
              end
            end
          end
      end
    end
        format.html { redirect_to @instruction, notice: 'Recipe was successfully updated.' }
      else
        format.html {  redirect_to edit_user_instruction_path(current_user, @instruction), notice: 'Recipe was not updated.' }
      end
    end
  end

  # DELETE /instructions/1
  def destroy
    if !policy(@instruction).destroy?
      redirect_to user_path(current_user.id)
    end
    @instruction.destroy
    respond_to do |format|
      format.html { redirect_to instructions_url, notice: 'Recipe was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instruction
      @instruction = Instruction.find(params[:id])
    end

    # def instruction_params
    #   params.require(:instruction).permit(:name, :content, :cook_time, :user_id, :ingredient_ids => [], :ingredients_attributes => [:name, :organic, :quantity])
    # end
end