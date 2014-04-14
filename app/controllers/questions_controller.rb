class QuestionsController < ApplicationController
  before_filter :authorize, only: [:new, :create, :edit, :update]
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show

  end

  # GET /questions/new
  def new
    @question = Question.new
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    respond_to do |format|
      if @question.save
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PATCH/PUT /questions/1
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
    end
  end

  private
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:question, :user_id)
    end
end
