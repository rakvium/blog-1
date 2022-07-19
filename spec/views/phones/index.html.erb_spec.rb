require 'rails_helper'

RSpec.describe "phones/index", type: :view do
  before(:each) do
    assign(:phones, [
      Phone.create!(
        phone: "Phone",
        country: "Country",
        user: nil
      ),
      Phone.create!(
        phone: "Phone",
        country: "Country",
        user: nil
      )
    ])
  end

  it "renders a list of phones" do
    render
    assert_select "tr>td", text: "Phone".to_s, count: 2
    assert_select "tr>td", text: "Country".to_s, count: 2
    assert_select "tr>td", text: nil.to_s, count: 2
  end
end
