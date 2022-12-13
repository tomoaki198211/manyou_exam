class TasksController < ApplicationController
  def index
    @tasks = current_user.tasks.includes(:labels).recent_order.page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
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
    set_search_keyword(@search)
    if @search.present?
      @tasks = current_user.tasks.sort_search(@search).includes(:labels).page(params[:page])
    end
    @tasks ||= current_user.tasks.includes(:labels).recent_order.page(params[:page])
    render :index
  end

  private

  def set_search_keyword(search)
    @keyword = search[:keyword]
    @status = search[:status]
    @sort_keyword = search[:sort_keyword]
    @label_keyword = search[:label_id]
  end

  def search_params
    @search = params.require(:task).permit(:keyword, :status, :sort_keyword, :label_id)
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    @task = params[:task].permit(:task_name, :task_detail, :expiry_date, :status, :priority, :user_id, label_ids: [])
  end
end
