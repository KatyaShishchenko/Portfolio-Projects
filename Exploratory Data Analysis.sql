-- Explonatory Data Analysys

-- 1. This is the initial step to gain a general overview of the data's structure and content.
SELECT *
FROM layoffs_staging2; 

-- 2. Identifying the maximum values for 'total_laid_off' and 'percentage_laid_off' aids to understand the scale and range of these key layoff metrics.
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2; 

-- 3. The we will retrieve all records where 'percentage_laid_off' equals 1 (100%) to prioritize the largest impacts.
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;

-- 4. Next, we calculate the total number of layoffs for each company, starting with the companies that had the most significant layoffs.
SELECT company, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- 5. Then we determine the earliest and latest dates in the dataset to understand the time span covered by the layoff data.
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- 6. The following step determines the total number of layoffs by industry to identify the most affected industries.
SELECT industry, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- 7. Next, we will perform the same calculation for each country to identify the countries with the highest layoff counts.
SELECT country, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- 8. In the next step, we conduct the same report but for the date to see recent trends first.
SELECT `date`, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY `date`
ORDER BY 1 DESC;

-- 9. To analyze yearly trends, we extract the year from the date.
SELECT YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- 10. The next step shows trends for companies at various investment stages to understand which stages experience more layoffs.
SELECT stage, SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- 11. Let's examine the layoff percentages for each company, which indicate those with multiple layoff events and significant impact.
SELECT company, SUM(percentage_laid_off)
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- 12. This command generates a monthly trend of layoffs, arranged in chronological order.
SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off)
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
group by `MONTH`
ORDER BY 1 ASC;

-- 13. In this section, we calculate the total number of layoffs on a rolling monthly basis.
WITH Rolling_Total AS
(
SELECT substring(`date`,1,7) AS `MONTH`, SUM(total_laid_off) AS total_off
FROM layoffs_staging2
WHERE substring(`date`,1,7) IS NOT NULL
group by `MONTH`
ORDER BY 1 ASC
)
SELECT `MONTH`, total_off, 
SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_Total;

-- 14. Next, we identify the total number of layoffs for each company by year.
SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

-- 15. The next stage of the analysis includes investigating the top five companies with the highest number of layoffs.
WITH Company_Year (company, years, total_laid_off) AS
(SELECT company, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), Company_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE Ranking <=5
;

-- 16. We conduct the same calculation for the top five industries with the most layoffs per year.
WITH Industry_Year (industry, years, total_laid_off) AS
(SELECT industry, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY industry, YEAR(`date`)
), Industry_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Industry_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Industry_Year_Rank
WHERE Ranking <=5;

-- 17. Eventually, let’s identify the top five countries with the highest number of layoffs.
WITH Country_Year (country, years, total_laid_off) AS
(SELECT country, YEAR(`date`), SUM(total_laid_off)
FROM layoffs_staging2
GROUP BY country, YEAR(`date`)
), Country_Year_Rank AS
(SELECT *, 
DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Country_Year
WHERE years IS NOT NULL
)
SELECT *
FROM Country_Year_Rank
WHERE Ranking <=5;
