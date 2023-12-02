class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update destroy]

  # GET /categories
  def index
    @categories = current_user.categories
  end

  # GET /categories/1
  def show
    category_id = params[:id]
    @category = Category.find_by(id: category_id)
    @expenses = Category.find(params[:id]).expenses.order(created_at: :desc).where(author_id: current_user.id)
    @expenses_sum = @expenses.sum(:amount)
  end

  # GET /categories/new
  def new
    @category = Category.new
    set_icons
  end

  # GET /categories/1/edit
  def edit
    set_icons
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    @category.user = current_user
    set_icons

    if @category.save
      redirect_to categories_url, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /categories/1
  def update
    if @category.update(category_params)
      redirect_to @category, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    puts 'Herrrrrrrrrreeeeeeeeeeeeeeeeeee'
    @category.destroy
    redirect_to categories_url, notice: 'Category was successfully deleted.'
  end

  private

  def set_icons
    @icons = ['🍟', '🏛️', '🍴', '🏠', '🏫', '🗑️', '🧾', '💰', '🍹', '✈️', '🚗', '🚇']
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :icon)
  end
end
