class TimesheetsController < ApplicationController
  def show
    @current = true;
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = @employee.timesheets.current[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end
  end

  def current
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = @employee.timesheets.current[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end

    redirect_to "/employees/#{@employee.id}/timesheets/#{@timesheet.id}"
  end

  def update

    debugger
    render(:partial => 'editresponse') if request.xhr?
    print params


  end

end
