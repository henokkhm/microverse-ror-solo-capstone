class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category
  before_action :set_expense, only: %i[show edit update destroy]

  # GET /categories/1/expenses
  def index
    @expenses = @category.expenses
  end

  # GET /categories/1/expenses/1
  def show; end

  # GET /categories/1/expenses/new
  def new
    @expense = @category.expenses.new
  end

  # POST /categories/1/expenses
  def create
    @expense = @category.expenses.new(expense_params)

    if @expense.save
      redirect_to category_expenses_path(@category), notice: 'Expense was successfully created.'
    else
      render :new
    end
  end

  # GET /categories/1/expenses/1/edit
  def edit; end

  # PATCH/PUT /categories/1/expenses/1
  def update
    if @expense.update(expense_params)
      redirect_to category_expenses_path(@category), notice: 'Expense was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1/expenses/1
  def destroy
    @expense.destroy
    redirect_to category_expenses_path(@category), notice: 'Expense was successfully deleted.'
  end

  private

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_expense
    @expense = @category.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount)
  end
end
