CREATE DATABASE Nashville_Housing;

USE Nashville_Housing
GO

SELECT * 
from Nashville_housing_data_2013_2016;

SELECT COUNT(*) AS TotalRows
from Nashville_housing_data_2013_2016;

SELECT 
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN [Suite  Condo   #] = '' THEN 1 ELSE 0 END) AS Null_Suite,
    SUM(CASE WHEN [Property Address] = '' THEN 1 ELSE 0 END) AS Null_PropertyAddress

FROM Nashville_housing_data_2013_2016;   


SELECT
    COUNT(*) AS TotalRows,

    -- Identity columns
    SUM(CASE WHEN [Parcel ID]        = '' OR [Parcel ID]        = 'NULL' THEN 1 ELSE 0 END) AS Missing_ParcelID,

    -- Property details
    SUM(CASE WHEN [Land Use]         = '' OR [Land Use]         = 'NULL' THEN 1 ELSE 0 END) AS Missing_LandUse,
    SUM(CASE WHEN [Property Address] = '' OR [Property Address] = 'NULL' THEN 1 ELSE 0 END) AS Missing_PropertyAddress,
    SUM(CASE WHEN [Suite  Condo   #] = '' OR [Suite  Condo   #] = 'NULL' THEN 1 ELSE 0 END) AS Missing_Suite,
    SUM(CASE WHEN [Property City]    = '' OR [Property City]    = 'NULL' THEN 1 ELSE 0 END) AS Missing_PropertyCity,

    -- Sale details
    SUM(CASE WHEN [Sale Date]        = '' OR [Sale Date]        = 'NULL' THEN 1 ELSE 0 END) AS Missing_SaleDate,
    SUM(CASE WHEN [Sale Price]       = '' OR [Sale Price]       = 'NULL' THEN 1 ELSE 0 END) AS Missing_SalePrice,
    SUM(CASE WHEN [Legal Reference]  = '' OR [Legal Reference]  = 'NULL' THEN 1 ELSE 0 END) AS Missing_LegalReference,
    SUM(CASE WHEN [Sold As Vacant]   = '' OR [Sold As Vacant]   = 'NULL' THEN 1 ELSE 0 END) AS Missing_SoldAsVacant,

    -- Owner details
    SUM(CASE WHEN [Owner Name]       = '' OR [Owner Name]       = 'NULL' THEN 1 ELSE 0 END) AS Missing_OwnerName,
    SUM(CASE WHEN [Address]          = '' OR [Address]          = 'NULL' THEN 1 ELSE 0 END) AS Missing_OwnerAddress,
    SUM(CASE WHEN [City]             = '' OR [City]             = 'NULL' THEN 1 ELSE 0 END) AS Missing_OwnerCity,
    SUM(CASE WHEN [State]            = '' OR [State]            = 'NULL' THEN 1 ELSE 0 END) AS Missing_OwnerState,

    -- Property characteristics
    SUM(CASE WHEN [Acreage]          = '' OR [Acreage]          = 'NULL' THEN 1 ELSE 0 END) AS Missing_Acreage,
    SUM(CASE WHEN [Neighborhood]     = '' OR [Neighborhood]     = 'NULL' THEN 1 ELSE 0 END) AS Missing_Neighborhood,
    SUM(CASE WHEN [Year Built]       = '' OR [Year Built]       = 'NULL' THEN 1 ELSE 0 END) AS Missing_YearBuilt,
    SUM(CASE WHEN [Bedrooms]         = '' OR [Bedrooms]         = 'NULL' THEN 1 ELSE 0 END) AS Missing_Bedrooms,
    SUM(CASE WHEN [Full Bath]        = '' OR [Full Bath]        = 'NULL' THEN 1 ELSE 0 END) AS Missing_FullBath,
    SUM(CASE WHEN [Half Bath]        = '' OR [Half Bath]        = 'NULL' THEN 1 ELSE 0 END) AS Missing_HalfBath,
    SUM(CASE WHEN [Finished Area]    = '' OR [Finished Area]    = 'NULL' THEN 1 ELSE 0 END) AS Missing_FinishedArea,
    SUM(CASE WHEN [Foundation Type]  = '' OR [Foundation Type]  = 'NULL' THEN 1 ELSE 0 END) AS Missing_FoundationType,
    SUM(CASE WHEN [Exterior Wall]    = '' OR [Exterior Wall]    = 'NULL' THEN 1 ELSE 0 END) AS Missing_ExteriorWall,
    SUM(CASE WHEN [Grade]            = '' OR [Grade]            = 'NULL' THEN 1 ELSE 0 END) AS Missing_Grade,

    -- Value columns
    SUM(CASE WHEN [Land Value]       = '' OR [Land Value]       = 'NULL' THEN 1 ELSE 0 END) AS Missing_LandValue,
    SUM(CASE WHEN [Building Value]   = '' OR [Building Value]   = 'NULL' THEN 1 ELSE 0 END) AS Missing_BuildingValue,
    SUM(CASE WHEN [Total Value]      = '' OR [Total Value]      = 'NULL' THEN 1 ELSE 0 END) AS Missing_TotalValue

FROM Nashville_housing_data_2013_2016;

SELECT [Sold As Vacant], COUNT(*) AS Frequency
FROM Nashville_housing_data_2013_2016
GROUP BY [Sold As Vacant]
order by Frequency DESC;

SELECT TOP 5 [Sale Date]
FROM Nashville_housing_data_2013_2016

SELECT TOP 5 [image]
FROM Nashville_housing_data_2013_2016
WHERE [image] != '';


ALTER TABLE Nashville_housing_data_2013_2016 DROP COLUMN [Suite  Condo   #]
ALTER TABLE Nashville_housing_data_2013_2016 DROP COLUMN [Owner Name], [Address], [City], [State]
ALTER TABLE Nashville_housing_data_2013_2016 DROP COLUMN [No]
ALTER TABLE Nashville_housing_data_2013_2016 DROP COLUMN [image]


SELECT * 
from Nashville_housing_data_2013_2016;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Nashville_housing_data_2013_2016'
ORDER BY ORDINAL_POSITION;

-- Running Copy
USE Nashville_Housing;
SELECT *
INTO NashvilleHousing_Clean
FROM Nashville_housing_data_2013_2016;

SELECT COUNT(*) AS TotalRows
FROM NashvilleHousing_Clean;

-- Fixing sold as vacant
SELECT *
FROM NashvilleHousing_Clean
WHERE [Sold As Vacant] NOT IN ('Yes', 'No')
AND [Sold As Vacant] != '';

UPDATE NashvilleHousing_Clean
SET [Sold As Vacant] = NULL
WHERE [Sold As Vacant] = '';

UPDATE NashvilleHousing_Clean
SET [Sold As Vacant] = NULL
WHERE [Sold As Vacant] NOT IN ('Yes', 'No');

SELECT [Sold As Vacant], COUNT(*) As Frequency
FROM NashvilleHousing_Clean
Group By [Sold As Vacant]
Order by Frequency DESC;

SELECT [Sale Date], COUNT(*) AS Frequency
FROM NashvilleHousing_Clean
WHERE [Sale Date] != ''
GROUP BY [Sale Date]
ORDER by Frequency DESC;

ALTER TABLE NashvilleHousing_Clean
ADD SaleDate_Clean Date;


Select [Sale Date]
From NashvilleHousing_Clean
WHERE TRY_CONVERT(DATE, [Sale Date], 101) is null 
and [Sale Date] != '' AND [Sale Date] IS NOT NULL;

UPDATE NashvilleHousing_Clean
SET [Sale Date] = NULL
WHERE TRY_CONVERT(DATE, [Sale Date], 101) is null 
and [Sale Date] != '' AND [Sale Date] IS NOT NULL;

UPDATE NashvilleHousing_Clean
SET SaleDate_Clean = CONVERT(DATE, [Sale Date], 101)
WHERE [Sale Date] != '' AND [Sale Date] IS NOT NULL;

SELECT *
FROM NashvilleHousing_Clean

-- Format Checks
SELECT DISTINCT [Sale Price]
FROM NashvilleHousing_Clean
WHERE ISNUMERIC([Sale Price]) = 0
AND [Sale Price] != ''
AND [Sale Price] IS NOT NULL;

SELECT COUNT(*) AS ShiftedRows
FROM NashvilleHousing_Clean
WHERE ISNUMERIC([Sale Price]) = 0
and [Sale Price]!= ''
and [Sale Price] is not null;


SELECT DISTINCT [Year Built]
FROM NashvilleHousing_Clean
WHERE ISNUMERIC([Year Built]) = 0
AND [Year Built] != ''
AND [Year Built] IS NOT NULL;

SELECT COUNT(*) AS ShiftedRows
FROM NashvilleHousing_Clean
WHERE ISNUMERIC([Year Built]) = 0
and [Year Built]!= ''
and [Year Built] is not null;

SELECT DISTINCT [Acreage]
FROM NashvilleHousing_Clean
WHERE ISNUMERIC([Acreage]) = 0
AND [Acreage] != ''
AND [Acreage] IS NOT NULL;

SELECT COUNT(*) AS ShiftedRows
FROM NashvilleHousing_Clean
WHERE ISNUMERIC([Acreage]) = 0
and [Acreage]!= ''
and [Acreage] is not null;


-- Fixing Sale Price
UPDATE NashvilleHousing_Clean
SET [Sale Price] = NULL
WHERE ISNUMERIC([Sale Price]) = 0
AND [Sale Price] != ''
AND [Sale Price] IS NOT NULL;

-- Clean and Update Numeric Column
Alter Table NashvilleHousing_Clean
ADD SalePriceClean INT;

Update NashvilleHousing_Clean
Set SalePriceClean = Cast([Sale Price] as INT)
Where [Sale Price] is not null
and [Sale Price] != ''

-- Verify 
SELECT
    COUNT(*) AS TotalRows,
    SUM(Case When SalePriceClean is null then 1 else 0 end) as NullCount,
    Min(SalePriceClean) as MinPrice,
    Max(SalePriceClean) as MaxPrice,
    Avg(CAST(SalePriceClean as bigint)) as AvgPrice
FROM NashvilleHousing_Clean;

-- Fixing Year Built
Update NashvilleHousing_Clean
Set [Year Built] = Null
Where ISNUMERIC([Year Built]) = 0
And [Year Built] != ''
And [Year Built] Is not Null;

-- Add and populate clean column
Alter table NashvilleHousing_Clean
Add YearBuiltClean INT;

Update NashvilleHousing_Clean
Set YearBuiltClean = Floor(Cast([Year Built] as FLOAT))
Where [Year Built] is not null
and [Year Built] != ''
and isnumeric([Year Built]) = 1;

SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN YearBuiltClean is null THEN 1 ELSE 0 END) AS NullCount,
    MIN(YearBuiltClean) AS OldestYear,
    MAX(YearBuiltClean) AS NewestYear
FROM NashvilleHousing_Clean;


-- Fixing Acreage

Update NashvilleHousing_Clean
Set [Acreage] = Null
Where ISNUMERIC([Acreage]) = 0
And [Acreage] != ''
And [Acreage] Is not Null;

-- Add and populate clean column
Alter table NashvilleHousing_Clean
Add AcreageClean INT;

Update NashvilleHousing_Clean
Set AcreageClean = Floor(Cast([Acreage] as FLOAT))
Where [Acreage] is not null
and [Acreage] != ''
and isnumeric([Acreage]) = 1;

SELECT
    COUNT(*) AS TotalRows,
    SUM(CASE WHEN AcreageClean is null THEN 1 ELSE 0 END) AS NullCount,
    MIN(AcreageClean) AS MinAcreage,
    MAX(AcreageClean) AS MaxAcreage,
    AVG(AcreageClean) AS AvgAcreage
FROM NashvilleHousing_Clean;

SELECT
    a.[Parcel ID],
    a.[Property Address] AS Missing_Address,
    b.[Property Address] AS Available_Address
FROM dbo.NashvilleHousing_Clean a
JOIN dbo.NashvilleHousing_Clean b
    ON a.[Parcel ID] = b.[Parcel ID]
    AND a.[Property Address] != b.[Property Address]
WHERE a.[Property Address] = ''
OR a.[Property Address] IS NULL;


UPDATE a
SET a.[Property Address] = ISNULL(a.[Property Address], b.[Property Address])
FROM NashvilleHousing_Clean a 
JOIN NashvilleHousing_Clean b
    ON a.[Parcel ID] = b.[Parcel ID]
    AND a.[Property Address] != b.[Property Address]
WHERE a.[Property Address] = ''
OR a.[Property Address] IS NULL;


SELECT COUNT(*) AS StillMissing
FROM NashvilleHousing_Clean
WHERE [Property Address] = ''
OR [Property Address] is NULL;

-- Removing Duplicates 

--Find Duplicates
WITH DuplicateCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                [Parcel ID],
                [Property Address],
                [Sale Price],
                [Sale Date],
                [Legal Reference]
            ORDER BY [Parcel ID]
        ) AS RowNum
    FROM NashvilleHousing_Clean
)
SELECT *
FROM DuplicateCTE
WHERE RowNum > 1;

-- Verifying duplicates
SELECT *
FROM NashvilleHousing_Clean
WHERE [Parcel ID] = '164 07 0A 163.00'
ORDER BY [Sale Date], [Sale Price];


-- Deleting Duplicates
WITH DuplicateCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                [Parcel ID],
                [Property Address],
                [Sale Price],
                [Sale Date],
                [Legal Reference]
            ORDER BY [Parcel ID]
        ) AS RowNum
    FROM NashvilleHousing_Clean
)
DELETE FROM DuplicateCTE
WHERE RowNum > 1;

