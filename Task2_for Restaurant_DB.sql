use restaurant;


		 --view r.rest_name &i.items_names

		   create view Rest_Items_1 as
		  select
		  r.rest_name,
		  (select STRING_AGG(i.item_name, ' ; ')) as items
		  from rest r, item i, cat c
		  where r.rest_id = c.rest_id and
		  c.cat_id = i.cat_id
		  group by r.rest_name;

 



		 -- number of items in per rest

		 select r.rest_name ,count(i.item_id) 'Number of Items' 
		 from rest r join cat c 
		 on r.rest_id=c.rest_id
		 join item i on c.cat_id=i.cat_id
		 group by r.rest_id,r.rest_name

 



		 --avg # of items per cat

		 select   max(i.item_id)-min(i.item_id)+1 as count_items,max(c.cat_id)-min(c.cat_id)+1 as count_cats ,
		 cast((max(i.item_id)-min(i.item_id)+1)as float)/cast((max(c.cat_id)-min(c.cat_id)+1)as float)as The_AVG
		 from  cat c,item i
   

 


		--L,H avg price item per rest

		select max(r) as H_AVG ,min (r) as L_AVG from(
        select rest_name  ,avg(price) as r
        from item i join cat c
        on i.cat_id=c.cat_id
        join rest r on r.rest_id=c.rest_id
        group by rest_name
            )as Outq
 

		 -- 3rd highest price per rest

        select rest_name,price as "3rd_Highest_price" 
		from (    
        select  rest_name, price , rank() over (partition by rest_name order by price  desc ) as res from
        (        
           select distinct r1.rest_name ,price  
           from rest r1, item i1, cat c1
           where r1.rest_id = c1.rest_id 
           and
           c1.cat_id = i1.cat_id  
         ) as sol
         ) as finalRes
           where res=3

 


          --rest has more than 5 cats
			select   rest_name as r_n ,count(c.cat_id) as cat_count
			from   rest r join cat c
			on r.rest_id=c.rest_id 
			group by rest_name 
			having count(c.cat_id)>5


 

			-- Index Price
            create index price_index
            on item(price);
            DBCC DBREINDEX (item,price_index);

 

 