require 'rspec'
require 'spec_helper'

describe EmployeesController, type: :controller do

  context "as administrator/supervisor" do
    describe "GET #index" do
      it "populates the employees table"
      it "renders the :index view" do
        get :index
        response.should render_template :index
      end
    end

    describe "GET #show" do
      it "assigns the requested employee to @employee" do
        employee = FactoryGirl.create(:employee)
        get :show, id: employee.id
        assigns(:employee).should eq(employee)
      end

      it "renders the #show view" do
        get :show, id: FactoryGirl.create(:employee)
        response.should render_template :show
      end
    end

    describe "GET #new" do
      it "creates a new employee"
    end

    describe "POST create" do
      context "with valid attributes" do
        it "creates a new employee" do
          expect{
            post :create, employee: FactoryGirl.attributes_for(:employee)
          }.to change(Employee,:count).by(1)
        end

        it "redirects to the new employee" do
          post :create, employee: FactoryGirl.attributes_for(:employee)
          response.should redirect_to Employee.last
        end
      end

      context "with invalid attributes" do
        it "does not save the new employee" do
          expect{
            post :create, employee: FactoryGirl.attributes_for(:invalid_employee)
          }.to_not change(Employee,:count)
        end

        it "re-renders the new method" do
          post :create, contact: FactoryGirl.attributes_for(:invalid_contact)
          response.should render_template :new
        end
      end
    end
  end

  context "as regular employee" do
    it "gives a flash notice that you can't be here"
    it "redirects to your current timesheet" do
      get :index
      response.should redirect_to "/employees/#{@current_user.id}/timesheets/1/current"
    end
  end

end