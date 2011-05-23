require "spec_helper"

describe UsersHelper do
  include Devise::TestHelpers
  let(:user) { Factory.create(:endless_user) }
  context "logged in" do
    before do
      sign_in user
      @user = user
    end

    it "activates the edit_account link" do
      helper.user_show_submenu(:edit).should match(content_tag(:li, link_to(t("users.edit_account"), edit_user_registration_path), :class => "active"))
    end
  end
  context "not logged in" do
    before do
      @user = user
    end
    it "activates the detail link" do
      helper.user_show_submenu(:detail).should match(content_tag(:li, link_to(t("users.detail"), user_path(:id => @user.id)), :class => "active"))
    end
    it "activates the reputation link" do
      helper.user_show_submenu(:reputation).should match(content_tag(:li, link_to(t("users.reputation.history"), reputation_user_path(@user)), :class => "active"))
    end
    it "activates the favourites link" do
      helper.user_show_submenu(:favourites).should match(content_tag(:li, link_to(t("users.favourites"), user_favourites_path(@user)), :class => "active"))
    end
  end
  
  describe "user_submenu" do
    it "activates the winner's link" do
      helper.user_submenu(:winner).should match(content_tag(:li, link_to(t("users.winner"), users_path(:page => nil)), :class => "active"))
    end
    it "activates the who_is_online link" do
      helper.user_submenu(:who_is_online).should match(content_tag(:li, link_to(t("users.who_is_online"), who_is_online_users_path), :class => "active"))
    end
  end

end
