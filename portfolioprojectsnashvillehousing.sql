use portfolioprojects;

select * from nashvillehousing;

------standardizing date format---------

select  SaleDate,convert(date,saledate)
from nashvillehousing;

update  nashvillehousing
set saledate=convert(date,saledate);

alter table nashvillehousing
add saledateconverted date;

update nashvillehousing
set saledateconverted = convert(date,saledate);

---------populate property address data---------------


select PropertyAddress
from nashvillehousing
where propertyaddress is null;

select * from nashvillehousing
order by parcelid;

select * from nashvillehousing a
join nashvillehousing b
on a.ParcelID =b.ParcelID;

select * from nashvillehousing a
join nashvillehousing b
on a.ParcelID = b.ParcelID and
a.[UniqueID ]<>b.[UniqueID ];

select a.parcelID,a.propertyaddress,b.parcelID,b.propertyaddress from
nashvillehousing a
join nashvillehousing b
on a.ParcelID = b.ParcelID and
a.[UniqueID ]<>b.[UniqueID ];

select a.parcelID,a.propertyaddress,b.parcelID,b.propertyaddress from
nashvillehousing a
join nashvillehousing b
on a.ParcelID = b.ParcelID and
a.[UniqueID ]<>b.[UniqueID ]
where a.propertyaddress is null;

select a.parcelID,a.propertyaddress,b.parcelID,b.propertyaddress,isnull(a.propertyaddress,b.propertyaddress)
from
nashvillehousing a
join nashvillehousing b 
on a.ParcelID = b.ParcelID and
a.[UniqueID ]<>b.[UniqueID ]
where a.propertyaddress is null;

update a 
set propertyaddress =isnull(a.propertyaddress,b.propertyaddress)
from nashvillehousing a join nashvillehousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null;

----------breaking address into individual columns (address,city,state)-----------

select propertyaddress from
nashvillehousing;

select substring(propertyaddress,1,charindex(',',propertyaddress) -1) as address
from nashvillehousing;

select substring(propertyaddress,1,charindex(',',propertyaddress) -1) as address
,SUBSTRING(propertyaddress,charindex(',',propertyaddress) +1,LEN(PropertyAddress)) as address
from nashvillehousing;

alter table nashvillehousing
add propertysplitaddress nvarchar(255);

update nashvillehousing
set propertysplitaddress =  substring(propertyaddress,1,charindex(',',propertyaddress) -1);

alter table nashvillehousing
add propertysplitcity nvarchar(255);

update nashvillehousing
set propertysplitcity =SUBSTRING(propertyaddress,charindex(',',propertyaddress) +1,LEN(PropertyAddress));

select * from nashvillehousing;

select OwnerAddress from nashvillehousing;

select PARSENAME( REPLACE( OwnerAddress,',','-'),  3),
PARSENAME( REPLACE( OwnerAddress,',','-'),  2),
PARSENAME( REPLACE( OwnerAddress,',','-'),  1)
from nashvillehousing;


alter table nashvillehousing
add ownersplitaddress nvarchar(255);

update nashvillehousing
set ownersplitaddress = PARSENAME( REPLACE( OwnerAddress,',','-'),  3);

alter table nashvillehousing
add ownersplitcity nvarchar(255);

update nashvillehousing
set ownersplitcity = PARSENAME( REPLACE( OwnerAddress,',','-'),  2);

alter table nashvillehousing
add ownersplitstate nvarchar(255);

update nashvillehousing
set ownersplitstate = PARSENAME( REPLACE( OwnerAddress,',','-'),  1);

--------------change Y & N to yes and No in 'sold as vacant ' field---------------------

select distinct(soldAsVacant ),COUNT(soldAsVacant )
from nashvillehousing
group by soldAsVacant
order by 2;

select soldAsVacant 
,case   when soldAsVacant ='Y'then 'Yes'
        when soldAsVacant ='N'then 'No'
        else  soldAsVacant 
        end 
		from nashvillehousing;

		update nashvillehousing
		set SoldAsVacant =case   when soldAsVacant ='Y'then 'Yes'
        when soldAsVacant ='N'then 'No'
        else  soldAsVacant 
        end 
		from nashvillehousing;

		-----------------removing duplicates--------------------

select *,
row_number() over(
partition by parcelID,propertyaddress,saleprice,saledate,legalreference
order by uniqueID)row_number
from nashvillehousing;

with RownumCTE as(
select *,
row_number() over(
partition by 
parcelID,propertyaddress,saleprice,saledate,legalreference
order by uniqueID) row_num
from nashvillehousing)
delete  from RownumCTE
where row_num >1
---order by propertyaddress;

with RownumCTE as(
select *,
row_number() over(
partition by 
parcelID,propertyaddress,saleprice,saledate,legalreference
order by uniqueID) row_num
from nashvillehousing)
select *  from RownumCTE
where row_num >1
order by propertyaddress;


--------deleting unused columns from table-----------


select * from nashvillehousing;

alter table nashvillehousing
drop column owneraddress,taxdistrict,propertyaddress,saledate;


