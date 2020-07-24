require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    it "nameとemail、passwordとpassword_confirmationが存在すれば登録できること" do
      expect(@user).to be_valid
    end

    it "nameが空では登録できないこと" do
      @user.name = nil
      expect(@user.valid?).to eq false
    end

    it "emailが空では登録できないこと" do
      @user.email = nil
      expect(@user.valid?).to eq false
    end

    it "passwordが空では登録できないこと" do
      @user.password = nil
      expect(@user.valid?).to eq false
    end

    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      @user.password_confirmation = ""
      expect(@user.valid?).to eq false
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.password = "abcedf"
      @user.password_confirmation = @user.password
      expect(@user.valid?).to be true
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "abcde"
      @user.password_confirmation = @user.password
      expect(@user.valid?).to be false
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      expect(another_user.valid?).to eq false
    end
  end
end