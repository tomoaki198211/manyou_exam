require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task){FactoryBot.create(:task)}
  let!(:task2){FactoryBot.create(:second_task)}
  let!(:task3){FactoryBot.create(:third_task)}
  let!(:task4){FactoryBot.create(:forth_task)}

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        date = Date.new(2021,10,17)
        visit new_task_path
        fill_in "タスク名", with: 'updated_1'
        fill_in "内容", with: 'updated_2'
        fill_in "終了期限", with: date
        select '着手中', from: 'ステータス'
        click_button "登録する"
        expect(page).to have_content 'updated_1'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task_name'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        visit tasks_path
        task_list = all('.task_row')
        expect(task_list.first).to have_content '4個'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が遅いタスクが一番上に表示される' do
        visit tasks_path
        select '降順', from: '終了期限ソート'
        click_button "検索"
        task_list = all('.task_row')
        expect(task_list.first).to have_content 'test_task_detail'
      end
    end
  end

  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it '該当タスクの内容が表示される' do
        task2
        visit task_path(task2)
        expect(page).to have_content '2個'
       end
     end
  end

  describe '検索機能' do

    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'タスク名', with: 'ダンス'
        click_button "検索"
        expect(page).to have_content 'ダンス'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select '着手中', from: 'ステータス'
        click_button "検索"
        expect(page).to have_content 'test_task_name'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'タスク名', with: 'ラスク'
        select '未着手', from: 'ステータス'
        click_button "検索"
        expect(page).to have_content 'ラスク'
      end
    end
  end
end