-- Verify Delete 
SELECT COUNT(*) AS RemainingRows
FROM NashvilleHousing_Clean;

WITH DuplicateCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY
                [Parcel ID],
                [Property Address],
                [Sale Price],
                [Sale Date],
                [Legal Reference]
            ORDER BY [Parcel ID]
        ) AS RowNum
    FROM NashvilleHousing_Clean
)
SELECT COUNT(*) AS RemainingRows
FROM DuplicateCTE
WHERE RowNum > 1;


SELECT TOP 20 *
FROM NashvilleHousing_Clean;

-- Naming inconsistencies
SELECT [Land Use], COUNT(*) AS Frequency
FROM NashvilleHousing_Clean
GROUP BY [Land Use]
ORDER BY Frequency DESC;

UPDATE NashvilleHousing_Clean
SET [Land Use] = 'VACANT RESIDENTIAL LAND'
Where [Land Use] IN(
    'VACANT RES LAND', 'VACANT RESIDENTIAL LAND');

UPDATE NashvilleHousing_Clean
SET [Land Use] = 'RESIDENTIAL CONDO'
Where [Land Use] IN ('CONDO');

UPDATE NashvilleHousing_Clean
SET [Land Use] = NULL
Where [Land Use] LIKE '"%'
OR [Land Use] = '';



