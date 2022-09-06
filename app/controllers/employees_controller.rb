class EmployeesController < ApplicationController
  def index
    # Get all employees data of emps whoms rooms are not alocated
    @Users = Employee.select("full_name", "emp_id", "gender").where("allocated": false)
    render json: @Users
  end
  def update
    # We will get the 3 emp_ids (r1,r2,r3). Update in the Employee Table

  end
end
