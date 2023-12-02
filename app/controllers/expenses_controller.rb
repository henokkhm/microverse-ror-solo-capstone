class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_categories
  before_action :set_category
  before_action :set_expense, only: %i[edit update destroy]

  # GET /categories/1/expenses/new
  def new
    @expense = Expense.new
    @expense.categories << Category.find(params[:category_id]) if params[:category_id].present?
    set_categories
  end

  # POST /categories/1/expenses
  def create
    @expense = @category.expenses.new(expense_params)
    @expense.author = current_user

    if @expense.save
      redirect_to category_path(@category), notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  # GET /categories/1/expenses/1/edit
  def edit
    set_categories
  end

  # PATCH/PUT /categories/1/expenses/1
  def update
    if @expense.update(expense_params)
      redirect_to category_path(@category), notice: 'Expense was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1/expenses/1
  def destroy
    @expense.destroy
    redirect_to category_path(@category), notice: 'Expense was successfully deleted.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_categories
    @categories = Category.all.order(created_at: :desc).where(user_id: current_user.id)
  end

  def set_expense
    @expense = @category.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount, category_ids: [])
  end
end