-- Analysis

-- 1. Most selling Property Type by Land Use

SELECT
    [Land Use]  AS PropertyType,
    COUNT(*)    AS TotalSales,
    AVG(CAST(SalePriceClean AS BIGINT)) AS AvgSalePrice,
    MIN(SalePriceClean) AS MinSalePrice,
    MAX(SalePriceClean) AS MaxSalePrice,

    ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER(), 2) AS PctofTotalSale

FROM NashvilleHousing_Clean
WHERE SalePriceClean IS NOT NULL
AND SalePriceClean > 0
Group by [Land Use]
Order by TotalSales Desc;

-- 2. Average Sale Per Year
SELECT
    YEAR([SaleDate_Clean]) as SaleYear,
    COUNT(*) AS TotalSale,
    AVG(CAST(SalePriceClean AS BIGINT)) AS AvgSalePrice,
    MIN(SalePriceClean) AS MinSalePrice,
    MAX(SalePriceClean) AS MaxSalePrice
FROM NashvilleHousing_Clean
WHERE [SalePriceClean] IS NOT NULL
    AND SalePriceClean > 0
Group by YEAR([SaleDate_Clean])
Order by TotalSale Desc;

-- Checking for 2016 data
SELECT
    YEAR([SaleDate_Clean]) as SaleYear,
    MONTH([SaleDate_Clean]) as SaleMonth,
    COUNT(*) AS TotalSale
