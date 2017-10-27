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
    1.times do
      @instruction_ingredients = @instruction.instruction_ingredients.build
      @ingredient = @instruction_ingredients.build_ingredient
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
    
    @instruction = Instruction.new(instruction_params)
    @instruction.name.capitalize!

    respond_to do |format|
      if @instruction.save
        format.html { redirect_to @instruction, notice: 'Recipe was successfully created.' }
      else
        format.html { redirect_to new_user_instruction_path(current_user), notice: 'Recipe form was not properly filled out.'}
      end
    end
  end

  # PATCH/PUT /instructions/1
  def update
    @instruction.update(instruction_params)
    @instruction.save
    respond_to do |format|
   
        format.html { redirect_to @instruction, notice: 'Recipe was successfully updated.' }
      # else
      #   format.html {  redirect_to edit_user_instruction_path(current_user, @instruction), notice: 'Recipe was not updated.' }
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

    def instruction_params
      params.require(:instruction).permit(:name, :content, :cook_time, :user_id, :instruction_ingredients_attributes => [:quantity, :ingredient_attributes => [:name, :instruction_ingredients]])
     end
end
