Select * 
from [Portfolio Project 2].dbo.[Nashvile Housing]
where PropertyAddress is null

	Select newsalesdate, CONVERT(date,saledate)
	from [Portfolio Project 2].dbo.[Nashvile Housing]

update [Portfolio Project 2].dbo.[Nashvile Housing]
set saledate =  CONVERT(date,saledate)
	
alter table [Portfolio Project 2].dbo.[Nashvile Housing]
Add newsalesdate date;

update [Portfolio Project 2].dbo.[Nashvile Housing]
set newsalesdate  =  CONVERT(date,saledate)

Select *
from [Portfolio Project 2].dbo.[Nashvile Housing]
where PropertyAddress is null
order by ParcelID


 select len(propertyaddress)
from [Portfolio Project 2].dbo.[Nashvile Housing]


select a.ParcelID,a.PropertyAddress,b.PropertyAddress,b.ParcelID
from [Portfolio Project 2].dbo.[Nashvile Housing] a
join [Portfolio Project 2].dbo.[Nashvile Housing] b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
from [Portfolio Project 2].dbo.[Nashvile Housing] a
join [Portfolio Project 2].dbo.[Nashvile Housing] b
on a.ParcelID = b.ParcelID
and a.[UniqueID ] <> b.[UniqueID ]
where a.PropertyAddress is null



Select *
from [Portfolio Project 2].dbo.[Nashvile Housing]

select 
SUBSTRING(propertyaddress,1,CHARINDEX(',',propertyaddress) -1) as address,
SUBSTRING(propertyaddress,CHARINDEX(',',propertyaddress) +1,len(propertyaddress) )as address
from [Portfolio Project 2].dbo.[Nashvile Housing]

alter table [Portfolio Project 2].dbo.[Nashvile Housing]
add propertysplitaddress nvarchar(255);

update  [Portfolio Project 2].dbo.[Nashvile Housing]
set propertysplitaddress = SUBSTRING(propertyaddress,1,CHARINDEX(',',propertyaddress) -1)

alter table [Portfolio Project 2].dbo.[Nashvile Housing]
add propertycityaddress nvarchar(255);


update  [Portfolio Project 2].dbo.[Nashvile Housing]
set propertycityaddress = SUBSTRING(propertyaddress,CHARINDEX(',',propertyaddress) +1,len(propertyaddress) )



select 
parsename(replace(owneraddress,',','.'),3),
parsename(replace(owneraddress,',','.'),2),
parsename(replace(owneraddress,',','.'),1)
from [Portfolio Project 2].dbo.[Nashvile Housing]

alter table [Portfolio Project 2].dbo.[Nashvile Housing]
add ownersplitaddress nvarchar(255);

update  [Portfolio Project 2].dbo.[Nashvile Housing]
set ownersplitaddress = parsename(replace(owneraddress,',','.'),3)

alter table [Portfolio Project 2].dbo.[Nashvile Housing]
add ownersplitcity nvarchar(255);


update  [Portfolio Project 2].dbo.[Nashvile Housing]
set ownersplitcity = parsename(replace(owneraddress,',','.'),2)

alter table [Portfolio Project 2].dbo.[Nashvile Housing]
add ownersplitstate nvarchar(255);

update  [Portfolio Project 2].dbo.[Nashvile Housing]
set ownersplitstate =parsename(replace(owneraddress,',','.'),1)

Select distinct SoldAsVacant,COUNT(SoldAsVacant)
from [Portfolio Project 2].dbo.[Nashvile Housing] 
group by SoldAsVacant
order by 2


select SoldAsVacant,
case when  SoldAsVacant = 'Y' then 'YES'
     WHEN  SoldAsVacant = 'N' then 'NO'
	 ELSE  SoldAsVacant
	 END
FROM   [Portfolio Project 2].dbo.[Nashvile Housing]

UPDATE [Portfolio Project 2].dbo.[Nashvile Housing]
SET  SoldAsVacant = case when  SoldAsVacant = 'Y' then 'YES'
     WHEN  SoldAsVacant = 'N' then 'NO'
	 ELSE  SoldAsVacant
	 END


	WITH RownumCTE as (
	select *,
	row_number() over(
	partition by parcelID,
			   propertyaddress,
			   SalePrice,
			   SaleDate,
			   LegalReference
			   order by uniqueID
			   )row_num
	from [Portfolio Project 2].dbo.[Nashvile Housing]
	)
	select *
	from RownumCTE
	where row_num > 1
	--order by propertyaddress


	ALTER TABLE [Portfolio Project 2].dbo.[Nashvile Housing]
	DROP column propertyaddress,saledate,owneraddress


	Select * 
from [Portfolio Project 2].dbo.[Nashvile Housing]