FROM NashvilleHousing_Clean
WHERE YEAR(SaleDate_Clean) = 2016
AND SaleDate_Clean IS NOT NULL
GROUP BY YEAR(SaleDate_Clean), MONTH(SaleDate_Clean)
ORDER BY SaleMonth;


-- 3. Vacant property vs occupied property sale price
SELECT
    
    [Sold As Vacant] AS VacantStatus,
    AVG(CAST(SalePriceClean as bigint)) AS AvgPrice,
    MIN(SalePriceClean) AS MinSalePrice,
    MAX(SalePriceClean) AS MaxSalePrice,
    COUNT(*) AS TotalSale
FROM NashvilleHousing_Clean
WHERE [Sold As Vacant] IS NOT NULL and SalePriceClean > 0
GROUP BY [Sold As Vacant]
ORDER BY AvgPrice DESC;

-- identifying transfer scenarios
SELECT *
FROM NashvilleHousing_Clean
WHERE SalePriceClean BETWEEN 1 AND 100
AND SalePriceClean IS NOT NULL;

-- 4. Buying with $500k budget
Select
    
    [Property City] as Location,
    AVG(CAST(SalePriceClean as bigint)) AS AvgSalePrice,
    MIN(SalePriceClean) AS MinSalePrice,
    MAX(SalePriceClean) AS MaxSalePrice,
    COUNT(*) AS TotalSale
