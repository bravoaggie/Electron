require 'json'

class TimesheetsController < ApplicationController
  def show
    @current = false
    @employee  = Employee.find_by_id(params[:employee_id])
    @payperiods = Payperiod.all
    @timesheet = Timesheet.find_by_id(params[:timesheet_id])
    payperiod = @timesheet.payperiod
    if( Payperiod.find_payperiod(Date.today()) == payperiod )
      @current = true
    end
    @start_date = payperiod.start_date
    @end_date   = payperiod.end_date
    halves = @timesheet.halves
    @first_week  = halves[0]
    @second_week = halves[1]
    @name = @employee.name
    @uid  = @employee.uid
    @total_hours = @timesheet.totalHours
    respond_to do |format|
      format.html
      format.xls { headers["Content-Disposition"] = "attachment; filename=\"timesheet.xls\"" }
    end
  end

  def current
    @employee  = Employee.find_by_id(params[:employee_id])
    @timesheet = @employee.timesheets.current[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!()
    end
    respond_to do |format|
      format.html { redirect_to  employee_timesheet_show_path(@employee, @timesheet) }
      format.xls  { redirect_to  employee_timesheet_show_path(@employee, @timesheet, format: "xls") }
    end
  end

  def update
    @payperiod = Payperiod.find_payperiod(Date.today)
    @employee  = Employee.find_by_uid(session[:user_uid])
    @timesheet = Timesheet.find_by_id(params[:timesheet_id])
    @newtimesheet = ActiveSupport::JSON.decode(request.body.read) #WTF I don't know why I had to resort to this
    @newtimesheet = Timesheet.verifyAndCreate(@newtimesheet , @employee , @payperiod)
    if( @timesheet)

      @timesheet.days = @newtimesheet.days
      @timesheet.save!
      render :partial => 'goodedit'
    else
      render(:partial => 'badedit')
    end
  end

  def select
    @employee = Employee.find_by_id(params[:eid])
    payperiod = Payperiod.find_by_id(params[:pid])
    @timesheet = @employee.timesheets.where("payperiod_id = ?", payperiod)[0]
    if(!@timesheet)
      @timesheet = @employee.timesheets.create!(payperiod: payperiod)
    end
    respond_to do |format|
      format.html { redirect_to  employee_timesheet_show_path(@employee, @timesheet) }
      format.xls  { redirect_to  employee_timesheet_show_path(@employee, @timesheet, format: "xls") }
    end
  end

end

