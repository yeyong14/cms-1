require 'spec_helper'

describe "visits/show" do
  before(:each) do
    @visit = assign(:visit, stub_model(Visit,
      :visit_notes => "MyText",
      :customer_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
