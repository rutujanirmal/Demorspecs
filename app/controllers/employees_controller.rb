class EmployeesController < ApplicationController
  def index
    # Get all employees data of emps whoms rooms are not alocated
    @Users = Employee.select("full_name", "emp_id", "gender").where("allocated": false)
    render json: @Users
  end
  def update
    # We will get the 3 emp_ids (r1,r2,r3). Update in the Employee Table
    @ids = sortParams
    x = 0
    @ids.each_value do |id|
      x += 1
    end
    if x != 3
      render json: {"result": "Fail"}
    else
      @ids.each_value do |id|
        obj = Employee.find_by(emp_id: id)
        obj.allocated = true
        obj.save!
      end
      render json: {"result": "Successfull"}
    end
  end

  private

  def sortParams
    params.require(:ids).permit(:id1, :id2, :id3)
  end
end