FROM NashvilleHousing_Clean
Where SalePriceClean > 100
And [Property City] is not null
And [Property City] != ''
GROUP BY [Property City]
ORDER BY AvgSalePrice DESC;

SELECT TOP 20 *
FROM NashvilleHousing_Clean;


-- 5. Three Month Rollback

-- Avg sale by month and year
SELECT
    YEAR(SaleDate_Clean) AS SaleYear,
    MONTH(SaleDate_Clean) AS SaleMonth,
    COUNT(*) AS TotalSales,
    AVG(CAST(SalePriceClean AS BIGINT)) AS AvgSalePrice
FROM NashvilleHousing_Clean
WHERE SaleDate_Clean IS NOT NULL
AND SalePriceClean IS NOT NULL
AND SalePriceClean > 100
GROUP BY
    YEAR(SaleDate_Clean),
    MONTH(SaleDate_Clean)
ORDER BY SaleYear, SaleMonth

-- Rolling Average using CTE 
WITH MonthlyAvg AS(
    SELECT
        YEAR(SaleDate_Clean)    AS SaleYear,
        MONTH(SaleDate_Clean)   AS SaleMonth,
        COUNT(*)                AS TotalSales,
        AVG(CAST(SalePriceClean AS BIGINT)) AS AvgMonthlyPrice
    FROM NashvilleHousing_Clean
    WHERE SaleDate_Clean is not null
    AND SalePriceClean IS NOT NULL
    AND SalePriceClean > 100
    GROUP BY
        YEAR(SaleDate_Clean),
        MONTH(SaleDate_Clean)
),

