-- TASK: Find all products in category 'electronics' that have at least one review comment containing the words 'defect' or 'broken' (case-sensitive)
-- INSTRUCTIONS
-- 1. Join Product and Review on pid
-- 2. Use unnest(comments) to expand each array element.
-- 3. Filter using regex:
--      WHERE comment ~*'(defect|broken)'
-- 4. Return distinct product names and matching comments.
SELECT DISTINCT p.pname AS pname, comment AS matching_comment
FROM product p JOIN review r ON p.pid = r.pid
CROSS JOIN LATERAL unnest(r.comments) AS comment
WHERE p.category = 'electronics' AND comment ~*'(defect|broken)';