class InstructionsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_instruction, only: [:show, :edit, :update, :destroy]

  # after_action :verify_authorized
  # after_action :verify_policy_scoped

  # GET /instructions
  # GET /instructions.json
  def index
    if params[:user_id]
      @instructions = User.find(params[:user_id]).instructions
      @users = User.all
        if !params[:user].blank? 
          @instructions = Instruction.where(user: params[:user])
        elsif !params[:date].blank?
          if params[:date] == "Today"
            @instructions = Instruction.where(" created_at >=?", Time.zone.today.beginning_of_day)
          else
            @instructions = Instruction.where("created_at <?", Time.zone.today.beginning_of_day)
          end
        end
    else       
        if !params[:query].blank? 
          if params[:query] == "Today"
            @instructions = Instruction.from_today
          elsif params[:query] == "Old Recipes"
            @instructions = Instruction.old_news
          elsif params[:query] == "Most Ingredients"
            @instructions = Instruction.old_news
          elsif params[:query] == "Least Ingredients"
            @instructions = Instruction.old_news
          end
        else
          @instructions = Instruction.all
        end
    end
  end

  # GET /instructions/1
  # GET /instructions/1.json
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
    end
  end

  # POST /instructions
  # POST /instructions.json
  def create
    
    @instruction = Instruction.new(instruction_params)

    respond_to do |format|
      if @instruction.save
        format.html { redirect_to @instruction, notice: 'Instruction was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /instructions/1
  # PATCH/PUT /instructions/1.json
  def update

    respond_to do |format|
      if @instruction.update(instruction_params)
        format.html { redirect_to @instruction, notice: 'Instruction was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /instructions/1
  # DELETE /instructions/1.json
  def destroy
    if !policy(@instruction).destroy?
      redirect_to user_path(current_user.id)
    end
    @instruction.destroy
    respond_to do |format|
      format.html { redirect_to instructions_url, notice: 'Instruction was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_instruction
      @instruction = Instruction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def instruction_params
      params.require(:instruction).permit(:name, :content, :cook_time, :user_id, :ingredient_ids => [], :ingredients_attributes => [:name])
    end
end
