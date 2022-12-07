require 'rails_helper'
RSpec.describe 'タスクモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'タスクのタイトルが空の場合' do
      it 'バリデーションにひっかる' do
        task = Task.new(task_name: '', task_detail: '失敗テスト')
        expect(task).not_to be_valid
      end
    end

    context 'タスクの詳細が空の場合' do
      it 'バリデーションにひっかかる' do
        task = Task.new(task_name: '失敗だろう', task_detail: '')
        expect(task).not_to be_valid
      end
    end

    context 'タスクのタイトルと詳細に内容が記載されている場合' do
      it 'バリデーションが通る' do
        task = Task.new(task_name: '失敗じゃない', task_detail: '失敗じゃない')
        expect(task).to be_valid
      end
    end
  end

  describe '検索機能' do
    let!(:task) { FactoryBot.create(:task) }
    let!(:second_task) { FactoryBot.create(:second_task)}
    let!(:task3){FactoryBot.create(:third_task)}
    let!(:task4){FactoryBot.create(:forth_task)}

    context 'scopeメソッドでタイトルのあいまい検索をした場合' do
      it "検索キーワードを含むタスクが絞り込まれる" do
        expect(Task.search(keyword: 'task')).to include(task)
        expect(Task.search(keyword: 'task')).not_to include(second_task)
        expect(Task.search(keyword: 'task').count).to eq 1
      end
    end

    context 'scopeメソッドでステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        expect(Task.search(status: '完了')).to include(second_task)
        expect(Task.search(status: '完了')).not_to include(task)
        expect(Task.search(status: '完了').count).to eq 1
      end
    end

    context 'scopeメソッドでタイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        expect(Task.search(keyword: '3個',status: '未着手')).to include(task3)
        expect(Task.search(keyword: '3個',status: '未着手')).not_to include(task)
        expect(Task.search(keyword: '3個',status: '未着手').count).to eq 1
      end
    end
  end
end