-- Creating a single sortable number
MonthlyWithPeriod AS (
    SELECT *,
        (SaleYear * 100 + SaleMonth) AS YearMonth
    FROM MonthlyAvg
)
SELECT
    SaleYear,
    SaleMonth,
    TotalSales,
    AvgMonthlyPrice,

    AVG(CAST(AvgMonthlyPrice AS BIGINT)) OVER(
        ORDER BY YearMonth
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS Rolling3MonthAvg
FROM MonthlyWithPeriod
ORDER BY YearMonth;


-- Checking Jan 2015 spike
SELECT
    [Property Address],
    [Property City],
    [Land Use],
    SalePriceClean
FROM NashvilleHousing_Clean
WHERE YEAR(SaleDate_Clean) = 2015
AND MONTH(SaleDate_Clean) = 1
AND SalePriceClean > 1000000
ORDER BY SalePriceClean DESC;


-- 6. Property Flip Detection
SELECT
    a.[Parcel ID],
    a.[Property Address],
    a.[Property City],
    a.[Land Use],
    a.SaleDate_Clean     AS FirstSaleDate,
    a.SalePriceClean     AS FirstSalePrice,
    b.SaleDate_Clean     AS SecondSaleDate,
    b.SalePriceClean     AS SecondSalePrice,
    DATEDIFF(DAY, a.SaleDate_Clean, b.SaleDate_Clean) AS DaysBetweenSales,

    -- checking profit/loss %
    CAST((b.SalePriceClean - a.SalePriceClean) AS bigint) AS ProfitLoss,
    ROUND(
    (CAST(b.SalePriceClean AS BIGINT) - CAST(a.SalePriceClean AS BIGINT)) * 100.0 /
    NULLIF(a.SalePriceClean, 0), 1) AS PctChange

FROM NashvilleHousing_Clean a
JOIN NashvilleHousing_Clean b
    ON a.[Parcel ID] = b.[Parcel ID]
    AND b.SaleDate_Clean > a.SaleDate_Clean
    AND DATEDIFF(DAY, a.SaleDate_Clean, b.SaleDate_Clean) <= 365
WHERE a.SalePriceClean > 100
AND b.SalePriceClean > 100
AND a.SaleDate_Clean IS NOT NULL
AND b.SaleDate_Clean IS NOT NULL
ORDER BY PctChange DESC;


-- Realistic single property for investments

SELECT
    [Parcel ID],
    [Property Address],
    [Property City],
    [Land Use],
    FirstSaleDate,
    FirstSalePrice,
    SecondSaleDate,
    SecondSalePrice,
    DaysBetweenSales,
    ProfitLoss,
    PctChange
FROM (
    SELECT
        a.[Parcel ID],
        a.[Property Address],
        a.[Property City],
        a.[Land Use],
        a.SaleDate_Clean                                                          AS FirstSaleDate,
        a.SalePriceClean                                                         AS FirstSalePrice,
        b.SaleDate_Clean                                                          AS SecondSaleDate,
        b.SalePriceClean                                                         AS SecondSalePrice,
        DATEDIFF(DAY, a.SaleDate_Clean, b.SaleDate_Clean)                         AS DaysBetweenSales,
        CAST(b.SalePriceClean AS BIGINT) - CAST(a.SalePriceClean AS BIGINT)     AS ProfitLoss,
        ROUND(
            (CAST(b.SalePriceClean AS BIGINT) - CAST(a.SalePriceClean AS BIGINT)) * 100.0 /
            NULLIF(a.SalePriceClean, 0)
        , 1)                                                                     AS PctChange
    FROM NashvilleHousing_Clean a
    JOIN NashvilleHousing_Clean b
        ON a.[Parcel ID] = b.[Parcel ID]
        AND b.SaleDate_Clean > a.SaleDate_Clean
        AND DATEDIFF(DAY, a.SaleDate_Clean, b.SaleDate_Clean) <= 365
    WHERE a.SalePriceClean > 1000        
    AND b.SalePriceClean > 1000
    AND b.SalePriceClean < 2000000       
    AND a.SalePriceClean IS NOT NULL
    AND b.SalePriceClean IS NOT NULL
    AND a.SaleDate_Clean IS NOT NULL
    AND b.SaleDate_Clean IS NOT NULL
) FlipResults
WHERE PctChange BETWEEN 0 AND 500        
ORDER BY PctChange DESC;