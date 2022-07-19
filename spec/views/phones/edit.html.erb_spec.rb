require 'rails_helper'

RSpec.describe "phones/edit", type: :view do
  before(:each) do
    @phone = assign(:phone, Phone.create!(
      phone: "MyString",
      country: "MyString",
      user: nil
    ))
  end

  it "renders the edit phone form" do
    render

    assert_select "form[action=?][method=?]", phone_path(@phone), "post" do

      assert_select "input[name=?]", "phone[phone]"

      assert_select "input[name=?]", "phone[country]"

      assert_select "input[name=?]", "phone[user_id]"
    end
  end
end
