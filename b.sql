-- TASK: Find all reachable pages from 'home' whose names contain the substring ref or polic (case-sensitive)_
-- INSTRUCTIONS
-- 1. Write a recursive CTE paths(src,tgt) starting from 'home'
-- 2. In the final query, filter with a regex condition:
--      WHERE tgt ~*'(ref|polic)'.
-- 3. Return distinct reachable target page names.
WITH RECURSIVE paths(src, tgt) AS (
--  base case: starting from 'home;
    SELECT source, target
    FROM pagelinks
    WHERE source = 'home'

    UNION
--  recursive step: follow links from each reached page
    SELECT pl.source AS src, pl.target AS tgt
    FROM paths p JOIN pagelinks pl ON p.tgt = pl.source
)
-- filter with the regex condition
SELECT DISTINCT tgt
FROM paths
WHERE tgt ~*'(ref|polic)'