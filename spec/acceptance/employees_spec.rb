require 'rails_helper'
require 'rspec_api_documentation/dsl'
resource 'Employees' do
  explanation "Employees resource"
  header "Content-Type", "application/json"
  
  get '/employees' do
    context '200' do
      before do
        e = Employee.new(full_name: "Rutuja Nirmal", emp_id: 13, gender: 'F')
        e.save!
      end
      example_request 'Getting a list of employees' do
        expect(status).to eq(200)
      end
    end
  end

  get '/empdetails' do
    parameter :email, "Email ID"
    context '200' do
      before do
        e = Employee.new(full_name: "Rutuja Nirmal", emp_id: 13, gender: 'F',email: 'rutuja.nirmal@joshsoftware.com')
        e.save!
      end
      example_request 'Get employee details using email' do
        do_request :email => "rutuja.nirmal@joshsoftware.com"
        response_headers["Content-Type"].should eq("application/json; charset=utf-8")
        status.should eq(200)
        response_body.should eq('{"full_name":"Rutuja Nirmal","emp_id":"13","gender":"F","allocated":false,"id":null}')
      end
    end 
    
    context '400' do
      before do
        e = Employee.new(full_name: "Rutuja Nirmal", emp_id: 13, gender: 'F',email: 'rutuja.nirmal@joshsoftware.com')
        e.save!
      end
      example_request 'Empty/Different domain email' do
        do_request :email => ""
        response_headers["Content-Type"].should eq("application/json; charset=utf-8")
        status.should eq(400)
        response_body.should eq('{"error":"Use Joshsoftware email"}')
      end
    end 

    context '400' do
      before do
        e = Employee.new(full_name: "Rutuja Nirmal", emp_id: 13, gender: 'F',email: 'rutuja.nirmal@joshsoftware.com')
        e.save!
      end
      example_request 'Email not found' do
        do_request :email => "rutuja.nirmal@joshsoftware.digital"
        response_headers["Content-Type"].should eq("application/json; charset=utf-8")
        status.should eq(400)
        response_body.should eq('{"error":"Email Not Found"}')
      end
    end 
    
  end
end