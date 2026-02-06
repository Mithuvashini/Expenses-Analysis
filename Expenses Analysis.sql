drop database if exists rmc_exp;

Create database if not exists rmc_exp;

 use rmc_exp;
 
CREATE TABLE total_exp (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vch_date DATE,
    particulars VARCHAR(150),
    vch_type VARCHAR(100),
    vch_no VARCHAR(50),
    debit DECIMAL(12,2),
    credit DECIMAL(12,2)
);

select * from total_exp;

create or replace view  expences as
select id,vch_date,particulars,vch_type,vch_no,debit,credit,(debit - credit) as expenses
from total_exp;

create or replace view exp_summary as
select count(id) as total_exp, count(distinct particulars) as count_particulars, count(distinct vch_type) as count_vch_type,
count(distinct vch_no) as count_vch_no,sum(debit) as total_debit, sum(credit) as total_credit,sum(expenses) as total_expenses
from expences;

create or replace view date_wise_exp as
select vch_date,particulars,sum(expenses) as total_exp 
from expences
group by vch_date,particulars
order by vch_date,total_exp desc;

create or replace view Month_wise_exp as
select monthname(vch_date) as month,particulars,sum(expenses) as total_exp 
from expences
group by monthname(vch_date),particulars
order by monthname(vch_date),total_exp desc;

create or replace view particulars_wise_exp as
select particulars,sum(expenses) as total_exp 
from expences
group by particulars
order by total_exp desc;

select * from expences;
select * from exp_summary;
select * from date_wise_exp;
select * from month_wise_exp;
select * from particulars_wise_exp;
