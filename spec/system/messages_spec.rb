require 'rails_helper'

# RSpec.describe "Messages", type: :system do
#   before do
#     # 中間テーブルを作成して、usersテーブルとroomsテーブルのレコードを作成する
#     @room_user = FactoryBot.create(:room_user)
#   end

#   context '投稿に失敗したとき' do
#     it '送る値が空の為、メッセージの送信に失敗すること' do
#       # サインインする
#       sign_in(@room_user.user)

#       # 作成されたチャットルームへ遷移する
#       click_on(@room_user.room.name)

#       # DBに保存されていないことを期待する
#       expect{
#         click_on('send')
#       }.to change{Message.count}.by(0)

#       # 元のページに戻ってくることを期待する
#       expect(current_path).to eq room_messages_path(@room_user.room)

#     end
#   end

#   context '投稿に成功したとき' do
#     it 'テキストの投稿に成功すると、投稿一覧に遷移して、投稿した内容が表示されている' do
#       # サインインする
#       sign_in(@room_user.user)

#       # 作成されたチャットルームへ遷移する
#       click_on(@room_user.room.name)

#       # 値をテキストフォームに入力する
#       msg = Faker::Lorem.sentence
#       fill_in 'message_content', with: msg

#       # 送信した値がDBに保存されていることを期待する
#       expect{
#         click_on('send')
#       }.to change{Message.count}.by(1)

#       # 投稿一覧画面に遷移することを期待する
#       expect(current_path).to eq room_messages_path(@room_user.room)

#       # 送信した値がブラウザに表示されていることを期待する
#       expect(page).to have_content(msg)

#     end
#     it '画像の投稿に成功すると、投稿一覧に遷移して、投稿した画像が表示されている' do
#       # サインインする
#       sign_in(@room_user.user)

#       # 作成されたチャットルームへ遷移する
#       click_on(@room_user.room.name)

#       # 添付する画像を定義する
#       image_path = Rails.root.join('public/images/test_image.png')

#       # 画像選択フォームに画像を添付する
#       attach_file('message_image', image_path, make_visible: true)

#       # 送信した値がDBに保存されていることを期待する
#       expect{
#         click_on('send')
#       }.to change{Message.count}.by(1)

#       # 投稿一覧画面に遷移することを期待する
#       expect(current_path).to eq room_messages_path(@room_user.room)

#       # 送信した画像がブラウザに表示されていることを期待する
#       expect(page).to have_selector('img')

#     end
#     it 'テキストと画像の投稿に成功すること' do
#       # サインインする
#       sign_in(@room_user.user)

#       # 作成されたチャットルームへ遷移する
#       click_on(@room_user.room.name)

#       # 添付する画像を定義する
#       image_path = Rails.root.join('public/images/test_image.png')

#       # 画像選択フォームに画像を添付する
#       attach_file('message_image', image_path, make_visible: true)

#       # 値をテキストフォームに入力する
#       msg = Faker::Lorem.sentence
#       fill_in 'message_content', with: msg

#       # 送信した値がDBに保存されていることを期待する
#       expect{
#         click_on('send')
#       }.to change{Message.count}.by(1)

#       # 投稿一覧画面に遷移することを期待する
#       expect(current_path).to eq room_messages_path(@room_user.room)

#       # 送信した画像がブラウザに表示されていることを期待する
#       expect(page).to have_selector('img')

#       # 送信した画像がブラウザに表示されていることを期待する
#       expect(page).to have_selector('img')

#     end
#   end
# end

RSpec.describe "チャットールームの削除機能", type: :system do
  before do
    @room_user = FactoryBot.create(:room_user)
  end

  it 'チャットルームを削除すると、関連するメッセージがすべて削除されていること' do
    # サインインする
    sign_in(@room_user.user)

    # 作成されたチャットルームへ遷移する
    click_on(@room_user.room.name)

    # メッセージ情報を3つDBに追加する
    # 3.times do
    #   msg = Faker::Lorem.sentence
    #   fill_in 'message_content', with: msg
    #   click_on('send')
    # end
    FactoryBot.create_list(
      :message, 3, room_id: @room_user.room.id, user_id: @room_user.user.id
    )
    expect(Message.count).to eq 3

    # 「チャットを終了する」ボタンをクリックすることで、作成した5つのメッセージが削除されていることを期待する
    click_on('destroy')
    expect(Message.count).to eq 0

    # ルートページに遷移されることを期待する
    expect(current_path).to eq root_path

  end
end