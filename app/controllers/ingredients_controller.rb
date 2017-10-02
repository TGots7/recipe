class IngredientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ingredient, only: [:show, :edit, :update, :destroy]

  # GET /ingredients
  # GET /ingredients.json
  def index
    if !params[:query].blank? 
        if params[:query] == "Alphabetical"
            @ingredients = Ingredient.alphabetical
        elsif params[:query] == "Alphabetical From Z"
            @ingredients = Ingredient.alphabetical_from_z
        elsif params[:query] == "Most Recipes"
            @ingredients = Ingredient.most_recipes
        elsif params[:query] == "Least Recipes"
           @ingredients = Ingredient.least_recipes
        end
      else
        @ingredients = Ingredient.all
      end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
  end

  # GET /ingredients/new
  def new
    @ingredient = Ingredient.new
  end

  # GET /ingredients/1/edit
  def edit
    if !policy(@ingredient).update?
      redirect_to user_path(current_user.id)
    end
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.name.capitalize! #@ingredient.name.capitalize

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /ingredients/1
  # PATCH/PUT /ingredients/1.json
  def update
    respond_to do |format|
      if @ingredient.update(ingredient_params)
        format.html { redirect_to @ingredient, notice: 'Ingredient was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    if !policy(@ingredient).destroy?
      redirect_to user_path(current_user.id)
    end
    @ingredient.destroy
    respond_to do |format|
      format.html { redirect_to ingredients_url, notice: 'Ingredient was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ingredient
      @ingredient = Ingredient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
end
