# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Clear the database first
Employee.all().each do |emp|
  emp.destroy!()
end


team = [   {:name =>'Zach'   ,  :email => "brownzach125@gmail.com" } ,    {:name =>'Elizabeth' , :email => "eliz@gmail.com"},
           {:name =>'Jon' ,     :email => "jon@gmail.com"}  ,   {:name =>'Michael'   , :email => "michale@gmail.com"},
           {:name =>'Garret'  , :email => "garret@gmail.com"} ,    {:name =>'Steven'    , :email => "steven@gmail.com"}]

admin = { :name =>'admin' , :email => 'admit20156@gmail.com' , :admin => true}
admin = Employee.create!(admin)

supervisor = { :name =>'Im a supervisor' , :email => 'suadhealth@gmail.com' }
Employee.create!(supervisor)

team.each do |mate|
  admin.employees.create!( mate  )
end