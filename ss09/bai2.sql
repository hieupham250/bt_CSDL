use bai1;

-- 2
create view view_manager_summary as
select manager_id, count(employee_id) as 'total_employees'
from employees
where manager_id is not null
group by manager_id;

-- 3
select * from view_manager_summary;

-- 4
select e.name as 'manager_name', v.total_employees
from employees e
join view_manager_summary v on e.employee_id = v.manager_id;