-- Pivot the Occupation column in OCCUPATIONS so that each Name is sorted alphabetically 
-- and displayed underneath its corresponding Occupation. 
-- The output column headers should be Doctor, Professor, Singer, and Actor, respectively.

-- Note: Print NULL when there are no more names corresponding to an occupation.

-- Input Format

-- The OCCUPATIONS table is described as follows:

-- Occupation will only contain one of the following values: Doctor, Professor, Singer or Actor.

-- Sample Input

-- Sample Output

-- Jenny    Ashley     Meera  Jane
-- Samantha Christeen  Priya  Julia
-- NULL     Ketty      NULL   Maria

-- Explanation

-- The first column is an alphabetically ordered list of Doctor names.
-- The second column is an alphabetically ordered list of Professor names.
-- The third column is an alphabetically ordered list of Singer names.
-- The fourth column is an alphabetically ordered list of Actor names.
-- The empty cell data for columns with less than the maximum number of names per occupation (in this case,
-- the Professor and Actor columns) are filled with NULL values.


WITH CTP_SORT AS (
                SELECT *,
                ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY NAME) AS ROW_RANK
                FROM OCCUPATIONS
),  CTP_PIVOT AS (
                SELECT ROW_RANK,
                MAX(CASE WHEN OCCUPATION = 'Doctor' THEN NAME ELSE NULL END ) AS DOCTOR,
                MAX(CASE WHEN OCCUPATION = 'Professor' THEN NAME ELSE NULL END ) AS PROFESSOR,
                MAX(CASE WHEN OCCUPATION = 'Singer' THEN NAME ELSE NULL END ) AS SINGER,
                MAX(CASE WHEN OCCUPATION = 'Actor' THEN NAME ELSE NULL END ) AS ACTOR
                FROM CTP_SORT
                GROUP BY ROW_RANK
) SELECT 
            DOCTOR,
            PROFESSOR,
            SINGER,
            ACTOR
FROM CTP_PIVOT
ORDER BY ROW_RANK;


-- OUTPUT

    -- Aamina Ashley Christeen Eve

    -- Julia Belvet Jane Jennifer

    -- Priya Britney Jenny Ketty

    -- NULL Maria Kristeen Samantha

    -- NULL Meera NULL NULL

    -- NULL Naomi NULL NULL

    -- NULL Priyanka NULL NULL


            