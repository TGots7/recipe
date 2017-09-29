class InstructionsController < ApplicationController
  before_action :set_instruction, only: [:show, :edit, :update, :destroy]
  after_action

  # GET /instructions
  # GET /instructions.json
  def index
    if params[:user_id]
      @instructions = User.find(params[:user_id]).instructions
    else
      @instructions = Instruction.all
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
      redirect_to root_path
    end
  end

  # POST /instructions
  # POST /instructions.json
  def create
    
    @instruction = Instruction.new(instruction_params)

    respond_to do |format|
      if @instruction.save
        format.html { redirect_to @instruction, notice: 'Instruction was successfully created.' }
        format.json { render :show, status: :created, location: @instruction }
      else
        format.html { render :new }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructions/1
  # PATCH/PUT /instructions/1.json
  def update

    respond_to do |format|
      if @instruction.update(instruction_params)
        format.html { redirect_to @instruction, notice: 'Instruction was successfully updated.' }
        format.json { render :show, status: :ok, location: @instruction }
      else
        format.html { render :edit }
        format.json { render json: @instruction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructions/1
  # DELETE /instructions/1.json
  def destroy
    if !policy(@instruction).update?
      redirect_to root_path
    end
    @instruction.destroy
    respond_to do |format|
      format.html { redirect_to instructions_url, notice: 'Instruction was successfully destroyed.' }
      format.json { head :no_content }
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
