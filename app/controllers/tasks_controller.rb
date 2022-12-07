class TasksController < ApplicationController
  def index
    @tasks = Task.all.recent_order
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to tasks_path, notice:"登録しました"
    else
      render :new
    end
  end

  def show
    set_task
  end

  def edit
    set_task
  end

  def update
    set_task
    if @task.update(task_params)
      redirect_to tasks_path, notice:"更新しました"
    else
      render :edit
    end
  end

  def destroy
    set_task
    if @task.destroy
      redirect_to tasks_path, notice:"削除しました"
    end
  end

  def search
    search_params
    if @search.present?
      @tasks = Task.sort_search(@search)
    end
    @keyword = @search[:keyword]
    @status = @search[:status]
    @expiry_keyword = @search[:expiry_keyword]
    render :index
  end

  private

  def search_params
    @search = params.require(:task).permit(:keyword, :status, :expiry_keyword)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    @task = params[:task].permit(:task_name, :task_detail, :expiry_date, :status)
  end
end
