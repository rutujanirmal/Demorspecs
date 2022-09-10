class EmployeesController < ApplicationController
  def index
    # Get all employees data of emps whoms rooms are not alocated
    users = Employee.select("full_name", "emp_id", "gender").where("allocated": false)
    render json: users
  end

  def update
    # We will get the 3 emp_ids (r1,r2,r3). Update in the Employee Table
    ids = sortParams
    x = 0
    ids.each_value do |id|
      x += 1
    end
    if x != 3
      render status: 400 , json: {error: "Fail due to number of arguments"}
    else
      ids.each_value do |id|
        obj = Employee.find_by(emp_id: id)
        obj.allocated = true
        obj.save!
      end
      obj = Room.new
      obj.room_mate1, obj.room_mate2, obj.room_mate3 = ids[:id1], ids[:id2], ids[:id3]
      obj.full_name = Employee.find_by(emp_id: ids[:id1]).full_name
      obj.room_number = "A" + obj.room_mate1
      obj.save!
      render status: 200 , json: {result: "Successful"}
    end
  end

  def fetch_details
    # fetch the employee details from the email id provided
    email_id = params[:email].present? ? params[:email] : ""
    if(email_id.match(EMAIL_REGEX))
      user = Employee.select("full_name", "emp_id", "gender","allocated").where(email: email_id ).first
      if(user.present?)
        if(user.allocated)
          render status: 400 , json: {error: "Room already allocated"}
        else
          render status: 200 , json: user.as_json
        end
      else
        render status: 400 , json: {error: "Email Not Found"}
      end
    else
      render status: 400 , json: {error: "Use Joshsoftware email"}
    end
  end

  private

  def sortParams
    params.require(:ids).permit(:id1, :id2, :id3)
  end
end
