class TasksController < ApplicationController
  def index
    @tasks = Task.all.order(created_at: "DESC")
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
    if params[:expiry_keyword] == "降順"
      @tasks = Task.search(params[:keyword]).expiry_order_desc
    elsif params[:expiry_keyword] == "昇順"
      @tasks = Task.search(params[:keyword]).expiry_order_asc
    else
      @tasks = Task.search(params[:keyword])
    end
    @keyword = params[:keyword]
    @expiry_keyword = params[:expiry_keyword]
    render :index
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    @task = params[:task].permit(:task_name, :task_detail, :expiry_date, :status)
  end
end
