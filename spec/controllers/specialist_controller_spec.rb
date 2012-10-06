require "spec_helper"

describe "Specialist Controller" do

  integrate_views
  fixtures :service_types

  it "should render specialist form" do
  end

  it "should redirect to success page after save" do
    Specialist.
    post 'create'
  end

end